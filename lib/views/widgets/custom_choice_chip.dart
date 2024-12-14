import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  const CustomChoiceChip({super.key});

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  int tag = 0;

  String selectedTag = "All time";

  List<String> tags = [];

  List<String> options = ["All time", "Todays", "Yesterdays"];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice.single(
      spacing: 6,
      wrapped: true,
      padding: const EdgeInsets.all(0),
      textDirection: TextDirection.ltr,
      value: tag,
      onChanged: (value) {
        print(options[value]);
        setState(() {
          tag = value;
          selectedTag = options[value];
        });
      },
      choiceItems: C2Choice.listFrom(
        source: options,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceActiveStyle: const C2ChoiceStyle(
        color: Colors.black,
        showCheckmark: false,
        labelStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      choiceStyle: const C2ChoiceStyle(
        color: Colors.black,
        backgroundColor: Colors.black12,
      ),
    );
  }
}
