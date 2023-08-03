import 'dart:async';
import 'dart:math';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:testproject/service/google_translate_service.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:camera/camera.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  late List<CameraDescription> _cameras;
  final bool _isCameraInitialized = false;
  bool _isARSupported = false;
  late ArCoreController _arCoreController;
  String _detectedText = '';
  String _translatedText = '';

  @override
  void initState() {
    super.initState();
    // initializeCamera();
    checkARSupport();
  }

  @override
  void dispose() {
    _arCoreController.dispose();
    super.dispose();
  }

  Future<void> checkARSupport() async {
    _isARSupported = await ArCoreController.checkArCoreAvailability();
  }

  Future<void> scanText() async {
  try {
    // Replace this with your image input logic
    final inputImage = InputImage.fromFilePath('YOUR_IMAGE_FILE_PATH');
    
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
    
    final translation = await translateText(text);
    setState(() {
      _detectedText = text;
      _translatedText = translation;
    });
  } catch (e) {
    print('Error scanning text: $e');
  }
}

  Future<String> translateText(String text) async {
    final googleTranslateService = GoogleTranslateService('YOUR_API_KEY');
    final translatedText = await googleTranslateService.translateText(
        text, 'TARGET_LANGUAGE_CODE');
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

