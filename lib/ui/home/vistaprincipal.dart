import '../../rutas.dart';

class VistaPrincipal extends StatefulWidget {
  const VistaPrincipal({super.key});

  @override
  State<VistaPrincipal> createState() => _VistaPrincipalState();
}

class _VistaPrincipalState extends State<VistaPrincipal> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 236, 236, 244), // Fondo morado oscuro de Nequi
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 25, 54),
        elevation: 0,
        title: const Text(
          "Hola, Angel Luna",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.help_outline, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.lock_outline, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: width * 0.8,
                child: Container(
                  transform: Matrix4.rotationZ(100 * 3.141592653589793 / -1200),
                  width: width * 0.7,
                  height: width * 0.9,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0198E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                right: 131,
                top: -175,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: width * 0.8,
                  child: Container(
                    transform:
                        Matrix4.rotationZ(-30 * 3.141592653589793 / -200),
                    width: width * 0.7,
                    height: width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0198E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
//
              Positioned(
                right: 153,
                top: -447,
                child: Container(
                  transform: Matrix4.rotationZ(0.5),
                  width: width * 1,
                  height: width * 1,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 53, 25, 54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              //el de la izquierda
              Positioned(
                right: -240,
                top: -440,
                child: Container(
                  transform: Matrix4.rotationZ(0.5),
                  width: width * 1,
                  height: width * 1,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 53, 25, 54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              //

//el del centro
              Positioned(
                right: 157,
                top: -69,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: width * 0.8,
                  child: Container(
                    transform:
                        Matrix4.rotationZ(-10 * 3.141592653589793 / -1500),
                    width: width * 0.6,
                    height: width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 53, 25, 54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Depósito Bajo Monto",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        CountUp(
                          inicio: 100000,
                          fin: 0,
                          duracion: Duration(seconds: 3),
                          soloUnaVez: true, // cambia a true para que se detenga
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Botón Tu plata
              const Positioned(bottom: 120, child: MensajeAlarma()),
            ],
          ),

          // Favoritos
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                      size: 26,
                      Icons.favorite_outline_sharp,
                      color: const Color(0xFF351936)),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Tus favoritos",
                    style: TextStyle(
                        color: const Color(0xFF351936),
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _favoritoItem(Icons.help_outline, "Ayuda", width, () {
            Navigator.pushNamed(context, "Help");
                }),
                _favoritoItem(Icons.wechat_rounded, "Chat", width, () {
                          Navigator.pushNamed(context, "Chat");
                }),
                _favoritoItem(
                    Icons.align_vertical_bottom_outlined, "Metricas", width,
                    () {
                  Navigator.pushNamed(context, "Estadisticas");
                }),
                _favoritoItem(Icons.warning_amber_rounded, "Reporte", width,
                    () {
                 Navigator.pushNamed(context, "Reporte");
                }),
              ],
            ),
          )
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: "Movimientos"),
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Servicios"),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Icon(
          Icons.attach_money,
          color: Colors.white,
          weight: 90,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _favoritoItem(
      IconData icon, String label, double width, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.only(right: 40),
      width: width * 0.15,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: width * 0.15,
              width: width * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: width * 0.07,
                color: const Color(0xFF351936),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.03,
              color: const Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
