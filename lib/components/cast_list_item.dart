import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pookieview/constant/constants.dart';
import 'package:pookieview/model/cast_model.dart';

class CastListItem extends StatelessWidget {
  final CastModel castModel;
  const CastListItem({super.key, required this.castModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: 120,
      child: Column(
        children: [
          CachedNetworkImage(
            imageBuilder: (context, ImageProvider) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: ImageProvider, fit: BoxFit.cover),
              ),
            ),
            width: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: kMovieDbImageUrl + castModel.profilePath.toString(),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            castModel.name.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            castModel.knownForDepartment.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
