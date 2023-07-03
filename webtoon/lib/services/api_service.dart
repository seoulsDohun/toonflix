import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String todayUrl = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> weebtoonInstances = [];
    final url = Uri.parse('$baseUrl/$todayUrl');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        weebtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return weebtoonInstances;
    }
    throw Error();
  }
}
