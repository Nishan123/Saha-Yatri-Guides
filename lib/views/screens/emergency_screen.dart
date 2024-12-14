import 'package:flutter/material.dart';
import 'package:saha_yatri_guides/views/widgets/emergency_widget_card.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Emergency")),
        body:  const SafeArea(
            child: Column(
          children: [
            EmergencyWidgetCard(
              backgroundColor: Color.fromARGB(255, 255, 103, 103),
              image: "assets/arguing.png",
              title: "Report your guide !",
              subTitle: "Contact with officials",
            ),
            EmergencyWidgetCard(
              backgroundColor: Color.fromARGB(255, 205, 112, 154),
              image: "assets/police.png",
              title: "Call a police",
              subTitle: "Contact with local police",
            ),
            EmergencyWidgetCard(
              backgroundColor: Color.fromARGB(255, 112, 131, 205),
              image: "assets/ambulance.png",
              title: "Medical emergency",
              subTitle: "Contact with nearby medical service",
            ),
          ],
        )));
  }
}
