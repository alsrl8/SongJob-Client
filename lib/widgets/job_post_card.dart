import 'package:flutter/material.dart';
import 'package:song_job/models/job_post.dart';
import 'package:url_launcher/url_launcher.dart';

Widget jobPostCard(JobPost jobPost) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
    elevation: 5,
    margin: const EdgeInsets.all(10),
    child: InkWell(
      onTap: () async {
        var url = Uri.parse(jobPost.link);
        launchUrl(url);
      },
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobPost.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              jobPost.company,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            const Divider(color: Colors.grey, height: 20),
            Text(
              'Techniques: ${jobPost.techniques.join(', ')}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              'Location: ${jobPost.location}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              'Career: ${jobPost.career}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Text(
              'Recruitment Site: ${jobPost.recruitmentSite}',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}
