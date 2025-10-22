import 'package:flutter/material.dart';

class ScalingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const ScalingButton({super.key, required this.child, required this.onTap});

  @override
  State<ScalingButton> createState() => _ScalingButtonState();
}

class _ScalingButtonState extends State<ScalingButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// this is a reuseable button component which is used extensively thorughout this application
