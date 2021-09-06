import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/informasiC.dart';
import 'package:lppm_unhv2/view/detailInfoView.dart';
import 'package:lppm_unhv2/view/searchInfo.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class ListInfoView extends StatelessWidget {
  final infoC = Get.put(InformasiC());

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
            showSearch(context: context, delegate: SearchInfo());
          }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("List Informasi"),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: infoC.fetchInformasi,
          child: Obx(() {
            if (infoC.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (infoC.informasiList.isEmpty) {
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
                    itemCount: infoC.informasiList.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var x = infoC.informasiList[i];
                      return InkWell(
                        onTap: () => Get.to(() => DetailInfoView(),
                            transition: Transition.leftToRight,
                            arguments: {
                              "id": x.idInfo,
                            }),
                        child: ItemListContainer(
                          id: x.infoIsi,
                          image: "",
                          title: x.infoJudul,
                          dateNews: x.infoTanggal.toString(),
                          jenis: "info",
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
