import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/laporanC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/view/detailLaporan.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ListLaporanL extends StatelessWidget {
  // final komentarProposal = Get.put(KomentarProposalC());
  final penelitian = Get.put(PenelitianC());
  final laporanC = Get.put(LaporanC());
  // final catatanC = Get.put(CatatanHarianC());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: MyColor.primaryColor,
      //     child: Icon(
      //       Icons.search,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       showSearch(context: context, delegate: SearchUsulanDiterima());
      //     }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Laporan Penelitian \n Tahun " + penelitian.tahun.value,
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 12),
          maxLines: 3,
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
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
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: penelitian.getPenelitianInternal,
          child: Obx(() {
            if (penelitian.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (penelitian.penelitianInternalList.isEmpty) {
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
                    itemCount: penelitian.penelitianInternalList.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var x = penelitian.penelitianInternalList[i];
                      return InkWell(
                        onTap: () {
                          laporanC.idUser.value = x.idUser;
                          laporanC.idPenelitian.value = x.idPenelitian;
                          Get.to(
                            () => DetailLaporan(),
                            transition: Transition.leftToRight,
                          );

                          penelitian.idPenelitian.value = x.idPenelitian;
                          penelitian.danaTerpakai.value = x.danaTerpakai;
                          penelitian.danaTersedia.value = x.danaTersedia;
                          penelitian.status.value = x.status;
                          penelitian.judulPenelitian = x.judul;
                          penelitian.jenis.value = x.jenis;
                          penelitian.idUser.value = x.idUsers;
                          penelitian.jenisDefault.value = x.jenis;
                        },
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: Column(
                            children: [
                              ItemListContainer(
                                id: x.idPenelitian ?? "",
                                image: "",
                                title: x.judul ?? "",
                                dateNews: x.nama ?? "",
                                jenis: "info",
                              ),
                            ],
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
                                onTap: () async {
                                  final pref =
                                      await SharedPreferences.getInstance();
                                  String status = pref.getString("status");
                                  status == "dosen"
                                      ? penelitian.showDialog(
                                          id: x.idPenelitian)
                                      : Fluttertoast.showToast(
                                          msg:
                                              "Lppm Tidak Bisa Menghapus Usulan Proposal");
                                },
                              ),
                            ),
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
