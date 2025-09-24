import 'dart:async';
import 'package:websitepesan/halaman_login.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});
  @override
  State <Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animasi fade-in
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    // Timer untuk pindah screen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        //MaterialPageRoute(builder: (context) => const HalamanLogin()),
         MaterialPageRoute(builder: (context) => const HalamanLogin()), // Ganti sesuai tujuan
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  image: const DecorationImage(
                    image: AssetImage('assets/LOGO.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'WARUNG KITA',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Text(
                'By Qolbun Halim Hidayatulloh\n24111814065',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
