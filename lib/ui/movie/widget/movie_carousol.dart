import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pookieview/constant/colors.dart';
import 'package:pookieview/constant/constants.dart';
import 'package:pookieview/model/movie_model.dart';

class MovieCarousol extends StatefulWidget {
  final List<MovieModel> movieList;
  const MovieCarousol({super.key, required this.movieList});

  @override
  State<MovieCarousol> createState() => _MovieCarousolState();
}

class _MovieCarousolState extends State<MovieCarousol> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: widget.movieList.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: kMovieDbImageUrl +
                    widget.movieList[itemIndex].posterPath.toString(),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 180,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
        ));
  }
}
