import 'package:flutter/material.dart';
import 'package:pookieview/model/movie_model.dart';
import 'package:pookieview/service/api_service.dart';
import 'package:pookieview/ui/movie/widget/movie_list_item.dart';

class MovieCategory extends StatefulWidget {
  final MovieType movieType;
  final int movieId;
  const MovieCategory({super.key, required this.movieType, this.movieId = 0});

  @override
  State<MovieCategory> createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            apiService.getMovieData(widget.movieType, movieId: widget.movieId),
        builder: (context, snapsot) {
          if (snapsot.hasData) {
            List<MovieModel> movielist = snapsot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return MovieListItem(movieModel: movielist[index]);
              },
              itemCount: movielist.length,
              scrollDirection: Axis.horizontal,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
