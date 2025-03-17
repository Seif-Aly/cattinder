import 'package:flutter/material.dart';

class DislikeButton extends StatelessWidget {
  final VoidCallback onDislike;

  const DislikeButton({super.key, required this.onDislike});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onDislike,
      icon: const Icon(Icons.close),
      label: const Text('Dislike'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
