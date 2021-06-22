import 'package:flutter/material.dart';

class componentRecord extends StatelessWidget {
  final String title;
  final String value;
  componentRecord({required this.title, required this.value});
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
