import 'dart:io'; // For getting file size
import 'dart:math'; // For log calculation
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // A state object where logic and state is stored
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // creating state variables
  String? videoName;
  String? videoSize;
  File? videoFile;

  // Function to pick video and update videoName and videoSize state
  Future<void> pickVideo(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      File videoFile = File(video.path);
      // Convert XFile to File to get size
      int sizeInBytes = await videoFile.length(); // Get size in bytes

      setState(() {
        videoName = video.name;
        videoSize = formatBytes(sizeInBytes); // Format the size for display
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video uploaded: ${video.name}')),
      );
    }
  }

  // Function to format bytes into KB, MB, etc.
  String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    double logBase2 = (log(bytes) / log(1024)); // Calculate base-2 logarithm
    int i = logBase2.floor();
    double size = bytes / pow(1024, i);
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  // Function to start video processing
  void processVideo() {
    if (videoFile != null) {
      // Here you would trigger the backend process, such as an HTTP POST request
      // to your server or backend service that processes the video
      // Example: sending the video to a server
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing video...')),
      );

      // After backend processing (simulated with a delay here for demo)
      Future.delayed(const Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video processing completed!')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C242F),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C242F),
        title: Text(
          'G2OCR',
          style: TextStyle(
            color: Color(0xFFF6BA0A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(10),
          child: const Icon(
            Icons.menu,
            color: Color(0xFF000000),
            size: 24.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xFFF6BA0A),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, -100),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Welcome to G2OCR,',
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: const Duration(milliseconds: 100),
                  )
                ],
                repeatForever: true,
                pause: const Duration(seconds: 1),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6BA0A),
                  foregroundColor: Color(0xFF000000)),
              onPressed: () => pickVideo(context),
              child: const Text("Insert your video"),
            ),
            const SizedBox(height: 20),
            // Display the video name and size if uploaded
            videoName != null && videoSize != null
                ? Column(
                    children: [
                      Text(
                        'Uploaded video: $videoName',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF818890)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Size: $videoSize',
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF818890)),
                      ),
                      const SizedBox(height: 20),
                      // Processing button appears only after a video is uploaded
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[500],
                            foregroundColor: Color(0xFF000000)),
                        onPressed: processVideo,
                        child: const Text(
                          'Start Processing',
                        ),
                      ),
                    ],
                  )
                : const Text(
                    'No video uploaded',
                    style: TextStyle(fontSize: 16, color: Color(0xFF818890)),
                  ),
          ],
        ),
      ),
    );
  }
}
