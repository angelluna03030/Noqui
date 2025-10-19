import '../rutas.dart';
import 'package:flutter/material.dart';

class Entrada extends StatefulWidget {
  const Entrada({super.key});

  @override
  State<Entrada> createState() => _EntradaState();
}

class _EntradaState extends State<Entrada> {
  final TextEditingController _phoneController = TextEditingController();
  String _errorMessage = '';

  bool _validarTelefono(String telefono) {
    // Remover espacios en blanco
    String telefonoLimpio = telefono.replaceAll(' ', '');

    // Validar que tenga 10 dígitos y solo números
    if (telefonoLimpio.length == 10 &&
        RegExp(r'^[0-9]+$').hasMatch(telefonoLimpio)) {
      return true;
    }
    return false;
  }

  void _intentarEntrar() {
    setState(() {
      if (_validarTelefono(_phoneController.text)) {
        _errorMessage = '';
        Navigator.pushNamed(context, "PagesPrincipal");
      } else {
        _errorMessage = '¡Ups! Debes escribir un numero de cel valido';
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 53, 25, 54),
        body: SafeArea(
          child: Column(children: [
            // Spacer para centrar el título
            const Spacer(),

            // Logo o título centrado
            Center(
              child: Text(
                "Noqui",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),

            // Input y botones en la parte inferior
            Padding(
              padding: EdgeInsets.symmetric(
                
                  horizontal: width * 0.05, vertical: height * 0.08),
              child: Column(
                children: [
                  // Campo número de teléfono
                  Container(
                    width: width,
                    height: width * 0.11,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                      border: _errorMessage.isNotEmpty
                          ? Border.all(color: Colors.red, width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "+57",
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.phone,
                            maxLength: 12,
                            onChanged: (value) {
                              if (_errorMessage.isNotEmpty) {
                                setState(() {
                                  _errorMessage = '';
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              hintText: "321 375 4980",
                              hintStyle: TextStyle(
                                  color: Colors.white54, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mensaje de error
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(
                          color: Color(0xFFE6007E),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                  SizedBox(height: height * 0.03),

                  // Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Botón entrar
                      SizedBox(
                        width: width * 0.75,
                        height: height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 223, 25, 142),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: _intentarEntrar,
                          child: const Text(
                            "Entra",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.05),

                      // Botón ícono de dinero
                      Container(
                        width: width * 0.1,
                        height: width * 0.11,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6007E),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
