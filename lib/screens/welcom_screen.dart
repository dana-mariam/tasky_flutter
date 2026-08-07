import 'package:flutter/material.dart';
import 'package:projj/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // TextField controller
  final TextEditingController controller = TextEditingController();

  String name = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: Form(
              key: formKey,

              child: Column(
                children: [

                  const SizedBox(height: 55),

                  // ======================
                  // App Logo
                  // ======================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset(
                        "assets/a3a8d4963fd56071db7c6b9e1bdf6d4d.jpg",
                        width: 35,
                        height: 35,
                      ),

                      const SizedBox(width: 10),

                       Text(
                        "Tasky",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 70),

                  // ======================
                  // Welcome Text
                  // ======================

                  Text(
                    "Welcome To Tasky",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 34,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Your productivity starts here.",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ======================
                  // Illustration
                  // ======================

                  Image.asset(
                    "assets/e58a5166cc42ccb26cd0c112ed59343b.jpg",
                    width: 210,
                    height: 210,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 25),

                  // ======================
                  // Full Name Label
                  // ======================

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ======================
                  // TextField
                  // ======================

                  TextFormField(
                    controller: controller,

                    onChanged: (value) {
                      name = value;
                    },

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      hintText: "username",

                      hintStyle: const TextStyle(
                      ),

                      filled: true,
                      fillColor: const Color(0xff242424),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ======================
                  // Continue Button
                  // ======================

                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () async {

                        if (formKey.currentState!.validate()) {

                          final prefs =
                          await SharedPreferences.getInstance();

                          await prefs.setString(
                            "username",
                            controller.text,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      },

                      child: const Text(
                        "Let's Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//and what init state
//setstate
