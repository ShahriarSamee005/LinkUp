import 'package:flutter/material.dart';
import 'package:link_up/pages/login_page.dart';
import 'package:link_up/pages/register_page.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 17, 35, 22),
        title: Image.asset('assets/images/linkUpLogo.png', height: height*0.2,),
      ),
      body: Stack(
        children: [
        Positioned.fill(
            child: Image.asset("assets/images/appbgG4.jpg", fit: BoxFit.fill),
          ),
          Center(
            child: Card(
              color: const Color.fromARGB(255, 17, 35, 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Welcome to LinkUp 🎓",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 88, 236, 130),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your one-stop platform for buying/selling goods, \n"
                      "finding housing, tuition, and part-time jobs at Leading University.",
                      style: TextStyle(fontSize: 13,
                      color: Color.fromARGB(147, 255, 255, 255),),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: width * 0.6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 88, 236, 130),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        },
                        child: const Text("Login", style: TextStyle(
                          fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 17, 35, 22))),
                      ),
                    ),

                    const SizedBox(height: 12),
                    SizedBox(
                      width: width * 0.6,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 58, 114, 74),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 78, 137, 95),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}