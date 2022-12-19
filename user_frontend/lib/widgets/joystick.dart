import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class TeleopJoystick extends StatelessWidget {
  final String label;
  final Function(StickDragDetails details) onChanged;
  final Function onRelease;

  const TeleopJoystick({
    Key? key,
    this.label = "",
    required this.onChanged,
    required this.onRelease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerUp: (_) => onRelease(),
          child: Joystick(
            listener: (details) => onChanged(details),
            period: const Duration(milliseconds: 100),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
