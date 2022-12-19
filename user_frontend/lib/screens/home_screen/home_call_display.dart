import 'package:flutter/material.dart';
import 'package:frontend/widgets/video_call.dart';

import 'auto_cmd.dart';
import 'joystick_controls.dart';

class HomeDisplay extends StatelessWidget {
  final bool isAutoCmd;
  final bool isNavSelected;
  const HomeDisplay(
      {super.key, required this.isAutoCmd, required this.isNavSelected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          VideoCallDisplay(),
          // Container(
          //   height: double.infinity,
          //   color: Colors.amber,
          //   child: Image.network(
          //     "https://media.tacdn.com/media/attractions-splice-spp-674x446/0b/cf/e5/cb.jpg",
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomRight,
            child: JoyStickControls(
              isTeleopMode: !isAutoCmd,
              isNavSelected: isNavSelected,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: AutonomousCommands(
              isAutoCmd: isAutoCmd,
              isNavSelected: isNavSelected,
            ),
          ),
        ],
      ),
    );
  }
}
