import 'dart:math' show pi, sin;
import '../../rutas.dart';

class AyudaPrevencionPage extends StatefulWidget {
  const AyudaPrevencionPage({Key? key}) : super(key: key);

  @override
  State<AyudaPrevencionPage> createState() => _AyudaPrevencionPageState();
}

class _AyudaPrevencionPageState extends State<AyudaPrevencionPage>
    with TickerProviderStateMixin {
  final Color nequiPurple = const Color(0xFF351936);
  final Color nequiPink = const Color(0xFFE0198E);
  late AnimationController _floatingController;
  late AnimationController _pulseController;
  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  int _selectedCategory = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          _buildAnimatedAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroSection(),
                const SizedBox(height: 24),
                _buildQuickStats(),
                const SizedBox(height: 32),
                _buildCategorySelector(),
                const SizedBox(height: 24),
                _buildContentSection(),
                const SizedBox(height: 32),
                _buildVideoSection(),
                const SizedBox(height: 32),
                _buildTipsSection(),
                const SizedBox(height: 32),
                _buildFAQSection(),
                const SizedBox(height: 32),
                _buildEmergencyContact(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: nequiPurple,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Ayuda y Prevención',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [nequiPurple, nequiPink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: 20,
                child: AnimatedBuilder(
                  animation: _floatingAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _floatingAnimation.value),
                      child: Icon(
                        Icons.security,
                        size: 100,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [nequiPurple, nequiPink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: nequiPink.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            '¡Tu Seguridad es Primero!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Aprende a proteger tu dinero y evitar estafas',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              '95%',
              'Estafas evitables',
              Icons.trending_down,
              Colors.green,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              '24/7',
              'Atención disponible',
              Icons.access_time,
              Colors.blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              '150+',
              'Consejos útiles',
              Icons.lightbulb_outline,
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String value, String label, IconData icon, Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, anim, child) {
        return Transform.scale(
          scale: anim,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: nequiPurple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategorySelector() {
    final categories = [
      {'icon': Icons.warning_amber, 'label': 'Alertas', 'color': Colors.red},
      {'icon': Icons.psychology, 'label': 'Consejos', 'color': Colors.purple},
      {'icon': Icons.school, 'label': 'Aprende', 'color': Colors.blue},
      {'icon': Icons.help_outline, 'label': 'FAQ', 'color': Colors.orange},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [nequiPurple, nequiPink],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? nequiPink.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.1),
                    spreadRadius: isSelected ? 2 : 1,
                    blurRadius: isSelected ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color:
                        isSelected ? Colors.white : category['color'] as Color,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category['label'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : nequiPurple,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _getContentForCategory(),
    );
  }

  Widget _getContentForCategory() {
    switch (_selectedCategory) {
      case 0:
        return _buildAlertasContent();
      case 1:
        return _buildConsejosContent();
      case 2:
        return _buildAprendeContent();
      case 3:
        return _buildFAQContent();
      default:
        return const SizedBox();
    }
  }

  Widget _buildAlertasContent() {
    final alertas = [
      {
        'title': '🚨 Llamadas Falsas',
        'description':
            'Nequi NUNCA te llamará para pedirte tus claves o datos personales',
        'severity': 'high'
      },
      {
        'title': '⚠️ Links Sospechosos',
        'description':
            'No hagas clic en enlaces enviados por WhatsApp o SMS desconocidos',
        'severity': 'high'
      },
      {
        'title': '💳 Pagos Urgentes',
        'description':
            'Desconfía de mensajes que te piden hacer pagos de emergencia',
        'severity': 'medium'
      },
      {
        'title': '🎁 Premios Falsos',
        'description':
            'Nadie regala dinero sin motivo. Si es demasiado bueno, es falso',
        'severity': 'medium'
      },
    ];

    return Column(
      children: alertas
          .map((alerta) => _buildAlertCard(
                alerta['title']!,
                alerta['description']!,
                alerta['severity']!,
              ))
          .toList(),
    );
  }

  Widget _buildAlertCard(String title, String description, String severity) {
    Color severityColor = severity == 'high' ? Colors.red : Colors.orange;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: severityColor.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: severityColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: severityColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: severityColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: nequiPurple,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConsejosContent() {
    final consejos = [
      {
        'icon': Icons.lock_outline,
        'title': 'Usa contraseñas fuertes',
        'description': 'Combina letras, números y símbolos',
        'color': Colors.blue
      },
      {
        'icon': Icons.fingerprint,
        'title': 'Activa la biometría',
        'description': 'Huella o reconocimiento facial',
        'color': Colors.purple
      },
      {
        'icon': Icons.notifications_active,
        'title': 'Mantén las notificaciones',
        'description': 'Te alertaremos de movimientos',
        'color': Colors.orange
      },
      {
        'icon': Icons.update,
        'title': 'Actualiza la app',
        'description': 'Siempre ten la última versión',
        'color': Colors.green
      },
      {
        'icon': Icons.visibility_off,
        'title': 'No compartas tus datos',
        'description': 'Claves y códigos son personales',
        'color': Colors.red
      },
      {
        'icon': Icons.wifi_off,
        'title': 'Evita WiFi público',
        'description': 'Usa datos móviles para transacciones',
        'color': Colors.teal
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: consejos.length,
        itemBuilder: (context, index) {
          final consejo = consejos[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 400 + (index * 100)),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (consejo['color'] as Color).withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (consejo['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          consejo['icon'] as IconData,
                          color: consejo['color'] as Color,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        consejo['title'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: nequiPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        consejo['description'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAprendeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aprende a identificar estafas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: nequiPurple,
            ),
          ),
          const SizedBox(height: 16),
          _buildLearningCard(
            'Phishing',
            'Correos o mensajes falsos que parecen oficiales',
            Icons.email_outlined,
            Colors.red,
          ),
          _buildLearningCard(
            'Vishing',
            'Llamadas fraudulentas haciéndose pasar por el banco',
            Icons.phone_outlined,
            Colors.orange,
          ),
          _buildLearningCard(
            'Smishing',
            'SMS con links maliciosos para robar información',
            Icons.message_outlined,
            Colors.purple,
          ),
          _buildLearningCard(
            'Ingeniería Social',
            'Manipulación psicológica para obtener datos',
            Icons.psychology_outlined,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildLearningCard(
      String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: nequiPurple,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Cómo protegerte?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: nequiPurple,
                  ),
                ),
                const SizedBox(height: 8),
                _buildProtectionPoint('Verifica siempre el remitente'),
                _buildProtectionPoint('No compartas información personal'),
                _buildProtectionPoint('Desconfía de urgencias'),
                _buildProtectionPoint('Reporta actividades sospechosas'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtectionPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQContent() {
    final faqs = [
      {
        'q': '¿Nequi me llamará para pedir mis claves?',
        'a': 'NO. Nequi NUNCA te pedirá tus claves por ningún medio.'
      },
      {
        'q': '¿Qué hago si recibo un link sospechoso?',
        'a': 'No hagas clic. Elimina el mensaje y repórtalo.'
      },
      {
        'q': '¿Puedo compartir códigos de verificación?',
        'a': 'NO. Los códigos son únicamente para ti.'
      },
      {
        'q': '¿Cómo reporto una estafa?',
        'a': 'Usa la opción "Reportar Robo" en la app o llama a nuestra línea.'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children:
            faqs.map((faq) => _buildFAQItem(faq['q']!, faq['a']!)).toList(),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Icon(Icons.help_outline, color: nequiPink),
        title: Text(
          question,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: nequiPurple,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    final videos = [
      {
        'thumb': Icons.play_circle_filled,
        'title': 'Cómo identificar una estafa',
        'duration': '3:45',
        'views': '150K'
      },
      {
        'thumb': Icons.play_circle_filled,
        'title': 'Protege tu cuenta Nequi',
        'duration': '5:20',
        'views': '200K'
      },
      {
        'thumb': Icons.play_circle_filled,
        'title': 'Qué hacer si te roban',
        'duration': '4:10',
        'views': '95K'
      },
      {
        'thumb': Icons.play_circle_filled,
        'title': 'Casos reales de fraude',
        'duration': '6:30',
        'views': '180K'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.video_library, color: nequiPink, size: 28),
              const SizedBox(width: 12),
              Text(
                'Videos Educativos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: nequiPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return _buildVideoCard(
                video['title'] as String,
                video['duration'] as String,
                video['views'] as String,
                video['thumb'] as IconData,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard(
      String title, String duration, String views, IconData icon) {
    return GestureDetector(
      onTap: () {
        _showVideoDialog(title);
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    nequiPurple.withOpacity(0.8),
                    nequiPink.withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Icon(
                            icon,
                            size: 64,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: nequiPurple,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '$views vistas',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVideoDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [nequiPurple, nequiPink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Video en reproducción',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: nequiPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Este es un ejemplo de cómo se vería un video educativo sobre seguridad en Nequi.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nequiPink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[50]!, Colors.orange[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Consejos del Día',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: nequiPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            '1. Nunca compartas tu código de verificación',
            'Ni siquiera con tu familia o amigos',
          ),
          _buildTipItem(
            '2. Verifica antes de hacer clic',
            'Los enlaces maliciosos son la principal causa de fraude',
          ),
          _buildTipItem(
            '3. Desconfía de las urgencias',
            'Los estafadores crean presión para que actúes sin pensar',
          ),
          _buildTipItem(
            '4. Mantén tu app actualizada',
            'Las actualizaciones incluyen mejoras de seguridad',
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: nequiPurple,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.quiz, color: nequiPink, size: 28),
              const SizedBox(width: 12),
              Text(
                'Preguntas Frecuentes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: nequiPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildExpandableQuestion(
          '¿Qué hago si me roban el celular?',
          '1. Llama inmediatamente a la línea de Nequi\n2. Bloquea tu cuenta desde otro dispositivo\n3. Cambia tus contraseñas\n4. Reporta el robo a las autoridades',
          Icons.phone_android,
          Colors.red,
        ),
        _buildExpandableQuestion(
          '¿Cómo sé si un mensaje es de Nequi?',
          'Los mensajes oficiales de Nequi:\n- Nunca piden claves o códigos\n- No incluyen links acortados\n- Vienen del número oficial\n- No crean urgencia artificial',
          Icons.message,
          Colors.blue,
        ),
        _buildExpandableQuestion(
          '¿Puedo recuperar dinero robado?',
          'Sí, si reportas el robo inmediatamente:\n- Presenta el caso dentro de las primeras 24 horas\n- Proporciona toda la información posible\n- Nuestro equipo investigará el caso\n- La recuperación depende de cada situación',
          Icons.attach_money,
          Colors.green,
        ),
        _buildExpandableQuestion(
          '¿Cómo protejo mi biometría?',
          'Consejos importantes:\n- No registres huellas de otras personas\n- Usa reconocimiento facial solo en tu dispositivo\n- Mantén tu celular con contraseña adicional\n- Revisa los dispositivos vinculados regularmente',
          Icons.fingerprint,
          Colors.purple,
        ),
      ],
    );
  }

  Widget _buildExpandableQuestion(
      String question, String answer, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          title: Text(
            question,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: nequiPurple,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red[400]!, Colors.red[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_in_talk,
                    size: 40,
                    color: Colors.red[600],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            '¿Necesitas Ayuda Urgente?',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Línea de atención 24/7',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone, color: Colors.red[600]),
                const SizedBox(width: 12),
                Text(
                  '(+57) 3006000100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ElevatedButton.icon(
  onPressed: () async {
    // Número de línea de emergencia de Nequi (reemplaza con el número real)
    const phoneNumber = 'tel:018000510001'; // Línea Nequi
    
    final Uri launchUri = Uri.parse(phoneNumber);
    
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('No se puede realizar la llamada'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al intentar llamar: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  },
  icon: const Icon(Icons.call),
  label: const Text(
    'Llamar Ahora',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.red[600],
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () async {
              // Mostrar SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Abriendo chat de soporte...'),
                  backgroundColor: nequiPink,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );

              // Esperar 3 segundos
              await Future.delayed(const Duration(seconds: 3));

              // Navegar a la página de chat
              if (context.mounted) {
                Navigator.pushNamed(context, "Chat");
              }
            },
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text(
              'Chat en Vivo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
