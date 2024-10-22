import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  // Función para abrir el enlace del repositorio en el navegador
  void _launchURL() async {
    final Uri url = Uri.parse('https://github.com/LuisAlejandro2003/toolsMobileApp.git');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo blanco
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Color(0xFF4E5E80)), // Ícono azul oscuro
            SizedBox(width: 5),
            Text(
              'Retos',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de nuevo proyecto
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5), // Fondo gris claro
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.jpg',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nuevo Proyecto",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50), // Texto gris oscuro
                          ),
                        ),
                        Text(
                          "Repositorio del Proyecto",
                          style: TextStyle(color: Color(0xFF2C3E50)), // Texto gris oscuro
                        ),
                        ElevatedButton(
                          onPressed: _launchURL,
                          child: Text("Ver Repositorio"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E5E80), // Azul oscuro
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Sección de navegación por categorías
              Text(
                "Secciones",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50), // Texto gris oscuro
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem(context, Icons.chat, "Chatbot", '/chat'),
                  _buildCategoryItem(context, Icons.location_on, "Ubicación", '/gps'),
                  _buildCategoryItem(context, Icons.qr_code, "Código QR", '/qr'),
                  _buildCategoryItem(context, Icons.mic, "Micrófono", '/micro'),
                ],
              ),
              SizedBox(height: 20),

              // Sección extra para sensores
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem(context, Icons.sensors, "Sensores", '/sensores'),
                ],
              ),

              // Espacio adicional antes de mostrar la información del estudiante
              SizedBox(height: 40),

              // Información del estudiante como etiquetas estilizadas
              _buildStudentInfo(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir los íconos redondeados de cada sección
  Widget _buildCategoryItem(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFF4E5E80), // Azul oscuro
            radius: 30,
            child: Icon(icon, size: 30, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2C3E50), // Texto gris oscuro
            ),
          ),
        ],
      ),
    );
  }

  // Widget para la información del estudiante sin cuadro delimitante
  Widget _buildStudentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Text(
          "Información del Estudiante",
          style: TextStyle(
            color: Color(0xFF4E5E80), // Azul oscuro
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),

        // Información del estudiante como etiquetas estilizadas
        _buildStudentInfoRow("Nombre", "Luis Alejandro Martinez Montoya"),
        SizedBox(height: 10),
        _buildStudentInfoRow("Grupo", "A"),
        SizedBox(height: 10),
        _buildStudentInfoRow("Grado", "9"),
        SizedBox(height: 10),
        _buildStudentInfoRow("Carrea", "Ingeniería en Software Grupo"),
        SizedBox(height: 10),
        _buildStudentInfoRow("Matrícula", "213021"),
      ],
    );
  }

  // Widget para cada fila de la información del estudiante sin contenedor
  Widget _buildStudentInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: Color(0xFF4E5E80), // Azul oscuro
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: Color(0xFF4E5E80).withOpacity(0.7),
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
 