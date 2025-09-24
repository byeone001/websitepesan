import 'package:websitepesan/halaman_password.dart';
import 'package:websitepesan/halaman_registrasi.dart';
import 'package:flutter/material.dart';
import 'package:websitepesan/main.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  String errorMessage = "";

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (fakeDatabase.containsKey(email) && fakeDatabase[email] == password) {
      Navigator.pushReplacementNamed(
        context,
        "/main",
        arguments: {"email": email},
      );
    } else {
      setState(() {
        errorMessage = "Email atau password salah!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Silahkan Login",
      fields: Column(
        children: [
          // Email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              hintText: "Masukkan Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Password
          TextField(
            controller: passwordController,
            obscureText: isPasswordVisible ? false : true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: "Masukkan Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),
          ),

          if (errorMessage.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(errorMessage, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _login,
              child: const Text("LOGIN"),
            ),
          ),

          // Remember & Forgot
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: false, onChanged: (val) {}),
                  const Text("Ingat Saya"),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    animatedRoute(
                      const HalamanLupaPassword(),
                      direction: AxisDirection.left,
                    ),
                  );
                },
                child: const Text("Lupa Password?"),
              ),
            ],
          ),
        ],
      ),

      bottomText: "Belum Punya Akun?",
      bottomButtonText: "Buat Akun",
      onBottomButtonPressed: () {
        Navigator.push(
          context,
          animatedRoute(const HalamanRegistrasi(), direction: AxisDirection.up),
        );
      },
    );
  }
}
