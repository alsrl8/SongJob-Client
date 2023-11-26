import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:song_job/models/job_post.dart';

class JobPostCacheManager {
  static final Map<String, List<JobPost>> _cache = {};

  static void storeData(String key, List<JobPost> data) {
    _cache[key] = data;
  }

  static List<JobPost>? getData(String key) {
    return _cache[key];
  }

  static bool hasData(String key) {
    return _cache.containsKey(key);
  }
}

Future<List<JobPost>> fetchJobPostData(String cacheKey) async {
  if (JobPostCacheManager.hasData(cacheKey)) {
    return JobPostCacheManager.getData(cacheKey)!;
  }

  var url = Uri.parse(
      'http://192.168.0.6:8080/jumpit'); // Adjusted API endpoint
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      var data = List<JobPost>.from(
          jsonResponse.map((model) => JobPost.fromJson(model)));
      JobPostCacheManager.storeData(cacheKey, data);
      return data;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e, stacktrace) {
    print('Exception occurred: $e');
    print('Stacktrace: $stacktrace'); // This will print the stacktrace
    throw Exception('Error making request: $e');
  }
}