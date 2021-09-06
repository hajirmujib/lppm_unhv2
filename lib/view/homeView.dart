import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/artikelC.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/services/baseServices.dart';
import 'package:lppm_unhv2/view/detailJurnal.dart';

import 'package:lppm_unhv2/view/detailNews.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/centerTitleText.dart';

class HomeView extends StatelessWidget {
  // const HomeView({ Key? key }) : super(key: key);

  final ArtikelC artikelC = Get.put(ArtikelC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "LPPM UNH",
          style: StyleText(),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: artikelC.fetchArtikel,
          child: SingleChildScrollView(
            child: Column(
              children: [JurnalContainer(), BeritaContainer()],
            ),
          ),
        ),
      ),
    );
  }
}

class BeritaContainer extends StatelessWidget {
  final ArtikelC artikelC = Get.put(ArtikelC());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Center(
            child: Text(
              "Berita Terbaru",
              style: StyleText(),
            ),
          ),
          Obx(() {
            if (artikelC.isLoading.value) {
              return CircularProgressIndicator(
                backgroundColor: Colors.white,
              );
            } else if (artikelC.artikelList.isEmpty) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width - 100,
                child: Center(
                  child: Text("Data Belum Ada"),
                ),
              );
            }
            return ListView.builder(
                itemCount: artikelC.artikelList.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int i) {
                  var x = artikelC.artikelList[i];
                  return InkWell(
                    onTap: () {
                      Get.to(() => DetailNews(),
                          transition: Transition.leftToRight,
                          arguments: {
                            "id": x.idAtk,
                          });
                    },
                    child: ItemListContainer(
                      id: "0",
                      image: x.file,
                      title: x.atkJudul,
                      dateNews: x.atkTanggal.toString(),
                      jenis: "artikel",
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }
}

class JurnalContainer extends StatelessWidget {
  final JurnalC jurnalC = Get.put(JurnalC());

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      width: widthScreen,
      height: heightScreen / 2,
      color: Colors.white,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Center(
            child: Text(
              "Jurnal Terbaru",
              style: StyleText(),
            ),
          ),
          SizedBox(
            height: heightScreen / 2 - 50,
            child: Obx(() {
              if (jurnalC.isLoading.value) {
                return CircularProgressIndicator(
                  backgroundColor: Colors.white,
                );
              } else if (jurnalC.jurnalList.isEmpty) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width - 100,
                  child: Center(
                    child: Text("Data Belum Ada"),
                  ),
                );
              }

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: jurnalC.jurnalList.length ?? 0,
                  itemBuilder: (context, int i) {
                    var x = jurnalC.jurnalList[i];
                    return InkWell(
                      onTap: () {
                        jurnalC.idJurnal.value = x.id;
                        Get.to(() => DetailJurnal());
                      },
                      child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: x.cover == ""
                                ? Image.asset(
                                    "asset/image/cover.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(BaseServices().urlFile +
                                    "/api_apk/keluaran/" +
                                    x.cover)),
                        width: widthScreen / 3 + 40,
                        height: heightScreen / 3,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.5)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset:
                                  Offset(2, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
