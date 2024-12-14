import 'package:flutter/material.dart';

class EmergencyWidgetCard extends StatelessWidget {
  final Color backgroundColor;
  final String image;
  final String title;
  final String subTitle;
  const EmergencyWidgetCard({
    super.key,
    required this.backgroundColor,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      height: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    "Contact now",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(
            image,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
