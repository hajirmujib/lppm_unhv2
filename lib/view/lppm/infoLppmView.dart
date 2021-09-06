import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/informasiC.dart';
import 'package:lppm_unhv2/view/detailInfoView.dart';
import 'package:lppm_unhv2/view/lppm/addInfo.dart';
import 'package:lppm_unhv2/view/lppm/editInfo.dart';
import 'package:lppm_unhv2/view/searchInfo.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class InfoLppmView extends StatelessWidget {
  // const InfoLppmView({Key key}) : super(key: key);
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
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Informasi",
          style: TextStyle(color: Colors.white, fontFamily: "Poppin"),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
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
            onTap: () => Get.to(() => AddInfo()),
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: MyColor.primaryColor,
                )),
          ),
        ],
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
          }),
        ),
      ),
    );
  }
}
