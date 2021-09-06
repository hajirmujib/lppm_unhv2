import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/informasiC.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:sizer/sizer.dart';

import 'detailInfoView.dart';
import 'lppm/editInfo.dart';

class SearchInfo extends SearchDelegate<String> {
  final infoC = Get.find<InformasiC>();
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
  Widget buildResults(BuildContext context) {
    final suggestion = infoC.informasiList.where((name) {
      return name.infoJudul.toLowerCase().contains(query.toLowerCase());
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
              onTap: () => Get.to(() => DetailInfoView(),
                  transition: Transition.leftToRight,
                  arguments: {
                    "id": x.idInfo,
                  }),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ItemListContainer(
                  id: x.infoIsi,
                  image: "",
                  title: x.infoJudul,
                  dateNews: x.infoTanggal.toString(),
                  jenis: "info",
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
                        infoC.showDialog(id: x.idInfo);
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: IconSlideAction(
                      caption: "Edit",
                      foregroundColor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () {
                        Get.to(EditInfo(), arguments: {
                          "id": x.idInfo,
                          "judul": x.infoJudul,
                          "file": x.lampiran,
                          "isi": x.infoIsi,
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = infoC.informasiList.where((name) {
      return name.infoJudul.toLowerCase().contains(query.toLowerCase());
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
              onTap: () => Get.to(() => DetailInfoView(),
                  transition: Transition.leftToRight,
                  arguments: {
                    "id": x.idInfo,
                  }),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ItemListContainer(
                  id: x.infoIsi,
                  image: "",
                  title: x.infoJudul,
                  dateNews: x.infoTanggal.toString(),
                  jenis: "info",
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
                        infoC.showDialog(id: x.idInfo);
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    child: IconSlideAction(
                      caption: "Edit",
                      foregroundColor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () {
                        Get.to(EditInfo(), arguments: {
                          "id": x.idInfo,
                          "judul": x.infoJudul,
                          "file": x.lampiran,
                          "isi": x.infoIsi,
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
