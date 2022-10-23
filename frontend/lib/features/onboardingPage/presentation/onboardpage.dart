import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<PageViewModel> _items = [
    PageViewModel(
      title: "Title of first page",
      body: "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: Image.network("https://domaine.com/image.png", height: 175.0),
      ),
)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
          pages: _items,
          onDone: () {
            // When done button is press
          },
          showBackButton: true,
          showSkipButton: false,
          back: const Icon(Icons.arrow_back),
          done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600))),
        );
    
    
  }
}