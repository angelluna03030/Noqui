import '../../rutas.dart';
import 'package:http/http.dart' as http;

class NequiAntiScamChat extends StatefulWidget {
  const NequiAntiScamChat({Key? key}) : super(key: key);

  @override
  State<NequiAntiScamChat> createState() => _NequiAntiScamChatState();
}

class _NequiAntiScamChatState extends State<NequiAntiScamChat>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  final String _apiKey = 'aqui va tu apikey de deepseek';
  final String _systemPrompt = '''
Eres Noqui, un asistente de IA especializado en seguridad financiera de Nequi (banco digital colombiano).

TU MISIÓN:
Prevenir estafas y fraudes bancarios educando a los usuarios sobre seguridad digital.

CONOCIMIENTOS CLAVE:
- Tipos de estafas comunes en Colombia (phishing, vishing, smishing, ingeniería social)
- Métodos de fraude específicos contra Nequi y bancos digitales
- Señales de alerta en mensajes, llamadas y enlaces sospechosos
- Buenas prácticas de seguridad digital y protección de datos
- Diferencias entre comunicación legítima de Nequi vs estafadores

CÓMO RESPONDER:
- Breve: Máximo 3-4 párrafos, directo al punto
- Claro: Sin tecnicismos innecesarios, explica con ejemplos
- Amigable: Tono cercano y tranquilizador, sin alarmar
- Colombiano: Usa expresiones locales naturalmente ("parce", "llave", "chimba") cuando sea apropiado, pero mantén profesionalismo
- Práctico: Siempre incluye pasos accionables

ESTRUCTURA DE RESPUESTA:
1. Valida la preocupación del usuario
2. Explica el riesgo o la situación
3. Da recomendaciones específicas
4. Ofrece recursos adicionales si es necesario

NUNCA:
- Pidas datos personales (contraseñas, PINs, números de cuenta)
- Prometas resoluciones que solo el banco puede hacer
- Generes pánico innecesario
- Uses lenguaje técnico sin explicar

''';
  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(
        ChatMessage(
          text:
              '¡Hola! Soy Noqui 👋\n\n¿Recibiste un mensaje, llamada o link sospechoso? Estoy aquí para ayudarte a identificar si es una estafa.\n\nCuéntame qué pasó y te diré si es seguro o no.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await _callDeepSeekAPI(text);

      setState(() {
        _messages.add(
          ChatMessage(
            text: response,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isTyping = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text:
                'Lo siento, hubo un error al procesar tu mensaje. Por favor intenta de nuevo.',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isTyping = false;
      });
    }

    _scrollToBottom();
  }

  Future<String> _callDeepSeekAPI(String userMessage) async {
    final url = Uri.parse('https://api.deepseek.com/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek-chat',
        'messages': [
          {'role': 'system', 'content': _systemPrompt},
          {'role': 'user', 'content': userMessage},
        ],
        'temperature': 0.7,
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Error al comunicarse con DeepSeek: ${response.body}');
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 244),
      appBar: AppBar(
        backgroundColor: const Color(0xFF351936),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE0198E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.shield_outlined, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anti-Estafa Noqui',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Protegemos tu plata',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          if (_isTyping) const TypingIndicator(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 244),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9F6),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xFF351936).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Color(0xFF351936)),
                  decoration: const InputDecoration(
                    hintText: 'Describe la situación...',
                    hintStyle: TextStyle(color: Color.fromARGB(137, 0, 0, 0)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: _sendMessage,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _sendMessage(_controller.text),
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE0198E), Color(0xFFFF1493)],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF351936).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE0198E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.shield_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFFE0198E)
                    : const Color(0xFF2A0F2B),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(message.isUser ? 18 : 4),
                  bottomRight: Radius.circular(message.isUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF4A1F4B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({Key? key}) : super(key: key);

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE0198E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2A0F2B),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final delay = index * 0.2;
                    final value = (_controller.value - delay) % 1.0;
                    final opacity =
                        (value < 0.5) ? value * 2 : (1.0 - value) * 2;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Opacity(
                        opacity: opacity.clamp(0.3, 1.0),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0198E),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
