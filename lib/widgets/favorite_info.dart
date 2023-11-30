import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:song_job/services/api_service.dart';
import 'package:song_job/widgets/favorite.dart';
import 'package:song_job/widgets/job_post_card.dart';

class FavoriteInfo extends StatefulWidget {
  final double width;
  final double height;
  final String dummyCacheKey = 'dummyCacheKey2';

  const FavoriteInfo({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<FavoriteInfo> createState() => _JobInfoWidgetState();
}

class _JobInfoWidgetState extends State<FavoriteInfo> {
  late List<JobPost> jobPosts;

  @override
  void initState() {
    super.initState();
    var data = fetchFavoriteJobPostData(widget.dummyCacheKey);
    data.then((value) => {jobPosts = value});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JobPost>>(
      future: fetchFavoriteJobPostData(widget.dummyCacheKey),
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
    return buildJobCard(context);
  }

  Widget buildJobCard(BuildContext context) {
    return FavoriteWidget(
      jobPosts: jobPosts,
      // width: widget.width,
      // height: widget.height,
      // fetchJobPostsCallback: () async {
      //   removeCache(widget.dummyCacheKey);
      //   var data = await fetchFavoriteJobPostData(widget.dummyCacheKey);
      //   setState(() {
      //     jobPosts = data;
      //   });
      // },
    );
  }
}

enum Direction { left, right }
