import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../services/baseServices.dart';

import 'dateText.dart';
import 'myColor.dart';
import 'titleListText.dart';

class ItemListContainer extends StatelessWidget {
  final String image;
  final String title;
  final String dateNews;
  final String id;

  final String jenis;

  const ItemListContainer(
      {Key key,
      @required this.id,
      @required this.image,
      @required this.title,
      @required this.dateNews,
      @required this.jenis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: jenis == "artikel"
                  ? image == ""
                      ? Image.asset(
                          "asset/image/logo_unh.png",
                          fit: BoxFit.cover,
                          width: 100.w / 3,
                          height: 100.h / 7,
                        )
                      : Image.network(
                          BaseServices().urlFile +
                              "/api_apk/fileArtikel/" +
                              image,
                          fit: BoxFit.cover,
                          width: 100.w / 3,
                          height: 100.h / 7,
                        )
                  : image == ""
                      ? Image.asset(
                          "asset/image/logo_unh.png",
                          fit: BoxFit.cover,
                          width: 100.w / 5,
                          height: 100.h / 7,
                        )
                      : Image.network(
                          BaseServices().urlFile + "/api_apk/keluaran/" + image,
                          fit: BoxFit.cover,
                          width: 100.w / 5,
                          height: 100.h / 7,
                        )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TitleListText(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                  ),
                  Text(
                    dateNews,
                    style: DateText(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      width: 100.w,
      height: 100.h / 5,
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColor.secondaryColor),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
