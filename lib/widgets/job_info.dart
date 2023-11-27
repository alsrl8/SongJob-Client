import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:song_job/services/api_service.dart';
import 'package:song_job/services/favorite.dart';
import 'package:song_job/widgets/job_post_card.dart';

class JobInfoWidget extends StatefulWidget {
  const JobInfoWidget({Key? key}) : super(key: key);

  @override
  State<JobInfoWidget> createState() => _JobInfoWidgetState();
}

class _JobInfoWidgetState extends State<JobInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildJobInfo(context);
  }

  Widget _buildJobInfo(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    const cacheKey = 'dummy_cache_key';

    return FutureBuilder<List<JobPost>>(
      future: fetchJobPostData(cacheKey),
      builder: (context, snapshot) =>
          _buildSwiper(context, snapshot, screenWidth, screenHeight),
    );
  }

  Widget _buildSwiper(BuildContext context,
      AsyncSnapshot<List<JobPost>> snapshot, double width, double height) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      return _buildJobSwiper(snapshot.data!, width, height);
    } else {
      return const Center(child: Text('No data available'));
    }
  }

  Widget _buildJobSwiper(List<JobPost> data, double width, double height) {
    return Swiper(
      itemBuilder: (context, index) {
        var jobPost = data[index];
        return _buildJobSwiperWithFavorite(jobPost);
      },
      indicatorLayout: PageIndicatorLayout.COLOR,
      itemCount: data.length,
      layout: SwiperLayout.TINDER,
      itemWidth: width,
      itemHeight: height,
    );
  }

  Widget _buildJobSwiperWithFavorite(JobPost jobPost) {
    return FutureBuilder<bool>(
      future: isFavorite(jobPost),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingJobPostCard(jobPost);
        } else if (snapshot.hasError) {
          return _buildErrorJobPostCard(jobPost);
        }

        bool isFav = snapshot.data ?? false;
        return jobPostCard(
          jobPost,
          FavoriteButtonData(
            isFavorite: isFav,
            isLoaded: true,
            onPressed: () => switchFavorite(jobPost, _handleFavoriteChanged),
          ),
        );
      },
    );
  }

  Widget _buildLoadingJobPostCard(JobPost jobPost) {
    return jobPostCard(
      jobPost,
      FavoriteButtonData(isFavorite: false, isLoaded: false),
    );
  }

  Widget _buildErrorJobPostCard(JobPost jobPost) {
    return jobPostCard(
      jobPost,
      FavoriteButtonData(isFavorite: false, isLoaded: false),
    );
  }

  void _handleFavoriteChanged() {
    setState(() {

    });
  }
}