import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/hkiC.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:sizer/sizer.dart';

import 'detailJurnal.dart';

class SearchHki extends SearchDelegate<String> {
  final hkiC = Get.find<HkiC>();
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
  String get searchFieldLabel => 'Judul';
  @override
  Widget buildResults(BuildContext context) {
    final suggestion = hkiC.hkiList.where((name) {
      return name.judulCiptaan.toLowerCase().contains(query.toLowerCase());
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
                hkiC.idHki.value = x.id;
                Get.to(DetailJurnal());
              },
              child: ItemListContainer(
                id: x.id,
                image: "",
                title: x.judulCiptaan,
                dateNews: x.tahun,
                jenis: "paten",
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = hkiC.hkiList.where((name) {
      return name.judulCiptaan.toLowerCase().contains(query.toLowerCase());
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
                hkiC.idHki.value = x.id;
                Get.to(DetailJurnal());
              },
              child: ItemListContainer(
                id: x.id,
                image: "",
                title: x.judulCiptaan,
                dateNews: x.tahun,
                jenis: "jurnal",
              ),
            );
          }),
    );
  }
}
