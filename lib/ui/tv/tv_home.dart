import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pookieview/model/movie_model.dart';
import 'package:pookieview/service/api_service.dart';
import 'package:pookieview/ui/movie/movie_category.dart';
import 'package:pookieview/ui/movie/widget/movie_carousol.dart';
import 'package:pookieview/ui/tv/model/tv_model.dart';
import 'package:pookieview/ui/tv/tv_category.dart';
import 'package:pookieview/ui/tv/widget/tv_carousel.dart';

class TvHome extends StatefulWidget {
  const TvHome({super.key});

  @override
  State<TvHome> createState() => _TvHomeState();
}

class _TvHomeState extends State<TvHome> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      FutureBuilder(
          future: apiService.getTvData(
            TvType.airing_today,
          ),
          builder: (context, snapsot) {
            if (snapsot.hasData) {
              List<TvModel> tvData = snapsot.data ?? [];
              return TvCarousel(
                TvList: tvData,
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
                "Popular Tv",
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
                child: TvCategory(tvType: TvType.popular),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Text(
                    "Top Rated Tv",
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
                    child: TvCategory(tvType: TvType.top_rated),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  Text(
                    "On The Air Tv",
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
                    child: TvCategory(tvType: TvType.on_the_air),
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
