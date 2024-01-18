import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourest/common/style.dart';
import 'package:yourest/provider/preference_provider.dart';
import 'package:yourest/provider/schedulling_provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "profile_page";
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge?.merge(textWhite),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/logo_splash.png",
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Rest",
                  style:
                      Theme.of(context).textTheme.titleLarge?.merge(textBlack),
                ),
                Text(
                  "idcampsubmission3.com",
                  style:
                      Theme.of(context).textTheme.titleMedium?.merge(textBlack),
                ),
              ],
            ),
            Consumer<PreferencesProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: ListView(
                    children: [
                      Material(
                        child: ListTile(
                          title: Text(
                            "Recommended Notification",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.merge(textBlack),
                          ),
                          trailing: Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                              return Switch.adaptive(
                                value: provider.isRandomRestoNotification,
                                onChanged: (value) async {
                                  scheduled.setScheduling(value);
                                  provider.enableRandomRestoNotification(value);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
