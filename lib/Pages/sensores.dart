import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensoresScreen extends StatefulWidget {
  @override
  _SensoresScreenState createState() => _SensoresScreenState();
}

class _SensoresScreenState extends State<SensoresScreen> {
  // Variables para almacenar los datos de los sensores
  String _accelerometer = "Esperando datos...";
  String _gyroscope = "Esperando datos...";
  String _magnetometer = "Esperando datos...";

  @override
  void initState() {
    super.initState();

    // Escucha los datos del acelerómetro
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometer =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });

    // Escucha los datos del giroscopio
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscope =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });

    // Escucha los datos del magnetómetro
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometer =
            'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con degradado para consistencia con las otras vistas
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B263B), Color(0xFF415A77)], // Degradado moderno
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Barra de App con diseño moderno
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Sensores del dispositivo',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            // Contenido de los sensores
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sección del Acelerómetro
                    _buildSensorCard(
                      context,
                      'Acelerómetro',
                      _accelerometer,
                      Icons.speed,
                      Colors.greenAccent,
                    ),
                    SizedBox(height: 20),
                    // Sección del Giroscopio
                    _buildSensorCard(
                      context,
                      'Giroscopio',
                      _gyroscope,
                      Icons.rotate_right,
                      Colors.blueAccent,
                    ),
                    SizedBox(height: 20),
                    // Sección del Magnetómetro
                    _buildSensorCard(
                      context,
                      'Magnetómetro',
                      _magnetometer,
                      Icons.explore,
                      Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar la información de cada sensor en una tarjeta
  Widget _buildSensorCard(
    BuildContext context,
    String sensorName,
    String sensorData,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Fondo blanco con opacidad
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // Desplazamiento de la sombra
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          sensorName,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          sensorData,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
