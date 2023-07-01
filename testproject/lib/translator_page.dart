import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learning_input_image/learning_input_image.dart';
// import 'package:learning_input_image/src/input_image.dart';
// import 'package:learning_input_image/src/input_image.dart';
// import 'dart:ui';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter_camera_ml_vision/flutter_camera_ml_vision.dart';
import 'package:testproject/service/google_translate_service.dart';
// import 'package:camera/camera.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
//  import 'package:learning_input_image/learning_input_image.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

 

  @override
  // ignore: library_private_types_in_public_api
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  bool _isARSupported = false;
  late ArCoreController _arCoreController;
  String _detectedText = '';
  String _translatedText = '';

  @override
  void initState() {
    super.initState();
    initializeCamera();
    checkARSupport();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _arCoreController.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    await _cameraController.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> checkARSupport() async {
    _isARSupported = await ArCoreController.checkArCoreAvailability();
  }
 
  
  

  Future<void> scanText() async {
    try {
      final imageBytes = await _cameraController.takePicture();
      final text = await performOCR(imageBytes);
      final translation = await translateText(text as String);
      setState(() {
        _detectedText = text as String;
        _translatedText = translation;
      });
    } catch (e) {
      ('Error scanning text: $e');
    }
  }

  
  Future<RecognizedText?> performOCR(XFile image) async {
    final File file = File(image.path);
    // final textRecognizer = TextRecognizer();
    // final recognizedText = await textRecognizer.processImage(file);
    // When using for Latin script
    // TextRecognition textRecognition = TextRecognition();
    // // or like this:
    TextRecognition textRecognition = TextRecognition(options: TextRecognitionOptions.Default);
    // Process text recognition...
    RecognizedText? recognizedText = await textRecognition.process(file as InputImage);
    // textRecognizer.close();
    return recognizedText;
  }
//   InputCameraView(
//   canSwitchMode = false,
//   mode = InputCameraMode.gallery,
//   title = 'Text Recognition',
//   onImage = (InputImage image) {
    

//   },
//     // now we can feed the input image into text recognition process
  
// ),

  
  Future<String> translateText(String text) async {
  final googleTranslateService = GoogleTranslateService('YOUR_API_KEY');
  final translatedText =
      await googleTranslateService.translateText(text, 'TARGET_LANGUAGE_CODE');
  return translatedText;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                if (_isCameraInitialized)
                  AspectRatio(
                    aspectRatio: _cameraController.value.aspectRatio,
                    child: CameraPreview(_cameraController),
                  ),
                if (_isARSupported)
                  ArCoreView(
                    onArCoreViewCreated: _onARCoreViewCreated,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Detected Text:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(_detectedText),
          const SizedBox(height: 16),
          const Text(
            'Translated Text:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(_translatedText),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: scanText,
            child: const Text('Scan Text'),
          ),
        ],
      ),
    );
  }

  void _onARCoreViewCreated(ArCoreController controller) {
    _arCoreController = controller;
    // Implement AR overlay logic here using the ArCoreController instance
    // Example: https://pub.dev/packages/arcore_flutter_plugin
  }
}
