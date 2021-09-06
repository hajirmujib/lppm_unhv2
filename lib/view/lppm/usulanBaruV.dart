import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/view/detailProposal.dart';
import 'package:lppm_unhv2/view/searchUsulanBaru.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LppmUsulanBaru extends StatelessWidget {
  // const LppmUsulanProposal({Key key}) : super(key: key);
  final uProposal = Get.put(UsulanProposalC());
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
            showSearch(context: context, delegate: SearchUsulanBaru());
          }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Usulan Proposal Baru",
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
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: uProposal.lppmUsulanProposal,
          child: Obx(() {
            if (uProposal.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            } else if (uProposal.proposalList.isEmpty) {
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
                    itemCount: uProposal.proposalBaru.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var x = uProposal.proposalBaru[i];
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => DetailProposal(),
                            transition: Transition.leftToRight,
                          );
                          uProposal.idProposal.value = x.id ?? "";
                          uProposal.idReviewer = x.idReviewer ?? "";
                          uProposal.idUser = x.idUsers ?? "";
                          uProposal.judul = x.judul ?? "";
                          uProposal.status.value = x.status ?? "";
                          uProposal.jenis = x.jenis ?? "";
                          uProposal.proposalText = x.proposal;
                          komentarProposal.idProposal.value = x.id ?? "";
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
                            id: x.id ?? "",
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
                                      ? uProposal.showDialog(id: x.id)
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
