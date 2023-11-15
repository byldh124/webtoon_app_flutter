import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/models/webtoon.dart';
import 'package:webtoon_app/models/webtoon_detail.dart';
import 'package:webtoon_app/models/webtoon_episode.dart';
import 'package:webtoon_app/widget/webtoon_widget.dart';

import '../models/webtoon_detail.dart';

class ApiService {
  static final String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static final String today = "today";

  // 네트워크의 응답을 기다리기 위해 리턴타입을 Future 로 바꿔줘야 한다. (async - await)
  // maybe Coroutines suspend?
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');

    //await 을 쓰기 위해서는 함수에 async 를 명시해 줘야 한다.
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //jsonDecode 는 dynamic(어떤 타입도 될수 있음)을 반환한다.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      //print(webtoonInstances);
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodeInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstances;
    }
    throw Error();
  }
}
