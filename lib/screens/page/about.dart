import 'package:flutter/material.dart';
import '../../utils/assets.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/title.dart';
import '../help_guide/help_guide_screen.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomImage(
              imagePath: StaticAssets.gradLogo,
              opacity: 0.5,
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            const CustomBackButton(),
            const CustomTitle(title: "About"),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, height * 0.1),
              child: ListView(
                shrinkWrap: true,
                children: const [
                  GuideContainer(
                    guideNo: 1,
                    title: "Quran translated by",
                    guideDescription: "Shah Mirza",
                  ),
                  GuideContainer(
                    guideNo: 2,
                    title: "Developer Info",
                    guideDescription:
                        "Sadaqat Hussain \n Email: sadaqathunzai@gmail.com \n GitHub: github.com/sadaqatdev \nWhatsApp 03495304657",
                  ),
                  GuideContainer(
                    guideNo: 3,
                    title: "Developer Info",
                    guideDescription:
                        "Yasir Hussain \n Email: it.engineer.yasir@gmail.com \n Email: it.engineer.yasir@gmail.com \n GitHub: github.com/sadaqatdev \nWhatsApp 03109366308",
                  ),
                  // Center(
                  //     child: Text(
                  //   "To sponsor the project please DM on above contacts",
                  //   textAlign: TextAlign.center,
                  // ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
