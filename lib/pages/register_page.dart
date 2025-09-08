import 'package:flutter/material.dart';
import 'package:link_up/Auth/aut_service.dart';
import 'package:link_up/utils/validator.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController(); 
  final authService = AuthService();

void signUp() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text;
  final confirmPassword = _confirmPasswordController.text;

  if (!isValidEmail(email)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please enter a valid email address.")),
    );
    return;
  }

  if (!isValidPassword(password)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password must be at least 6 characters and include a number."),
      ),
    );
    return;
  }

if(password != confirmPassword) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Passwords didn't match! Please re-enter your password"))
  );
  return;
}

if(password.length < 6) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Password must be at least 6 characters"))
  );
  return;
}

  try {
    await authService.signUpWithEmailPassword(email, password);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    //final width = size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/appbgG4.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 140),
                const Text(
                  "Registration page", 
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 236, 130),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),                
              ],
            ),
          ),

          Center(
            child: Column(
              children: [
                Expanded(flex: 1, child: SizedBox(height: 200)),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                        Color.fromARGB(255, 34, 90, 50),
                          Color.fromARGB(255, 17, 35, 22),

                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        ),
                      //color: Color.fromARGB(255, 17, 35, 22),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.04),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Color.fromARGB(255, 88, 236, 130),
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _emailController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: "Enter Email",
                              labelStyle: const TextStyle(color: Colors.grey),
                              floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 88, 236, 130),
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 88, 236, 130),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              labelStyle: const TextStyle(color: Colors.grey),
                              floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 88, 236, 130),
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 88, 236, 130),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: const TextStyle(color: Colors.grey),
                              floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 88, 236, 130),
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 88, 236, 130),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 88, 236, 130),
                            foregroundColor: const Color.fromARGB(255, 17, 35, 22),
                            minimumSize: const Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: signUp,
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Color.fromARGB(147, 255, 255, 255),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: const Text(
                                " Sign in",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 88, 236, 130),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
