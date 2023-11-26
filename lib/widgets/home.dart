import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:song_job/services/api_service.dart';
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
        return jobInfo(context);
      case 1:
        return const Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }

  Widget jobInfo(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var itemWidth = screenSize.width;
    var itemHeight = screenSize.height;
    const cacheKey = 'dummy_cache_key';

    return FutureBuilder<List<JobPost>>(
      future: fetchJobPostData(cacheKey),
      builder: (BuildContext context, AsyncSnapshot<List<JobPost>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              return jobPostCard(snapshot.data![index]);
            },
            indicatorLayout: PageIndicatorLayout.COLOR,
            itemCount: snapshot.data!.length,
            layout: SwiperLayout.TINDER,
            itemWidth: itemWidth,
            itemHeight: itemHeight,
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
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
