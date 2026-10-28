import 'package:flutter/material.dart';

void main() => runApp(const NeonApp());

/// ─────────────────────────────────────────────
///  PALETA NEÓN
/// ─────────────────────────────────────────────
class Neon {
  static const bg = Color(0xFF07070F);
  static const surface = Color(0xFF12121F);
  static const cyan = Color(0xFF00F0FF);
  static const pink = Color(0xFFFF2BD6);
  static const green = Color(0xFF39FF14);
  static const yellow = Color(0xFFFFF01F);
  static const purple = Color(0xFFB026FF);
  static const red = Color(0xFFFF3131);

  static List<BoxShadow> glow(Color c, {double blur = 14, int alpha = 140}) => [
        BoxShadow(color: c.withAlpha(alpha), blurRadius: blur, spreadRadius: 0.5),
      ];

  static List<Shadow> textGlow(Color c) => [
        Shadow(color: c.withAlpha(230), blurRadius: 6),
        Shadow(color: c.withAlpha(150), blurRadius: 16),
      ];
}

/// ─────────────────────────────────────────────
///  MODELOS (datos simulados)
/// ─────────────────────────────────────────────
class Person {
  final String name;
  final String status;
  final Color color;
  final bool online;
  const Person(this.name, this.status, this.color, {this.online = false});

  String get initials {
    final parts = name.split(' ');
    return parts.length > 1
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : parts[0][0].toUpperCase();
  }
}

class ChatItem {
  final Person person;
  final String lastMessage;
  final String time;
  final int unread;
  const ChatItem(this.person, this.lastMessage, this.time, {this.unread = 0});
}

enum CallType { incoming, outgoing, missed }

class CallItem {
  final Person person;
  final CallType type;
  final String time;
  const CallItem(this.person, this.type, this.time);
}

const people = <Person>[
  Person('Ana Torres', 'Disponible', Neon.cyan, online: true),
  Person('Carlos Mendoza', 'En clase 📚', Neon.pink),
  Person('Daniela Ruiz', 'Programando en Dart 💻', Neon.green, online: true),
  Person('Eduardo Salas', 'Ocupado', Neon.yellow),
  Person('Fernanda Lopez', 'Sólo mensajes', Neon.purple, online: true),
  Person('Gael Ramírez', 'En el laboratorio', Neon.cyan),
  Person('Héctor Vega', 'Durmiendo 😴', Neon.pink),
  Person('Isabel Cruz', 'IoT es vida ⚡', Neon.green, online: true),
  Person('Jorge Navarro', 'Disponible', Neon.yellow),
  Person('Karen Ortiz', 'No molestar', Neon.purple),
];

const chats = <ChatItem>[
  ChatItem(Person('Ana Torres', '', Neon.cyan, online: true),
      '¿Ya terminaste la práctica de Flutter?', '08:05', unread: 2),
  ChatItem(Person('Daniela Ruiz', '', Neon.green, online: true),
      'Te paso el código en un momento', '07:48', unread: 1),
  ChatItem(Person('Carlos Mendoza', '', Neon.pink),
      'Jajaja sí, está difícil el examen', 'Ayer'),
  ChatItem(Person('Isabel Cruz', '', Neon.green, online: true),
      'El ESP32 ya conectó al WiFi 🎉', 'Ayer', unread: 4),
  ChatItem(Person('Fernanda Lopez', '', Neon.purple, online: true),
      'Gracias por la ayuda 🙌', 'Lun'),
  ChatItem(Person('Eduardo Salas', '', Neon.yellow),
      'Nos vemos mañana en el equipo', 'Lun'),
  ChatItem(Person('Gael Ramírez', '', Neon.cyan),
      'Mándame el PDF por favor', 'Dom'),
];

