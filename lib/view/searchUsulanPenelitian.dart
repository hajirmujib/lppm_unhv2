import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'detailProposal.dart';

class SearchUsulanPenelitian extends SearchDelegate<String> {
  final uProposal = Get.put(UsulanProposalC());
  final komentarProposal = Get.put(KomentarProposalC());
  final penelitian = Get.put(PenelitianC());
  final String result = "";
  final userC = Get.put(UsersC());
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
    final suggestion = uProposal.listPenelitian.where((name) {
      return name.judul.toLowerCase().contains(query.toLowerCase());
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
                      onTap: () {
                        userC.levelU.value == "lppm"
                            ? Fluttertoast.showToast(
                                msg:
                                    "Lppm Tidak Bisa Menghapus Usulan Proposal")
                            : uProposal.showDialog(id: x.id);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = uProposal.listPenelitian.where((name) {
      return name.judul.toLowerCase().contains(query.toLowerCase());
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
                        final pref = await SharedPreferences.getInstance();
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
}
