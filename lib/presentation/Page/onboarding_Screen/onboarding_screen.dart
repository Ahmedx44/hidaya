import 'package:flutter/material.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/presentation/Page/auth/sigin.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Introduction> list = [
      Introduction(
        title: 'Strengthen Your Faith',
        subTitle:
            'Experience a user-friendly app designed to enhance your spiritual practice with ease',
        imageUrl: AppImage.mesjid,
      ),
      Introduction(
        title: 'Learn and Reflect',
        subTitle:
            'Dive into the wisdom of the Quran and Hadith to enhance your understanding of Islam',
        imageUrl: AppImage.quran,
      ),
    ];
    return IntroScreenOnboarding(
      backgroudColor: Theme.of(context).colorScheme.surface,
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
      },
    );
  }
}
