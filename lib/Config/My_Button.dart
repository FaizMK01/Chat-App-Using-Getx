import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback tap;
  const MyButton({super.key, required this.text, required this.tap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        onPressed: tap, // Function to handle the tap
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary, // Background color
          padding: EdgeInsets.all(25), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Border radius
          ),
          elevation: 0, // Optional: Remove shadow if needed
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary, // Text color
            ),
          ),
        ),
      ),
    );

  }
}
