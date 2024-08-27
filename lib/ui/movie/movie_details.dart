import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pookieview/components/cast_page.dart';

import 'package:pookieview/constant/constants.dart';
import 'package:pookieview/model/movie_model.dart';
import 'package:pookieview/model/video_model.dart';
import 'package:pookieview/service/api_service.dart';
import 'package:pookieview/ui/movie/movie_category.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatelessWidget {
  final MovieModel movieModel;
  const MovieDetails({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
        appBar: AppBar(
          title: Text(movieModel.title.toString(),
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl:
                          kMovieDbImageUrl + movieModel.backdropPath.toString(),
                    ),
                  ),
                  FutureBuilder(
                    future: apiService.getVideos(
                        movieModel.id ?? 0, ProgramType.movie),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<VideoModel> videos = snapshot.data ?? [];

                        if (videos.isNotEmpty) {
                          return CircleAvatar(
                            child: IconButton(
                                onPressed: () async {
                                  if (!await launchUrl(Uri.parse(
                                      'https://www.youtube.com/embed/${videos[0].key}'))) {
                                    throw Exception('Could not launch');
                                  }
                                },
                                icon: const Icon(Icons.play_circle)),
                          );
                        }
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                movieModel.title.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 20),
              ),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: movieModel.voteAverage ?? 0,
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.deepOrangeAccent,
                      );
                    },
                    itemCount: 5,
                    itemSize: 15,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    movieModel.voteAverage == null
                        ? ""
                        : movieModel.voteAverage!.toStringAsFixed(1),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    "Released:- ${movieModel.releaseDate.toString()}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                movieModel.overview.toString(),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Cast",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 200,
                  child: CastPage(
                      id: movieModel.id ?? 0, programType: ProgramType.movie)),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Similar Movie",
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 200,
                child: MovieCategory(
                  movieType: MovieType.similar,
                  movieId: movieModel.id ?? 0,
                ),
              )
            ]),
          ),
        ));
  }
}
