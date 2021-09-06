import 'package:flutter/material.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:sizer/sizer.dart';

import 'dateText.dart';
import 'myColor.dart';
import 'titleListText.dart';

class ListUserItem extends StatelessWidget {
  final String image;
  final String title;
  final String nidn;

  final String level;

  const ListUserItem(
      {Key key,
      @required this.image,
      @required this.title,
      @required this.nidn,
      @required this.level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: image == ""
                ? Image.asset(
                    "asset/image/logo_unh.png",
                    fit: BoxFit.cover,
                    width: 100.w / 5,
                    height: 100.h / 7,
                  )
                : Image.network(
                    BaseServices().urlFile + "/api_apk/imageUpload/" + image,
                    fit: BoxFit.cover,
                    width: 100.w / 5,
                    height: 100.h / 7,
                  ),
          ),
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
                    nidn,
                    style: DateText(),
                  ),
                  Text(
                    level,
                    style: DateText(),
                  ),
                ],
              ),
            ),
          )
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
