
import 'package:noqui/rutas.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noqui',
      initialRoute: "/",
      routes: {
        "/": (context) => const MypagesHome(),
        "PagesPrincipal": (context) => const VistaPrincipal(),
        "Estadisticas": (context) => const EstadisticasPage(),
        "Reporte": (context) => const ReporteRoboPage(),
        "Help": (context) => const AyudaPrevencionPage(),
        "Chat": (context) => const NequiAntiScamChat(),
      }
    );
  }
}
class MypagesHome extends StatefulWidget {
  const MypagesHome({super.key});
  @override
  State<MypagesHome> createState() => _MypagesHomeState();
}
class _MypagesHomeState extends State<MypagesHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
backgroundColor: Color.fromARGB(255, 53, 25, 54),
        body: Entrada());
  }
}

