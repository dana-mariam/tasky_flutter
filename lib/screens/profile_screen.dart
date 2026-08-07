import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_details_screen.dart';
import 'welcom_screen.dart';
import 'package:projj/main.dart';
import 'package:projj/core/theme_notifier.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Guest";

  bool darkMode = false;

  @override

  void initState() {
    super.initState();
    getUsername();
    loadTheme();
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString("username") ?? "Guest";
    });
  }
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      darkMode = prefs.getBool("darkMode") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              username,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 28,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "One task at a time.\nOne step closer.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 40),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Profile Info",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text("User Details"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UserDetailsScreen(),
                  ),
                );

                getUsername();
              },
            ),

            const Divider(),

            SwitchListTile(
              value: darkMode,
              title: const Text("Dark Mode"),
              secondary: const Icon(Icons.dark_mode_outlined),

                onChanged: (value) async {
                  final prefs = await SharedPreferences.getInstance();

                  await prefs.setBool("darkMode", value);

                  themeNotifier.value =
                  value ? ThemeMode.dark : ThemeMode.light;

                  setState(() {
                    darkMode = value;
                  });
                }
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () async {
                final prefs = await SharedPreferences.getInstance();

                await prefs.remove("username");
                await prefs.remove("quote");
                await prefs.remove("tasks");

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}