import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/view/detailProposal.dart';
import 'package:lppm_unhv2/view/lppm/tahunUsulan.dart';
import 'package:lppm_unhv2/view/searchUsulanDiterima.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class PenelitianEksternalL extends StatelessWidget {
  final komentarProposal = Get.put(KomentarProposalC());
  final penelitian = Get.put(PenelitianC());
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
            showSearch(context: context, delegate: SearchUsulanDiterima());
          }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "List Penelitian Eksternal",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
          maxLines: 3,
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
            onTap: () => Get.to(() => TahunUsulanV(),
                transition: Transition.leftToRight,
                duration: Duration(milliseconds: 500)),
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
          InkWell(
            // onTap: () {
            //   penelitian.lppmUsulanBaru();
            //   Get.to(() => LppmUsulanBaru(),
            //       transition: Transition.leftToRight,
            //       duration: Duration(milliseconds: 500));
            // },
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.book,
                  size: 20,
                  color: MyColor.primaryColor,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: penelitian.getPenelitianEksternal,
          child: Obx(() {
            if (penelitian.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (penelitian.penelitianEksternalList.isEmpty) {
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
                    itemCount: penelitian.penelitianEksternalList.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var x = penelitian.penelitianEksternalList[i];
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => DetailProposal(),
                            transition: Transition.leftToRight,
                          );

                          komentarProposal.idProposal.value =
                              x.idPenelitian ?? "";
                          komentarProposal.fetchKomentarProposal();
                          penelitian.judulPenelitian = x.judul;
                          penelitian.jenis.value = x.jenis;
                          penelitian.idUser.value = x.idUsers;
                          penelitian.jenisDefault.value = x.jenis;
                        },
                        child: Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: ItemListContainer(
                            id: x.idPenelitian ?? "",
                            image: "",
                            title: x.judul ?? "",
                            dateNews: x.tanggal.toString() ?? "",
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
