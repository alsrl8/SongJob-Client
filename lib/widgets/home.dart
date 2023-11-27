import 'package:flutter/material.dart';
import 'package:song_job/widgets/job_info.dart';

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
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return getMainWidget(context, constraints);
            },
          ),
        ),
        bottomNavigationBar(context)
      ],
    );
  }

  Widget getMainWidget(BuildContext context, BoxConstraints constraints) {
    switch (selectedIndex) {
      case 0:
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight,
          ),
          child: JobInfoWidget(availableHeight: constraints.maxHeight),
        );
      case 1:
        return const Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }

  SafeArea bottomNavigationBar(BuildContext context) {
    return SafeArea(
        child: Theme(
      data: Theme.of(context)
          .copyWith(splashColor: const Color.fromRGBO(255, 135, 84, 0.5)),
      child: BottomNavigationBar(
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
