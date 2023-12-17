import 'package:flutter/material.dart';

class ButtonBanner extends StatelessWidget {
  final String title;
  const ButtonBanner({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 175,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xff477680), Color(0xffE26EE5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
