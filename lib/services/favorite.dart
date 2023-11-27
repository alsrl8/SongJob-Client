import 'dart:ui';

import 'package:song_job/models/job_post.dart';
import 'package:song_job/services/data_service.dart';

Future<bool> isFavorite(JobPost jobPost) async {
  var dbHelper = DatabaseHelper.instance;
  return await dbHelper.isFavorite(jobPost);
}

void switchFavorite(JobPost jobPost) async {
  var dbHelper = DatabaseHelper.instance;
  if (await isFavorite(jobPost) == false) {
    await dbHelper.addToFavorite(jobPost);
  } else {
    await dbHelper.removeFavorite(jobPost);
  }
}
