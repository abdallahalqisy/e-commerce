import 'package:dio/dio.dart';

class ApiService {
  // Your API service implementation
  final Dio dio = Dio();
  Future<Response> post({
    required body,
    required String url,
    required String token,
    String? contentType,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': Headers.formUrlEncodedContentType,
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
}
