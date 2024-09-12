import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 200,
        width: 400,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          FlutterIslamicIcons.quran,
                          weight: 1.0,
                          size: 35,
                        ),
                        Text(
                          'Last Read',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(height: 50, Appvector.bismillah)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text(
                        'Al-Fatiah',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Ayah No: 1',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 50),
                    child: SvgPicture.asset(height: 80, Appvector.quran),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Icon(Icons.bookmark),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
