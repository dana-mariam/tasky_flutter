import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController quoteController =
  TextEditingController();
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      usernameController.text =
          prefs.getString("username") ?? "";

      quoteController.text =
          prefs.getString("quote") ??
              "One task at a time.\nOne step closer.";
    });
  }
  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", usernameController.text);
    await prefs.setString("quote", quoteController.text);

    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),

      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              const Text(
                "User Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Motivation Quote",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: quoteController,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a motivation quote";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white, // لون النص
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await saveUserData();
                    }
                  },
                  child: const Text("Save Changes"),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}