import 'package:flutter/material.dart';
import 'package:pookieview/service/api_service.dart';
import 'package:pookieview/ui/tv/model/tv_model.dart';
import 'package:pookieview/ui/tv/tv_list_item.dart';

class TvCategory extends StatefulWidget {
  final TvType tvType;
  final int tvId;
  const TvCategory({super.key, required this.tvType, this.tvId = 0});

  @override
  State<TvCategory> createState() => _TvCategoryState();
}

class _TvCategoryState extends State<TvCategory> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService.getTvData(widget.tvType, tvId: widget.tvId),
        builder: (context, snapsot) {
          if (snapsot.hasData) {
            List<TvModel> tvList = snapsot.data ?? [];
            return ListView.builder(
              itemBuilder: (context, index) {
                return TvListItem(tvModel: tvList[index]);
              },
              itemCount: tvList.length,
              scrollDirection: Axis.horizontal,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
