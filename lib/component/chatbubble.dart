import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(12),

        child: Text(
          message,
          style: const TextStyle(fontSize: 14,color: Colors.white),
        ),

      ),
    );
  }
}
