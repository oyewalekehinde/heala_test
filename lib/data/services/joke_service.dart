import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

import '../model/joke_model.dart';

const String API_KEY = "QUtFhHPnlQ5f13LDVpQL3a54XgQzTlCJa1PMSB3o";

class JokeService {
  static Future<Tuple2<JokeModel?, String?>> getJoke() async {
    var url = "https://joke.api.gkamelo.xyz/random";
    try {
      var response = await http.get(Uri.parse(url),
          headers: {"Accept": "application/json", "x-api-key": API_KEY});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        JokeModel joke = JokeModel.fromJson(jsonResponse);
        return Tuple2(joke, null);
      } else {
        return const Tuple2(null, "Unable to Fetch Joke");
      }
    } catch (e) {
      if (e is SocketException) {
        return const Tuple2(null, "No internet connection");
      } else {
        return const Tuple2(null, "Unable to Fetch Joke");
      }
    }
  }
}
