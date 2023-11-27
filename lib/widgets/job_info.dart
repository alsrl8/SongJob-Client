import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:song_job/services/api_service.dart';
import 'package:song_job/services/data_service.dart';
import 'package:song_job/widgets/job_post_card.dart';

class JobInfoWidget extends StatefulWidget {
  final double availableHeight;

  const JobInfoWidget({Key? key, required this.availableHeight})
      : super(key: key);

  @override
  State<JobInfoWidget> createState() => _JobInfoWidgetState();
}

class _JobInfoWidgetState extends State<JobInfoWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JobPost>>(
      future: fetchJobPostData('dummy_cache_key'),
      builder: (context, snapshot) =>
          buildContentBasedOnSnapshot(context, snapshot),
    );
  }

  Widget buildContentBasedOnSnapshot(
      BuildContext context, AsyncSnapshot<List<JobPost>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return buildJobSwiper(context, snapshot.data!);
  }

  Widget buildJobSwiper(BuildContext context, List<JobPost> jobPosts) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Draggable(
      feedback: buildJobCard(context, jobPosts[currentIndex], screenWidth),
      childWhenDragging: currentIndex < jobPosts.length - 1
          ? buildJobCard(context, jobPosts[currentIndex + 1], screenWidth)
          : Container(),
      onDragEnd: (details) =>
          _swipeCard(details, jobPosts[currentIndex], jobPosts.length),
      child: buildJobCard(context, jobPosts[currentIndex], screenWidth),
    );
  }

  void _swipeCard(DraggableDetails details, JobPost jobPost, int dataLength) {
    var dx = details.offset.dx;
    if (dx.abs() <= 150) return;

    if (dx < 0) {
      _swipeLeft();
    } else {
      _swipeRight(jobPost);
    }
    _updateCurrentIndex(dataLength);
  }

  void _swipeLeft() {}

  void _swipeRight(JobPost jobPost) {
    DatabaseHelper.instance.addToFavorite(jobPost);
  }

  void _updateCurrentIndex(int dataLength) {
    setState(() {
      currentIndex = (currentIndex + 1) % dataLength;
    });
  }

  Widget buildJobCard(BuildContext context, JobPost jobPost, double width) {
    return SizedBox(
      width: width,
      height: widget.availableHeight,
      child: JobPostCardWidget(jobPost: jobPost),
    );
  }
}

enum Direction { left, right }
