import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/artikelC.dart';
import 'package:lppm_unhv2/view/lppm/addArtikel.dart';
import 'package:lppm_unhv2/view/lppm/editArtikel.dart';
import 'package:lppm_unhv2/view/searchArtikel.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import '../detailNews.dart';

class ArtikelLppmView extends StatelessWidget {
  // const ArtikelLppmView({Key key}) : super(key: key);
  final ArtikelC artikelC = Get.put(ArtikelC());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColor.primaryColor,
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            showSearch(context: context, delegate: SearchArtikel());
          }),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColor.primaryColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Artikel",
            style: TextStyle(color: Colors.white, fontFamily: "Poppin"),
          ),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: MyColor.primaryColor,
                )),
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.to(
                  () => AddArtikel(),
                  transition: Transition.leftToRight,
                );
              },
              child: Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: MyColor.primaryColor,
                  )),
            )
          ]),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: artikelC.fetchArtikel,
          child: Obx(() {
            if (artikelC.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (artikelC.artikelList.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    width: 80.w,
                    height: 30.h,
                    child: Center(
                      child: Text("Data Belum Ada"),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                width: 100.w,
                height: 100.h,
                padding: EdgeInsets.all(5),
                child: ListView.builder(
                    itemCount: artikelC.artikelList.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var x = artikelC.artikelList[i];
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
          }),
        ),
      ),
    );
  }
}
