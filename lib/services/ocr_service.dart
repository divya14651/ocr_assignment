import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OCRService {

  static Future<String> extractText(String imagePath) async {
    TextRecognizer textRecognizer = TextRecognizer();

    try {
      final inputImage = InputImage.fromFilePath(imagePath);

      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

      return recognizedText.text;

    } catch (e) {
      print("OCR SERVICE ERROR: $e");
      return "";

    } finally {
      textRecognizer.close();
    }
  }
}