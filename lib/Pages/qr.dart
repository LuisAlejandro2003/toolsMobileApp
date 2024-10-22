import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _flashOn = false; // Variable para controlar el flash

  @override
  void initState() {
    super.initState();
    // Controlador para la animación de la línea de escaneo
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 300).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado dinámico
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B263B), Color(0xFF415A77)], // Degradado moderno
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          MobileScanner(
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Código escaneado: ${barcode.rawValue}',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    backgroundColor: Colors.greenAccent,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
          // Caja de escaneo visual más estilizada
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                      width: 4,
                    ),
                  ),
                ),
                // Animación de la línea de escaneo
                Positioned(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: 300,
                          height: 4,
                          color: Colors.greenAccent,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Texto de instrucciones
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Alinea el código QR dentro del cuadro para escanear',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Botón flotante para el flash
          Positioned(
            bottom: 40,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: _flashOn ? Colors.greenAccent : Colors.grey,
              onPressed: () {
                setState(() {
                  _flashOn = !_flashOn; // Cambia el estado del flash
                });
              },
              child: Icon(
                _flashOn ? Icons.flash_off : Icons.flash_on,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