const calls = <CallItem>[
  CallItem(Person('Ana Torres', '', Neon.cyan, online: true),
      CallType.incoming, 'Hoy, 08:02'),
  CallItem(Person('Carlos Mendoza', '', Neon.pink), CallType.missed,
      'Hoy, 07:30'),
  CallItem(Person('Daniela Ruiz', '', Neon.green, online: true),
      CallType.outgoing, 'Ayer, 21:15'),
  CallItem(Person('Isabel Cruz', '', Neon.green, online: true),
      CallType.incoming, 'Ayer, 18:40'),
  CallItem(Person('Héctor Vega', '', Neon.pink), CallType.missed,
      'Lun, 12:05'),
  CallItem(Person('Fernanda Lopez', '', Neon.purple, online: true),
      CallType.outgoing, 'Lun, 10:20'),
  CallItem(Person('Jorge Navarro', '', Neon.yellow), CallType.incoming,
      'Dom, 19:00'),
];

/// ─────────────────────────────────────────────
///  APP
/// ─────────────────────────────────────────────
class NeonApp extends StatelessWidget {
  const NeonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neon Messenger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Neon.bg,
        colorScheme: const ColorScheme.dark(
          primary: Neon.cyan,
          secondary: Neon.pink,
          surface: Neon.surface,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// Texto con efecto neón
class NeonText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  const NeonText(this.text,
      {super.key,
      this.color = Neon.cyan,
      this.size = 22,
      this.weight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: 1.5,
        shadows: Neon.textGlow(color),
      ),
    );
  }
}

/// Avatar con aro neón
class NeonAvatar extends StatelessWidget {
  final Person person;
  final double radius;
  const NeonAvatar(this.person, {super.key, this.radius = 26});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: person.color, width: 2),
            boxShadow: Neon.glow(person.color, blur: 12),
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Neon.bg,
            child: Text(
              person.initials,
              style: TextStyle(
                color: person.color,
                fontWeight: FontWeight.bold,
                fontSize: radius * .7,
                shadows: Neon.textGlow(person.color),
              ),
            ),
          ),
        ),
        if (person.online)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: Neon.green,
                shape: BoxShape.circle,
                border: Border.all(color: Neon.bg, width: 2),
                boxShadow: Neon.glow(Neon.green, blur: 8),
              ),
            ),
          ),
      ],
    );
  }
}

/// Tarjeta con borde neón
class NeonCard extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  const NeonCard(
      {super.key, required this.color, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Neon.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withAlpha(150), width: 1.2),
          boxShadow: Neon.glow(color, blur: 10, alpha: 55),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: color.withAlpha(60),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
///  HOME con BottomNavigationBar
/// ─────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  static const _titles = ['PEOPLES', 'CHATS', 'CALLS'];
  static const _colors = [Neon.cyan, Neon.pink, Neon.green];

  final _pages = const [PeoplePage(), ChatsPage(), CallsPage()];

  @override
  Widget build(BuildContext context) {
    final color = _colors[_index];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Neon.bg,
        elevation: 0,
        centerTitle: true,
        title: NeonText(_titles[_index], color: color, size: 26),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: color,
              boxShadow: Neon.glow(color, blur: 12, alpha: 220),
            ),
          ),
        ),
      ),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Neon.surface,
          border: Border(top: BorderSide(color: color, width: 1.5)),
          boxShadow: Neon.glow(color, blur: 18, alpha: 110),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: color,
          unselectedItemColor: Colors.white38,
          selectedFontSize: 13,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            shadows: Neon.textGlow(color),
          ),
          items: [
            _item(Icons.people_alt_outlined, Icons.people_alt, 'Peoples', 0),
            _item(Icons.chat_bubble_outline, Icons.chat_bubble, 'Chats', 1),
            _item(Icons.call_outlined, Icons.call, 'Calls', 2),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _item(
      IconData icon, IconData active, String label, int i) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(active, shadows: Neon.textGlow(_colors[i])),
      label: label,
    );
  }
}

/// ─────────────────────────────────────────────
///  PEOPLES
/// ─────────────────────────────────────────────
class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: people.length,
      itemBuilder: (context, i) {
        final p = people[i];
        return NeonCard(
          color: p.color,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatPage(person: p)),
          ),
          child: Row(
            children: [
              NeonAvatar(p),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 3),
                    Text(p.status,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 13)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: p.color),
            ],
          ),
        );
      },
    );
  }
}

