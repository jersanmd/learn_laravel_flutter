import 'package:flutter/material.dart';
import 'package:forumapp/views/register_page.dart';
import 'package:forumapp/views/widgets/input_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Page',
              style: GoogleFonts.poppins(fontSize: size * 0.08),
            ),
            const SizedBox(height: 30),
            InputWidgets(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 30),
            InputWidgets(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15)),
                onPressed: () {},
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(fontSize: size * 0.04),
                )),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Get.off(() => const RegisterPage());
                },
                child: Text(
                  'Register',
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.04, color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
