import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:song_job/services/api_service.dart';
import 'package:song_job/widgets/favorite.dart';
import 'package:song_job/widgets/job_info.dart';
import 'package:song_job/widgets/job_post_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: getMainWidget(context)),
        bottomNavigationBar(context)
      ],
    );
  }

  Widget getMainWidget(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return JobInfoWidget(); // TODO const를 사용할 것인지 고려
      case 1:
        return favorite(context);
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }

  SafeArea bottomNavigationBar(BuildContext context) {
    return SafeArea(
        child: Theme(
      data: Theme.of(context)
          .copyWith(splashColor: const Color.fromRGBO(255, 135, 84, 0.5)),
      child:
        BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              label: 'JOB',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.not_interested),
              label: 'NONE',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
    ));
  }
}
