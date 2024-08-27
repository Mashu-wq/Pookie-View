import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pookieview/constant/constants.dart';
import 'package:pookieview/model/movie_model.dart';
import 'package:pookieview/ui/movie/movie_details.dart';

class MovieListItem extends StatelessWidget {
  final MovieModel movieModel;
  const MovieListItem({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                      movieModel: movieModel,
                    )));
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 140,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: kMovieDbImageUrl + movieModel.posterPath.toString(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              movieModel.title.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w300, color: Colors.white),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
