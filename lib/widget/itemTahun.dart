import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'myColor.dart';

class ItemTahun extends StatelessWidget {
  const ItemTahun({
    Key key,
    @required this.tahun,
  }) : super(key: key);

  final String tahun;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 10.h,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        tahun,
        style: TextStyle(
            color: MyColor.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      )),
    );
  }
}
