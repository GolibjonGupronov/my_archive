import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorPage({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_rounded, color: Colors.red),
            // Gap(16),
            // TextView("Something went wrong!", fontSize: 24),
            // CustomButton(
            //     text: "Go to Main Page",
            //     onTap: () {
            //       AppRouter.pushAndClear(SplashPage());
            //     }),
          ],
        ),
      ),
    );
  }
}