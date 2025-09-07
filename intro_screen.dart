import 'package:flutter/material.dart';
import 'package:roadmate/user_home/core/app_style.dart';
import 'package:roadmate/user_home/src/view/screen/home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget introButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            label: Text(
              "Get started",
              style: h3Style.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/intro.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 3),
                Text(
                  "Kana Office\nStanding\nDesk",
                  style: h1Style.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  "Create a sustainable work space with 100% natural bamboo",
                  style: h3Style.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                introButton(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
