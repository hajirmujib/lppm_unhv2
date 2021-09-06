import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/artikelC.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:sizer/sizer.dart';

import 'detailNews.dart';
import 'lppm/editArtikel.dart';

class SearchArtikel extends SearchDelegate<String> {
  final artikelC = Get.find<ArtikelC>();
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
    final suggestion = artikelC.artikelList.where((name) {
      return name.atkJudul.toLowerCase().contains(query.toLowerCase());
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
              onTap: () => Get.to(() => DetailNews(),
                  transition: Transition.leftToRight,
                  arguments: {
                    "id": x.idAtk,
                  }),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ItemListContainer(
                  id: x.idAtk,
                  image: x.file,
                  title: x.atkJudul,
                  dateNews: x.atkTanggal.toString(),
                  jenis: "artikel",
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
                        artikelC.showDialog(id: x.idAtk);
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
                        Get.to(EditArtikel(), arguments: {
                          "id": x.idAtk,
                          "judul": x.atkJudul,
                          "file": x.file,
                          "isi": x.atkIsi,
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
    final suggestion = artikelC.artikelList.where((name) {
      return name.atkJudul.toLowerCase().contains(query.toLowerCase());
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
              onTap: () => Get.to(() => DetailNews(),
                  transition: Transition.leftToRight,
                  arguments: {
                    "id": x.idAtk,
                  }),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: ItemListContainer(
                  id: x.idAtk,
                  image: x.file,
                  title: x.atkJudul,
                  dateNews: x.atkTanggal.toString(),
                  jenis: "artikel",
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
                        artikelC.showDialog(id: x.idAtk);
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
                        Get.to(EditArtikel(), arguments: {
                          "id": x.idAtk,
                          "judul": x.atkJudul,
                          "file": x.file,
                          "isi": x.atkIsi,
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
