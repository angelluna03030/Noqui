import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CountUp extends StatefulWidget {
  final double inicio;
  final double fin;
  final Duration duracion;
  final bool soloUnaVez;

  const CountUp({
    super.key,
    required this.inicio,
    required this.fin,
    required this.duracion,
    this.soloUnaVez = true,
  });

  @override
  State<CountUp> createState() => _CountUpState();
}

class _CountUpState extends State<CountUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final NumberFormat _formatter =
      NumberFormat.currency(locale: "es_ES", symbol: "", decimalDigits: 2);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duracion,
    );

    _animation = Tween<double>(
      begin: widget.inicio,
      end: widget.fin,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    if (widget.soloUnaVez) {
      _controller.forward();
    } else {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          _formatter.format(_animation.value), // formato moneda
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        );
      },
    );
  }
}
