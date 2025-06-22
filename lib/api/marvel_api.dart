import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as api;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarvelApi {
  static final String _baseUrl = dotenv.env['baseUrl']!;
  static final _ts = DateTime.now().millisecondsSinceEpoch;
  static final String _apikey = dotenv.env['pubkey']!;
  static final String _pvtkey = dotenv.env['pvtkey']!;

  static final String _message = _ts.toString() + _pvtkey + _apikey;
  static final String _hash = md5.convert(utf8.encode(_message)).toString();

  static final String _apiAuth = 'ts=$_ts&apikey=$_apikey&hash=$_hash';

  static List<T> responseMapping<T>(
    api.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final results = body['data']['results'] as List;
      return results.map((item) => fromJson(item)).toList();
    } else {
      throw Exception('Erro ao acessar a api!');
    }
  }

  static Future<List<T>> fetchAllData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    var offset = Random();

    final response = await api.get(
      Uri.parse(
        '$_baseUrl/$endpoint?$_apiAuth&orderBy=modified&offset=${offset.nextInt(1000)}&limit=100',
      ),
    );

    return responseMapping(response, fromJson);
  }

  static Future<List<T>> fetchData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await api.get(Uri.parse('$endpoint?$_apiAuth'));

    return responseMapping(response, fromJson);
  }

  static Future<List<T>> fetchByName<T>(
    String endpoint,
    String name,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final param =
        endpoint.contains('comics') ? 'titleStartsWith' : 'nameStartsWith';

    final response = await api.get(
      Uri.parse('$_baseUrl/$endpoint?$_apiAuth&$param=$name'),
    );

    return responseMapping(response, fromJson);
  }

  static Future<List<T>> fetchById<T>(
    String endpoint,
    String id,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await api.get(
      Uri.parse('$_baseUrl/$endpoint/$id?$_apiAuth'),
    );

    return responseMapping(response, fromJson);
  }
}
