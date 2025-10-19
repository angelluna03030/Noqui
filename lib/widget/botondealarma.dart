import 'package:noqui/rutas.dart';

class MensajeAlarma extends StatefulWidget {
  const MensajeAlarma({super.key});

  @override
  State<MensajeAlarma> createState() => _MensajeAlarmaState();
}

class _MensajeAlarmaState extends State<MensajeAlarma>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Velocidad del parpadeo
    )..repeat(reverse: true); // Hace el efecto de prender/apagar
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120,
      right: 270,
      child: FadeTransition(
        opacity: _controller,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.transparent, // 🔴 Fondo rojo
          ),
          onPressed: () {},
          child: const Text(
            "¡Me estafaron!", // 🔴 Nuevo texto
            style: TextStyle(
              color: Colors.red, // Texto en blanco
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
