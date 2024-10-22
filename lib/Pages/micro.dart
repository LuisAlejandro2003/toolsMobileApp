import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class MicroScreen extends StatefulWidget {
  @override
  _MicroScreenState createState() => _MicroScreenState();
}

class _MicroScreenState extends State<MicroScreen> {
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  String _speechText = '';
  String _selectedLanguage = "en-US";

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    _initializeTts();
  }

  Future<void> _initializeSpeech() async {
    _speech = stt.SpeechToText();
    await _requestMicrophonePermission();
  }

  Future<void> _initializeTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.setLanguage(_selectedLanguage);
  }

  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _startListening() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if (val == 'done') {
            _stopListening();
          }
        },
        onError: (val) => print('Error: $val'),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _speechText = val.recognizedWords;
            });
          },
          localeId: _selectedLanguage,
        );
      }
    } else {
      print("Permisos de micrófono denegados");
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
    _flutterTts.setLanguage(languageCode);
  }

  Future<void> _speak() async {
    if (_speechText.isNotEmpty) {
      await _flutterTts.speak(_speechText);
    } else {
      await _flutterTts.speak('No hay texto para reproducir.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Micrófono',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0D1B2A), // Azul oscuro
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,  // Fondo blanco
                  borderRadius: BorderRadius.circular(20),  // Bordes más suaves
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 3),  // Sombra más marcada
                    ),
                  ],
                ),
                child: Text(
                  _speechText.isEmpty
                      ? 'Presiona el micrófono para empezar a grabar...'
                      : _speechText,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D1B2A),  // Azul oscuro para el texto
                    fontWeight: FontWeight.w500,  // Letra más prominente
                  ),
                  textAlign: TextAlign.center,  // Alineación centrada
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1B263B),  // Azul más claro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: _speak,  // Reproduce el texto al presionar el botón
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1B263B),  // Azul más claro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),  // Más espacio en la parte inferior
        ],
      ),
      backgroundColor: Color(0xFFF5F5F5),  // Fondo gris claro
    );
  }
}
