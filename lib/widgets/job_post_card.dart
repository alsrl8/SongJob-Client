import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:song_job/models/requests.dart';
import 'package:song_job/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

typedef NextJobPostCallback = int Function(int);

class JobPostCardWidget extends StatefulWidget {
  final List<JobPost> jobPosts;
  final double width;
  final double height;
  final Function fetchJobPostsCallback;

  const JobPostCardWidget({
    Key? key,
    required this.jobPosts,
    required this.width,
    required this.height,
    required this.fetchJobPostsCallback,
  }) : super(key: key);

  @override
  State<JobPostCardWidget> createState() => _JobPostCardWidgetState();
}

class _JobPostCardWidgetState extends State<JobPostCardWidget> {
  int _currentIndex = 0;
  int _currentViewIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDraggableJobPostCard();
  }

  Widget _buildDraggableJobPostCard() {
    bool hasJobPosts = _currentViewIndex < widget.jobPosts.length;
    return Draggable(
      feedback: Material(
        elevation: 5.0,
        type: MaterialType.transparency,
        child: _jobCardSizedBox(hasJobPosts, _currentViewIndex),
      ),
      childWhenDragging: _jobCardSizedBox(
          _currentViewIndex + 1 < widget.jobPosts.length,
          _currentViewIndex + 1),
      onDragEnd: _onDragEnd,
      child: _jobCardSizedBox(hasJobPosts, _currentViewIndex),
    );
  }

  SizedBox _jobCardSizedBox(bool show, int viewIndex) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: show ? _jobPostCard(widget.jobPosts[viewIndex]) : Container(),
    );
  }

  void _onDragEnd(DraggableDetails details) async {
    const validOffset = 150;
    if (details.offset.dx.abs() < validOffset) return;

    setState(() => _currentViewIndex++);
    await _handleSwipe(details);
    setState(() {
      if (_currentIndex + 1 < widget.jobPosts.length) {
        _currentIndex++;
      } else {
        widget.fetchJobPostsCallback();
      }
    });
  }

  Future<void> _handleSwipe(DraggableDetails details) async {
    var jobPost = widget.jobPosts[_currentIndex];
    if (details.offset.dx < 0) {
      await _handleSwipeLeft(jobPost);
    } else {
      await _handleSwipeRight(jobPost);
    }
  }

  Future<void> _handleSwipeLeft(JobPost jobPost) async {
    var request = RemoveFromFavoriteRequest(link: jobPost.link);
    await removeFromFavorites(request);
  }

  Future<void> _handleSwipeRight(JobPost jobPost) async {
    var request = AddToFavoritesRequest(link: jobPost.link);
    await addToFavorites(request);
  }

  Widget _jobPostCard(JobPost jobPost) {
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
      width: widget.width,
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
      width: widget.width,
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
