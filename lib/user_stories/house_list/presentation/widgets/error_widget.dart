import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DisplayError extends StatelessWidget {
  final String message;
  const DisplayError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}