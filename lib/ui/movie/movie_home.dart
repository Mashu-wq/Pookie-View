import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pookieview/constant/colors.dart';
import 'package:pookieview/model/movie_model.dart';
import 'package:pookieview/service/api_service.dart';
import 'package:pookieview/ui/movie/movie_category.dart';
import 'package:pookieview/ui/movie/widget/movie_carousol.dart';

class MovieHome extends StatefulWidget {
  const MovieHome({super.key});

  @override
  State<MovieHome> createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      FutureBuilder(
          future: apiService.getMovieData(MovieType.nowPlaying),
          builder: (context, snapsot) {
            if (snapsot.hasData) {
              List<MovieModel> moviedata = snapsot.data ?? [];
              return MovieCarousol(
                movieList: moviedata,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      const SizedBox(
        height: 8,
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Popular Movie",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 200,
                child: MovieCategory(movieType: MovieType.popular),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Text(
                    "Top Rated Movie",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 200,
                    child: MovieCategory(movieType: MovieType.topRated),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Text(
                    "Upcoming Movie",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 200,
                    child: MovieCategory(movieType: MovieType.upcoming),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
