import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:song_job/models/requests.dart';
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

  static void removeData(String key) {
    _cache.remove(key);
  }
}

void removeCache(String cacheKey) {
  JobPostCacheManager.removeData(cacheKey);
}

Future<List<JobPost>> fetchJobPostData(String cacheKey) async {
  if (cacheKey != "" && JobPostCacheManager.hasData(cacheKey)) {
    return JobPostCacheManager.getData(cacheKey)!;
  }

  var url = Uri.parse('http://192.168.0.6:8080/job-posts');
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

Future<List<JobPost>> fetchFavoriteJobPostData(String cacheKey) async {
  if (JobPostCacheManager.hasData(cacheKey)) {
    return JobPostCacheManager.getData(cacheKey)!;
  }

  var url = Uri.parse(
      'http://192.168.0.6:8080/favorite-job-posts'); // Adjusted API endpoint
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

Future<void> addToFavorites(AddToFavoritesRequest request) async {
  var url = Uri.parse('http://192.168.0.6:8080/add-to-favorites');
  var jsonData = request.toJson();
  try {
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonData));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e, stacktrace) {
    print('Exception occurred: $e');
    print('Stacktrace: $stacktrace'); // This will print the stacktrace
    throw Exception('Error making request: $e');
  }
}

Future<void> removeFromFavorites(RemoveFromFavoriteRequest request) async {
  var url = Uri.parse('http://192.168.0.6:8080/remove-from-favorites');
  var jsonData = request.toJson();
  try {
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonData));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  } catch (e, stacktrace) {
    print('Exception occurred: $e');
    print('Stacktrace: $stacktrace'); // This will print the stacktrace
    throw Exception('Error making request: $e');
  }
}
