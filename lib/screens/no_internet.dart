import 'package:flutter/material.dart';
import 'package:gcc_portal/screens/splash.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../app_config.dart';
import '../utils/widgets/button_widget.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  _retryConnection(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const VectorGraphic(
            loader: AssetBytesLoader(AppAssets.noInternetSvg),
            width: 160,
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CurvedContainerClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFff0000),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'ইন্টারনেট সংযোগ নেই',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'আপনার ডিভাইসে ইন্টারনেট সংযোগ নেই। অনুগ্রহ করে ইন্টারনেট সংযোগ পরীক্ষা করুন অথবা পরবর্তীতে চেষ্টা করুন।',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ButtonWidget(
                      title: 'পুনরায় চেষ্টা করুন',
                      buttonColor: Colors.white,
                      textColor: const Color(0xFFff0000),
                      onPressed: () => _retryConnection(context),
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

class CurvedContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width / 2, 30, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
