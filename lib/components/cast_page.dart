import 'package:flutter/material.dart';
import 'package:pookieview/components/cast_list_item.dart';
import 'package:pookieview/model/cast_model.dart';
import 'package:pookieview/service/api_service.dart';

class CastPage extends StatefulWidget {
  final int id;
  final ProgramType programType;
  const CastPage({super.key, required this.id, required this.programType});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CastModel> castList = snapshot.data ?? [];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CastListItem(castModel: castList[index]);
            },
            itemCount: castList.length,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: apiService.getCastList(widget.id, widget.programType),
    );
  }
}
