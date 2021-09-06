import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/view/detailJurnal.dart';
import 'package:lppm_unhv2/view/searchJurnal.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';

class ListJurnalView extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final JurnalC jurnalC = Get.put(JurnalC());

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
              showSearch(context: context, delegate: SearchJurnal());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("List Jurnal"),
        ),
        body: SafeArea(
          child: Obx(() => RefreshIndicator(
                onRefresh: jurnalC.fetchJurnal,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: jurnalC.jurnalList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = jurnalC.jurnalList[i];
                        return InkWell(
                          onTap: () {
                            jurnalC.idJurnal.value = x.id;
                            Get.to(DetailJurnal());
                          },
                          child: ItemListContainer(
                            id: x.id,
                            image: x.cover ?? "",
                            title: x.judul,
                            dateNews: x.tanggal.toString(),
                            jenis: "jurnal",
                          ),
                        );
                      }),
                ),
              )),
        ));
  }
}
