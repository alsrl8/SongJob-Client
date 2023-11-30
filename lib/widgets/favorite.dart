import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../models/job_post.dart';

class FavoriteWidget extends StatelessWidget {
  final List<JobPost> jobPosts;
  final ScrollController _scrollController = ScrollController();

  FavoriteWidget({
    super.key,
    required this.jobPosts,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     // height: 200,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: jobPosts.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: 300, // Adjust based on your UI
  //           child: JobPostCard(jobPost: jobPosts[index]),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return _buildWeb();
    } else {
      return _buildMobile();
    }
  }

  Widget _buildWeb() {
    return Container(
      height: 200, // Adjust based on your UI needs
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: jobPosts.length,
          itemBuilder: (context, index) {
            return Container(
              width: 300,
              // Adjust based on your UI needs
              padding: EdgeInsets.symmetric(horizontal: 8),
              // Optional for spacing
              child: JobPostCard(jobPost: jobPosts[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return Container(
      // height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jobPosts.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300, // Adjust based on your UI
            child: JobPostCard(jobPost: jobPosts[index]),
          );
        },
      ),
    );
  }
}

class JobPostCard extends StatelessWidget {
  final JobPost jobPost;

  const JobPostCard({Key? key, required this.jobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      elevation: 5,
      margin: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () => _launchURL(jobPost.link),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              _buildHeader(jobPost),
              const SizedBox(height: 8),
              const Divider(color: Colors.grey, height: 20),
              _buildDetails(jobPost),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(JobPost jobPost) {
    return SizedBox(
      // width: widget.width,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobPost.name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
                const SizedBox(height: 4),
                Text(jobPost.company,
                    style:
                        const TextStyle(fontSize: 18, color: Colors.white70)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetails(JobPost jobPost) {
    return SizedBox(
      // width: widget.width,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Techniques: ${jobPost.techniques.join(', ')}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.white70)),
                Text('Location: ${jobPost.location}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.white70)),
                Text('Career: ${jobPost.career}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.white70)),
                Text('Recruitment Site: ${jobPost.recruitmentSite}',
                    style:
                        const TextStyle(fontSize: 16, color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // Handle URL launch failure
    }
  }
}