/// ─────────────────────────────────────────────
///  CHATS
/// ─────────────────────────────────────────────
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: chats.length,
      itemBuilder: (context, i) {
        final c = chats[i];
        final hasUnread = c.unread > 0;
        return NeonCard(
          color: c.person.color,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatPage(person: c.person)),
          ),
          child: Row(
            children: [
              NeonAvatar(c.person),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.person.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 3),
                    Text(
                      c.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hasUnread ? Colors.white : Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(c.time,
                      style: TextStyle(
                          color: hasUnread ? Neon.pink : Colors.white38,
                          fontSize: 12)),
                  const SizedBox(height: 6),
                  if (hasUnread)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Neon.pink,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: Neon.glow(Neon.pink, blur: 10),
                      ),
                      child: Text('${c.unread}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    )
                  else
                    const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ─────────────────────────────────────────────
///  CALLS
/// ─────────────────────────────────────────────
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  IconData _icon(CallType t) {
    switch (t) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
    }
  }

  Color _color(CallType t) {
    switch (t) {
      case CallType.incoming:
        return Neon.green;
      case CallType.outgoing:
        return Neon.cyan;
      case CallType.missed:
        return Neon.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: calls.length,
      itemBuilder: (context, i) {
        final c = calls[i];
        final tc = _color(c.type);
        return NeonCard(
          color: tc,
          onTap: () => _simulateCall(context, c.person),
          child: Row(
            children: [
              NeonAvatar(c.person),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.person.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: c.type == CallType.missed
                                ? Neon.red
                                : Colors.white)),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(_icon(c.type), size: 15, color: tc),
                        const SizedBox(width: 5),
                        Text(c.time,
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.call, color: tc, shadows: Neon.textGlow(tc)),
            ],
          ),
        );
      },
    );
  }

  void _simulateCall(BuildContext context, Person p) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Neon.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Neon.green, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NeonAvatar(p, radius: 38),
              const SizedBox(height: 16),
              NeonText(p.name, color: p.color, size: 20),
              const SizedBox(height: 6),
              const Text('Llamando...',
                  style: TextStyle(color: Colors.white60)),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Neon.red,
                    shape: BoxShape.circle,
                    boxShadow: Neon.glow(Neon.red, blur: 18, alpha: 200),
                  ),
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
///  PANTALLA DE CONVERSACIÓN (simulada)
/// ─────────────────────────────────────────────
class _Msg {
  final String text;
  final bool mine;
  _Msg(this.text, this.mine);
}

class ChatPage extends StatefulWidget {
  final Person person;
  const ChatPage({super.key, required this.person});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final List<_Msg> _messages = [
    _Msg('¡Hola! ¿Cómo vas con el proyecto?', false),
    _Msg('Todo bien, ya casi termino 😎', true),
  ];

  static const _replies = [
    '¡Genial! 🔥',
    'Va, nos vemos luego.',
    'Jaja, claro que sí.',
    'Déjame lo reviso y te aviso.',
    '⚡⚡⚡',
  ];
  int _replyIdx = 0;

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _messages.add(_Msg(text, true)));
    _controller.clear();
    _scrollDown();

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() =>
          _messages.add(_Msg(_replies[_replyIdx++ % _replies.length], false)));
      _scrollDown();
    });
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.person;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Neon.bg,
        iconTheme: IconThemeData(color: p.color),
        title: Row(
          children: [
            NeonAvatar(p, radius: 17),
            const SizedBox(width: 12),
            NeonText(p.name, color: p.color, size: 18),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              color: p.color,
              boxShadow: Neon.glow(p.color, blur: 12, alpha: 220),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(14),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final c = m.mine ? Neon.cyan : p.color;
                return Align(
                  alignment:
                      m.mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .72),
                    decoration: BoxDecoration(
                      color: Neon.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: c, width: 1.2),
                      boxShadow: Neon.glow(c, blur: 10, alpha: 70),
                    ),
                    child: Text(m.text),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _send(),
                      cursorColor: Neon.cyan,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Neon.surface,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Neon.purple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                              const BorderSide(color: Neon.cyan, width: 1.8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Neon.cyan,
                        shape: BoxShape.circle,
                        boxShadow: Neon.glow(Neon.cyan, blur: 16, alpha: 200),
                      ),
                      child: const Icon(Icons.send, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
