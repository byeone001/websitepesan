import 'package:websitepesan/halaman_login.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class HalamanLupaPassword extends StatefulWidget {
  const HalamanLupaPassword({super.key});

  @override
  State<HalamanLupaPassword> createState() => _HalamanLupaPasswordState();
}

class _HalamanLupaPasswordState extends State<HalamanLupaPassword> {
  final _emailController = TextEditingController();
  String message = "";

  void _resetPassword() {
    String email = _emailController.text.trim();

    if (fakeDatabase.containsKey(email)) {
      setState(() =>
          message = "Link reset password dikirim ke email: $email (simulasi)");
    } else {
      setState(() => message = "Email tidak terdaftar!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    
    return AuthScaffold(
      title: "Lupa Password",
      fields: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              hintText: "Masukkan email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          const Text(
            "Kami akan mengirimkan tautan pengaturan ulang kata sandi ke email Anda",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 20),
          SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style : ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
              onPressed: _resetPassword,
              child: const Text("KIRIM LINK RESET"),
            ),
          ),
          if (message.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(message, style: const TextStyle(color: Colors.blue)),
          ],
        ],
      ),
      
      bottomText: "Ingat kata sandi Anda?",
      bottomButtonText: "Kembali Login",
      onBottomButtonPressed: () {
        Navigator.push(
          context,
          animatedRoute(const HalamanLogin(), direction: AxisDirection.right),
        );
      },
    );
  }
}