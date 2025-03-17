import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final VoidCallback onLike;

  const LikeButton({super.key, required this.onLike});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onLike,
      icon: const Icon(Icons.favorite),
      label: const Text('Like'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
