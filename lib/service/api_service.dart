import 'dart:convert';

import 'package:http/http.dart';
import 'package:pookieview/constant/constants.dart';
import 'package:pookieview/model/cast_model.dart';
import 'package:pookieview/model/movie_model.dart';
import 'package:pookieview/model/video_model.dart';
import 'package:pookieview/ui/tv/model/tv_model.dart';

enum MovieType {
  nowPlaying,
  popular,
  topRated,
  upcoming,
  similar,
}

enum TvType {
  airing_today,
  on_the_air,
  popular,
  top_rated,
  similar,
}

enum ProgramType {
  tv,
  movie,
}

class ApiService {
  Future<List<MovieModel>> getMovieData(MovieType type,
      {int movieId = 0}) async {
    String url = "";

    if (type == MovieType.nowPlaying) {
      url = kMovieDbURL + kNowPlaying;
    } else if (type == MovieType.popular) {
      url = kMovieDbURL + kPopular;
    } else if (type == MovieType.topRated) {
      url = kMovieDbURL + kTopRated;
    } else if (type == MovieType.upcoming) {
      url = kMovieDbURL + kUpcoming;
    } else if (type == MovieType.similar) {
      url = kMovieDbURL + movieId.toString() + kSimilar;
    }

    try {
      Response response = await get(Uri.parse(url + ApiKey));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];

        List<MovieModel> movieList = body.map((item) {
          return MovieModel.fromJson(item);
        }).toList();

        return movieList;
      } else {
        throw ("no movie found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<TvModel>> getTvData(TvType type, {int tvId = 0}) async {
    String url = "";

    if (type == TvType.popular) {
      url = kTvDbUrl + kPopularTv;
    } else if (type == TvType.top_rated) {
      url = kTvDbUrl + kTopRatedTv;
    } else if (type == TvType.on_the_air) {
      url = kTvDbUrl + kTopRatedTv;
    } else if (type == TvType.airing_today) {
      url = kTvDbUrl + kAiringToday;
    } else if (type == TvType.similar) {
      url = kTvDbUrl + tvId.toString() + kSimilar;
    }
    try {
      Response response = await get(Uri.parse(url + ApiKey));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];

        List<TvModel> TvProgramList = body.map((item) {
          return TvModel.fromJson(item);
        }).toList();

        return TvProgramList;
      } else {
        throw ("no movie found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<VideoModel>> getVideos(int id, ProgramType type) async {
    String url = "";

    if (type == ProgramType.movie) {
      url = kMovieDbURL + id.toString() + kVideos;
    } else if (type == ProgramType.tv) {
      url = kTvDbUrl + id.toString() + kVideos;
    }
    try {
      Response response = await get(Uri.parse(url + ApiKey));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['results'];

        List<VideoModel> videoList = body.map((item) {
          return VideoModel.fromJson(item);
        }).toList();

        return videoList;
      } else {
        throw ("no video found");
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CastModel>> getCastList(int id, ProgramType type) async {
    String url = "";

    if (type == ProgramType.movie) {
      url = kMovieDbURL + id.toString() + kCredit;
    } else if (type == ProgramType.tv) {
      url = kTvDbUrl + id.toString() + kCredit;
    }
    try {
      Response response = await get(Uri.parse(url + ApiKey));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['cast'];

        List<CastModel> castList = body.map((item) {
          return CastModel.fromJson(item);
        }).toList();

        return castList;
      } else {
        throw ("no cast found");
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
