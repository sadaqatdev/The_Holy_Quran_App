import 'package:al_quran/configs/app.dart';
import 'package:al_quran/configs/app_theme.dart';
import 'package:al_quran/providers/app_provider.dart';
import 'package:al_quran/utils/assets.dart';
import 'package:al_quran/widgets/app_version.dart';
import 'package:al_quran/widgets/custom_back_button.dart';
import 'package:al_quran/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:al_quran/share_icon_icons.dart';

part 'widgets/share_custom_button.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const <Widget>[
            CustomBackButton(),
            CustomTitle(title: 'Share App'),
            ShareInfo()
          ],
        ),
      ),
    );
  }
}

class ShareInfo extends StatelessWidget {
  const ShareInfo({Key? key}) : super(key: key);

  void share(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;

    Share.share(
        "Download the latest Shina Holy Qur'an App on Play store\n\n"
        "https://play.google.com/store/apps/details?id=com.quran.gbquran \n\nShare More! It is Sadaq-e-Jaria :)",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * 0.13),
          Image.asset(StaticAssets.gradLogo, height: height * 0.2),
          SizedBox(height: height * 0.02),
          Text(
              "The Shina Holy Qur'an App is also available as Open Source on GitHub!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption),
          SizedBox(height: height * 0.05),
          _ShareCustomButton(
            iconData: Icons.share,
            text: 'Share App',
            onPressed: () => share(context),
          ),
          _ShareCustomButton(
              iconData: ShareIcon.github,
              text: 'GitHub Repo',
              onPressed: () {
                //
              }
              // launch("https://github.com/mhmzdev/The_Holy_Quran_App"),
              ),
          _ShareCustomButton(
            iconData: ShareIcon.googlePlay,
            text: 'Rate & Feedback',
            onPressed: () => launch(
                "https://play.google.com/store/apps/details?id=com.quran.gbquran"),
          ),
          SizedBox(height: height * 0.02),
          const AppVersion()
        ],
      ),
    );
  }
}
