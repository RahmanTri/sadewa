import 'dart:convert';
// import 'package:get/get_connect.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:sadewa_fe/constants/urls.dart';

class ApiService {
  final String baseUrl = AppUrls.baseApiUrl;

  Future<responseHandler> _handleResponse<responseHandler>(
    http.Response resp,
    responseHandler Function() resultProvider,
    String Function() errorProvider,
  ) async {
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      return resultProvider();
    } else if (resp.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      String errorMessage;
      try {
        final body = jsonDecode(resp.body);
        errorMessage = body['message'] ?? errorProvider();
      } catch (_) {
        errorMessage = errorProvider();
      }
      throw Exception(errorMessage);
    }
  }

  Future<getReq> getRequest<getReq>({
    required String endpoint,
    required getReq Function(String body) parser,
    required String Function(http.Response resp) onError,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http
        .get(url, headers: headers)
        .timeout(const Duration(seconds: 10));

    return _handleResponse<getReq>(
      response,
      () => parser(response.body),
      () => onError(response),
    );
  }

  Future<postReq> postRequest<postReq>({
    required String endpoint,
    Map<String, dynamic>? data,
    required postReq Function(String body) parser,
    required String Function(http.Response resp) onError,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http
        .post(
          url,
          headers: {
            'Content-Type': 'aplication/json',
            if (headers != null) ...headers,
          },
          body: jsonEncode(data ?? {}),
        )
        .timeout(const Duration(seconds: 10));

    return _handleResponse<postReq>(
      response,
      () => parser(response.body),
      () => onError(response),
    );
  }

  Future<postMultiReq> postMultiRequest<postMultiReq>({
    required String endpoint,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
    required postMultiReq Function(String body) parser,
    required String Function(http.Response resp) onError,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final request = http.MultipartRequest('POST', url);
    if (headers != null && headers.isNotEmpty) {
      request.headers.addAll(headers);
    }
    request.headers.putIfAbsent('Accept', () => 'application/json');
    request.fields.addAll(fields);
    request.files.addAll(files);

    final streamed = await request.send().timeout(const Duration(seconds: 10));
    final response = await http.Response.fromStream(streamed);

    return _handleResponse<postMultiReq>(
      response,
      () => parser(response.body),
      () => onError(response),
    );
  }

  Future<putReq> putRequest<putReq>({
    required String endpoint,
    required Map<String, String>? body,
    required putReq Function(String body) parser,
    required String Function(http.Response resp) onError,
    Map<String, dynamic>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http
        .put(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (headers != null) ...headers,
          },
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));

    return _handleResponse<putReq>(
      response,
      () => parser(response.body),
      () => onError(response),
    );
  }

  Future<delReq> deleteRequest<delReq>({
    required String endpoint,
    required delReq Function(String body) parser,
    required String Function(http.Response resp) onError,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http
        .delete(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            if (headers != null) ...headers,
          },
        )
        .timeout(const Duration(seconds: 10));

    return _handleResponse<delReq>(
      response,
      () => parser(response.body),
      () => onError(response),
    );
  }
}
