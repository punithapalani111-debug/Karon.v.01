
import 'package:flutter/material.dart';

void main() {
  runApp(const KronaApp());
}

const Color oceanBlue = Color(0xFF00BFFF);
const Color background = Color(0xFF101820);

class KronaApp extends StatelessWidget {
  const KronaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A.KRONA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.dark(
          primary: oceanBlue,
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
  final user = TextEditingController();
  final pass = TextEditingController();

  bool hidePassword = true;
  String error = '';

  void login() {
    if (user.text.trim() == 'Krona' &&
        pass.text == '18052013') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Dashboard(),
        ),
      );
    } else {
      setState(() {
        error = 'Incorrect username or password';
      });
    }
  }

  @override
  void dispose() {
    user.dispose();
    pass.dispose();
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
              const Icon(
                Icons.smart_toy,
                size: 100,
                color: oceanBlue,
              ),
              const SizedBox(height: 15),
              const Text(
                'A.KRONA',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: oceanBlue,
                ),
              ),
              const Text('ROBOT CONTROL SYSTEM'),
              const SizedBox(height: 40),
              TextField(
                controller: user,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: pass,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                onSubmitted: (_) => login(),
              ),
              const SizedBox(height: 12),
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('LOGIN'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected = 0;
  bool connected = false;
  bool voice = true;
  bool guest = false;
  bool demo = false;
  bool sleep = false;

  final pages = const [
    HomePage(),
    RemotePage(),
    VoicePage(),
    ModesPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A.KRONA'),
        backgroundColor: const Color(0xFF172B3A),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Robot Connection'),
            subtitle: Text(
              connected ? 'Connected (demo)' : 'Offline',
            ),
            value: connected,
            onChanged: (v) {
              setState(() => connected = v);
            },
          ),
          Expanded(
            child: IndexedStack(
              index: selected,
              children: [
                const HomePage(),
                const RemotePage(),
                VoicePage(
                  enabled: voice,
                  onChanged: (v) {
                    setState(() => voice = v);
                  },
                ),
                ModesPage(
                  guest: guest,
                  demo: demo,
                  sleep: sleep,
                  onGuest: (v) {
                    setState(() => guest = v);
                  },
                  onDemo: (v) {
                    setState(() => demo = v);
                  },
                  onSleep: (v) {
                    setState(() => sleep = v);
                  },
                ),
                const SettingsPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (v) {
          setState(() => selected = v);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.gamepad),
            label: 'Remote',
          ),
          NavigationDestination(
            icon: Icon(Icons.mic),
            label: 'Voice',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune),
            label: 'Modes',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'HELLO! I AM KRONA',
            style: TextStyle(
              fontSize: 21,
              color: oceanBlue,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            width: 190,
            height: 125,
            decoration: BoxDecoration(
              color: const Color(0xFF172B3A),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: oceanBlue,
                width: 2,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RobotEye(),
                RobotEye(),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text('A.KRONA ROBOT ASSISTANT'),
        ],
      ),
    );
  }
}

class RobotEye extends StatelessWidget {
  const RobotEye({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 55,
      decoration: BoxDecoration(
        color: oceanBlue,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: oceanBlue,
            blurRadius: 15,
          ),
        ],
      ),
    );
  }
}

class RemotePage extends StatelessWidget {
  const RemotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'REMOTE CONTROL',
            style: TextStyle(
              fontSize: 22,
              color: oceanBlue,
            ),
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.keyboard_arrow_up,
            size: 60,
            color: oceanBlue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.keyboard_arrow_left,
                  size: 60, color: oceanBlue),
              SizedBox(width: 25),
              Icon(Icons.stop_circle,
                  size: 45, color: Colors.red),
              SizedBox(width: 25),
              Icon(Icons.keyboard_arrow_right,
                  size: 60, color: oceanBlue),
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 60,
            color: oceanBlue,
          ),
          const Text('Demo interface only'),
        ],
      ),
    );
  }
}

class VoicePage extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const VoicePage({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.mic,
            size: 85,
            color: oceanBlue,
          ),
          const Text(
            'VOICE CONTROL',
            style: TextStyle(fontSize: 22),
          ),
          Switch(
            value: enabled,
            onChanged: onChanged,
          ),
          Text(enabled ? 'Voice Enabled' : 'Voice Disabled'),
          const Text('Wake phrase: Hey Krona'),
          const Text('English • Tamil • Hindi'),
        ],
      ),
    );
  }
}

class ModesPage extends StatelessWidget {
  final bool guest;
  final bool demo;
  final bool sleep;
  final ValueChanged<bool> onGuest;
  final ValueChanged<bool> onDemo;
  final ValueChanged<bool> onSleep;

  const ModesPage({
    super.key,
    required this.guest,
    required this.demo,
    required this.sleep,
    required this.onGuest,
    required this.onDemo,
    required this.onSleep,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'ROBOT MODES',
          style: TextStyle(
            fontSize: 22,
            color: oceanBlue,
          ),
        ),
        SwitchListTile(
          title: const Text('Guest Mode'),
          value: guest,
          onChanged: onGuest,
        ),
        SwitchListTile(
          title: const Text('Demo Mode'),
          value: demo,
          onChanged: onDemo,
        ),
        SwitchListTile(
          title: const Text('Sleep Mode'),
          value: sleep,
          onChanged: onSleep,
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        Text(
          'SETTINGS',
          style: TextStyle(
            fontSize: 22,
            color: oceanBlue,
          ),
        ),
        ListTile(
          leading: Icon(Icons.wifi),
          title: Text('Wi-Fi Settings'),
        ),
        ListTile(
          leading: Icon(Icons.security),
          title: Text('Security'),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('About A.KRONA'),
        ),
      ],
    );
  }
}
