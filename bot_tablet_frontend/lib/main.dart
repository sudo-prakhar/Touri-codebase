import 'package:agora_uikit/agora_uikit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Permission.camera.request();
  // await Permission.microphone.request();
  // await Permission.storage.request();
  await Firebase.initializeApp();
  runApp(Touri());
}

/* -------------------------------------------------------------------------- */
class Touri extends StatelessWidget {
  const Touri({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}

/* -------------------------------------------------------------------------- */

//007eJxTYOhtMHm0ZnrFkrLMr7OOrH/gdb58XUHE4ej4kysyPjTlh2UrMBilGqaaphqYGxoaGZtYmppaWiSZWCQnppmYmBqkGSaZx111S76r5pG8ym0jAyMUgvisDCX5pUWZDAwAVDsjyQ==

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoCallWidget(),
    );
  }
}

/* -------------------------------------------------------------------------- */

class VideoCallWidget extends StatefulWidget {
  const VideoCallWidget({super.key});

  @override
  State<VideoCallWidget> createState() => _VideoCallWidgetState();
}

// 2e1e5e071123495598b48caf4450f1b7

class _VideoCallWidgetState extends State<VideoCallWidget> {
  double x = 0;
  double y = 0;
  String msg = "";

  String oldXCmd = "";
  String oldYCmd = "";
  String newXCmd = "";
  String newYCmd = "";

  // Instantiate the client
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: "e7c5b65f9465479eb7eda9ce4490c897",
        channelName: "touri",
        username: "Prakhar"),
    // agoraEventHandlers: AgoraRtcEventHandlers(
    //   facePositionChanged: (p0, p1, p2) => onFaceChange(p0, p1, p2),
    // ),
  );

// Initialize the Agora Engine
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void updateFirebase(String newXCmd, String newYCmd) {
    if ((oldXCmd != newXCmd) || (oldYCmd != newYCmd)) {
      FirebaseDatabase.instance.ref().child('autoSkills/gimbal').update(
        {'xCmd': newXCmd, 'yCmd': newYCmd},
      );

      setState(() {
        oldXCmd = newXCmd;
        oldYCmd = newYCmd;
      });
    }
  }

/* -------------------------------------------------------------------------- */

  void initAgora() async {
    await client.initialize();
    // await client.sessionController.value.engine?.enableFaceDetection(true);

    // client.sessionController.addListener(() {
    //   AgoraRtcEventHandlers(
    //     facePositionChanged: (imageWidth, imageHeight, faces) {
    //       if (faces.isNotEmpty) {
    //         setState(() {
    //           x = 2 * (faces.first.x.toDouble() / 1900) - 1;
    //           y = 2 * (faces.first.y.toDouble() / 1000) - 1;
    //         });
    //         String xMsg = "None";
    //         String yMsg = "None";

    //         faces.sort(((a, b) => b.distance.compareTo(a.distance)));
    //         faces = faces.reversed.toList();
    //         faces = faces.where((face) => face.width > 300).toList();

    //         if (faces.first.width < 1900 * 0.7) {
    //           if (faces.first.x < faces.first.width) {
    //             xMsg = "RIGHT";
    //           } else if (faces.first.x > 1900 - faces.first.width) {
    //             xMsg = "LEFT";
    //           }

    //           if (faces.first.y < faces.first.height) {
    //             yMsg = "DOWN";
    //           } else if (faces.first.y > 1000 - faces.first.height) {
    //             yMsg = "UP";
    //           }

    //           setState(() {
    //             msg = "X: $xMsg\nY: $yMsg";
    //           });

    //           updateFirebase(xMsg, yMsg);
    //         }
    //       }
    //     },
    //   );
    // });

    // client.sessionController.createEvents(
    //   AgoraRtmChannelEventHandler(),
    // );
  }

/* -------------------------------------------------------------------------- */
// Build your layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
              floatingLayoutContainerHeight: 100,
              floatingLayoutContainerWidth: 100,
              showAVState: true,
            ),
            AgoraVideoButtons(client: client),
            // Align(
            //   alignment: Alignment(x, y),
            //   child: Container(
            //     height: 150,
            //     width: 150,
            //     color: Color.fromARGB(119, 0, 0, 0),
            //     child: Text(msg),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
