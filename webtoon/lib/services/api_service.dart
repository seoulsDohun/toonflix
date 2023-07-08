import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';
import 'package:webtoon/models/webtton_detail_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String todayUrl = 'today';
  static const String episode = 'episodes';

  /* 웹툰 리스트 조회 */
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

  /* 웹툰 상세 조회 */
  static Future<WebToonDetailModel> getDetailWebtoonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoonDetail = jsonDecode(response.body);
      return WebToonDetailModel.fromJson(webtoonDetail);
    }
    throw Error();
  }

  /* 웹툰 에피소드 조회 */
  static Future<List<WebtoonEpisodeModel>> getWebtoonEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> webtoonEpisodeInstances = [];
    final url = Uri.parse('$baseUrl/$id/$episode');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        webtoonEpisodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return webtoonEpisodeInstances;
    }
    throw Error();
  }
}
