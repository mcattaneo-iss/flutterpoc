import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _MyAppState();
}

class _MyAppState extends State<NavBar> {
  String? username = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('activeUser') ?? username;
    });
  }

  void signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('activeUser');
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF212121),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username!),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/NoProfile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          Card(
            color: const Color(0xFF212121),
            child: ListTile(
              title: const Text('Dashboard',
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.display_settings, color: Colors.white),
              onTap: () => {Navigator.of(context).pushNamed('/dashboard')},
            ),
          ),
          Card(
            color: const Color(0xFF212121),
            child: ListTile(
              title:
                  const Text('Settings', style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.settings, color: Colors.white),
              onTap: () => {Navigator.of(context).pushNamed('/settings')},
            ),
          ),
          Card(
            color: const Color(0xFF212121),
            child: ListTile(
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.logout, color: Colors.white),
                onTap: () => signOut(context)),
          ),
        ],
      ),
    );
  }
}
