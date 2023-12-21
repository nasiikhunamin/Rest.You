import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
              color: Color(0xff3A3E3E),
              fontWeight: FontWeight.w500,
              fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Nasikhun Amin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff3A3E3E),
                ),
              ),
              const Text(
                'idcampsubmission2.com',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff3A3E3E),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            title: const Text("Schedule Notifications"),
            trailing: Switch(value: true, onChanged: (value) {}),
          )
        ],
      ),
    );
  }
}
