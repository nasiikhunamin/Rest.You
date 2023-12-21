import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff477680),
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/favorite404.png', height: 300),
            const Text(
              'No favorites added',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
