import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteButtonData {
  final bool isFavorite;
  final bool isLoaded;
  final VoidCallback? onPressed;

  FavoriteButtonData({
    required this.isFavorite,
    required this.isLoaded,
    this.onPressed,
  });

  IconButton? get iconButton => isLoaded
      ? IconButton(
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          color: Colors.yellow,
          onPressed: onPressed,
        )
      : null;
}

Widget jobPostCard(JobPost jobPost, FavoriteButtonData favData) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    elevation: 5,
    margin: const EdgeInsets.all(10),
    child: InkWell(
      onTap: () => _launchURL(jobPost.link),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(jobPost, favData),
            const SizedBox(height: 8),
            const Divider(color: Colors.grey, height: 20),
            _buildDetails(jobPost),
          ],
        ),
      ),
    ),
  );
}

Widget _buildHeader(JobPost jobPost, FavoriteButtonData favData) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(jobPost.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            const SizedBox(height: 4),
            Text(jobPost.company, style: const TextStyle(fontSize: 18, color: Colors.white70)),
          ],
        ),
      ),
      if (favData.iconButton != null) favData.iconButton!,
    ],
  );
}

Widget _buildDetails(JobPost jobPost) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Techniques: ${jobPost.techniques.join(', ')}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
      const SizedBox(height: 5),
      Text('Location: ${jobPost.location}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
      const SizedBox(height: 5),
      Text('Career: ${jobPost.career}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
      const SizedBox(height: 5),
      Text('Recruitment Site: ${jobPost.recruitmentSite}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
      const SizedBox(height: 10),
    ],
  );
}

Future<void> _launchURL(String url) async {
  var uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    // Handle the case where the URL cannot be launched
    // e.g., show a dialog or a toast
  }
}
