
import 'package:flutter/material.dart';

void main() {
  runApp(const KronaApp());
}

const Color kronaBlue = Color(0xFF00BFFF);
const Color kronaBackground = Color(0xFF071522);

class KronaApp extends StatelessWidget {
  const KronaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A.KRONA',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kronaBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kronaBlue,
          brightness: Brightness.dark,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  String error = '';

  void login() {
    if (username.text.trim() == 'Krona' &&
        password.text == '18052013') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(guest: false),
        ),
      );
    } else {
      setState(() => error = 'Incorrect username or password');
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.smart_toy, size: 90, color: kronaBlue),
              const SizedBox(height: 12),
              const Text(
                'A.KRONA',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: kronaBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text('YOUR PERSONAL ROBOT'),
              const SizedBox(height: 35),
              TextField(
                controller: username,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Text(error, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text('LOGIN'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardPage(guest: true),
                    ),
                  );
                },
                child: const Text('Continue as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final bool guest;

  const DashboardPage({super.key, required this.guest});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selected = 0;
  bool voiceEnabled = false;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      RemotePage(guest: widget.guest),
      VoicePage(enabled: voiceEnabled),
      ModesPage(guest: widget.guest),
      SettingsPage(guest: widget.guest),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('A.KRONA'),
        backgroundColor: const Color(0xFF102A40),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: pages[selected],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (index) {
          setState(() => selected = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.gamepad), label: 'Remote'),
          NavigationDestination(icon: Icon(Icons.mic), label: 'Voice'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Modes'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.smart_toy, size: 110, color: kronaBlue),
            const SizedBox(height: 20),
            const Text(
              'HELLO, I AM KRONA',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Your personal robot assistant'),
            const SizedBox(height: 25),
            const Card(
              child: ListTile(
                leading: Icon(Icons.wifi_off, color: Colors.orange),
                title: Text('Robot connection'),
                subtitle: Text('Not connected'),
              ),
            ),
            const Text(
              'This is an app prototype. Robot connection is not yet configured.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}

class RemotePage extends StatefulWidget {
  final bool guest;

  const RemotePage({super.key, required this.guest});

  @override
  State<RemotePage> createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {
  String status = 'No command sent';

  @override
  Widget build(BuildContext context) {
    void command(String value) {
      setState(() => status = '$value selected (demo only)');
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.gamepad, size: 65, color: kronaBlue),
          const SizedBox(height: 20),
          const Text('ROBOT CONTROL', style: TextStyle(fontSize: 23)),
          const SizedBox(height: 20),
          IconButton(
            onPressed: widget.guest ? null : () => command('Up'),
            icon: const Icon(Icons.arrow_upward),
            iconSize: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: widget.guest ? null : () => command('Left'),
                icon: const Icon(Icons.arrow_back),
                iconSize: 45,
              ),
              const SizedBox(width: 55),
              IconButton(
                onPressed: widget.guest ? null : () => command('Right'),
                icon: const Icon(Icons.arrow_forward),
                iconSize: 45,
              ),
            ],
          ),
          IconButton(
            onPressed: widget.guest ? null : () => command('Down'),
            icon: const Icon(Icons.arrow_downward),
            iconSize: 45,
          ),
          const SizedBox(height: 15),
          Text(status),
          if (widget.guest)
            const Text('Guest mode: controls disabled',
                style: TextStyle(color: Colors.orange)),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'These buttons are a visual demo and do not control a real robot.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class VoicePage extends StatefulWidget {
  final bool enabled;

  const VoicePage({super.key, required this.enabled});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.mic, size: 90, color: kronaBlue),
          const SizedBox(height: 20),
          const Text('VOICE ASSISTANT', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 15),
          Text(widget.enabled ? 'Voice enabled' : 'Voice not activated'),
          const Text('Wake phrase: Hey Krona'),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Microphone recognition is not implemented in this prototype.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ModesPage extends StatefulWidget {
  final bool guest;

  const ModesPage({super.key, required this.guest});

  @override
  State<ModesPage> createState() => _ModesPageState();
}

class _ModesPageState extends State<ModesPage> {
  String mode = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.tune, size: 75, color: kronaBlue),
          const SizedBox(height: 20),
          const Text('SELECT ROBOT MODE', style: TextStyle(fontSize: 22)),
          const SizedBox(height: 20),
          for (final item in ['Normal', 'Quiet', 'Guest'])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: widget.guest
                      ? null
                      : () => setState(() => mode = item),
                  child: Text(item),
                ),
              ),
            ),
          const SizedBox(height: 15),
          Text('Selected mode: $mode'),
          if (widget.guest)
            const Text('Guest mode: changes disabled',
                style: TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  final bool guest;

  const SettingsPage({super.key, required this.guest});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Icon(Icons.settings, size: 75, color: kronaBlue),
        const SizedBox(height: 20),
        const Center(
          child: Text('SETTINGS', style: TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Account'),
          subtitle: Text(guest ? 'Guest account' : 'Owner prototype account'),
        ),
        const ListTile(
          leading: Icon(Icons.language),
          title: Text('Language'),
          subtitle: Text('English / Tamil / Hindi - planned'),
        ),
        const ListTile(
          leading: Icon(Icons.security),
          title: Text('Security'),
          subtitle: Text('Secure cloud login - not configured'),
        ),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About A.KRONA'),
          subtitle: Text('Robot companion app prototype'),
        ),
      ],
    );
  }
}
