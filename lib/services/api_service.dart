import 'dart:convert';
import '../models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<Post> fetchPostDetail(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/$postId'));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch post details');
    }
  }
}
