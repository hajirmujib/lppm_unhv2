import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/widget/listUser.dart';
import 'package:sizer/sizer.dart';

import 'lppm/detailAkun.dart';

class SearchUser extends SearchDelegate<String> {
  final userC = Get.find<UsersC>();
  final String result = "";
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, result);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  String get searchFieldLabel => 'Nama/NIDN';
  @override
  Widget buildResults(BuildContext context) {
    final suggestion = userC.userList.where((name) {
      return name.nama.toLowerCase().contains(query.toLowerCase()) ||
          name.nidn.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
      width: 100.w,
      height: 100.h,
      padding: EdgeInsets.all(5),
      child: ListView.builder(
          itemCount: suggestion.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            var x = suggestion.elementAt(i);
            return InkWell(
              onTap: () {
                userC.idU.value = x.idUsers;
                Get.to(
                  () => DetailAkun(),
                );
              },
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ListUserItem(
                  image: x.foto,
                  title: x.nama,
                  nidn: x.nidn,
                  level: x.level,
                ),
                actions: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: IconSlideAction(
                      caption: "Hapus",
                      foregroundColor: Colors.white,
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        userC.idU.value = x.idUsers;
                        userC.showDialog();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = userC.userList.where((name) {
      return name.nama.toLowerCase().contains(query.toLowerCase()) ||
          name.nidn.toLowerCase().contains(query.toLowerCase());
    });
    return Container(
      width: 100.w,
      height: 100.h,
      padding: EdgeInsets.all(5),
      child: ListView.builder(
          itemCount: suggestion.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            var x = suggestion.elementAt(i);

            return InkWell(
              onTap: () {
                userC.idU.value = x.idUsers;
                Get.to(
                  () => DetailAkun(),
                );
              },
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ListUserItem(
                  image: x.foto,
                  title: x.nama,
                  nidn: x.nidn,
                  level: x.level,
                ),
                actions: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    child: IconSlideAction(
                      caption: "Hapus",
                      foregroundColor: Colors.white,
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        userC.idU.value = x.idUsers;
                        userC.showDialog();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
