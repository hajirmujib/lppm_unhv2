import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/downloadFile.dart';
import 'package:lppm_unhv2/controller/komentarProposalC.dart';
import 'package:lppm_unhv2/controller/penelitianC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/model/detailProposal.dart';
import 'package:lppm_unhv2/model/komentarProposalM.dart';
import 'package:lppm_unhv2/view/lppm/addPenelitian.dart';
import 'package:lppm_unhv2/widget/detailTextWhite.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/whiteTitleText.dart';
import 'package:sizer/sizer.dart';

class DetailProposal extends StatelessWidget {
  // const DetailProposal({ Key? key }) : super(key: key);
  final proposalC = Get.find<UsulanProposalC>();
  final downloadC = Get.put(DownloadfileC());
  final userC = Get.put(UsersC());
  final komentar = Get.put(KomentarProposalC());
  final penelitian = Get.put(PenelitianC());

  @override
  Widget build(BuildContext context) {
    // final UsulanProposal proposal = proposalC.proposalById();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Detail Proposal",
          style: TextStyle(
            color: MyColor.primaryColor,
          ),
        ),
        leading: InkWell(
          onTap: () {
            proposalC.idProposal.value = "";
            proposalC.hTopContainer.value = 22.h;
            proposalC.visibility(false);
            Get.back();
          },
          child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: MyColor.primaryColor),
              child: Icon(Icons.arrow_back)),
        ),
        actions: [
          userC.levelU.value == "lppm"
              ? InkWell(
                  onTap: () => Get.to(() => AddPenelitian()),
                  child: Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: MyColor.primaryColor),
                      child: LineIcon.checkCircle()),
                )
              : Text(""),
          InkWell(
            onTap: () async {
              await userC.fetchReviewer();
              // String idUser = await userC.getIdUser();
              // String level = await userC.getLevel();
              if (userC.idU.value == proposalC.idUser) {
                proposalC.editJudul();
              } else if (userC.levelU.value == "lppm") {
                proposalC.editReviewer();
              } else if (userC.levelU.value == "reviewer" &&
                  userC.idU.value != proposalC.idUser) {
                proposalC.editStatus();
              }
            },
            child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: MyColor.primaryColor),
                child: LineIcon.edit()),
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Obx(
            () {
              if (proposalC.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return FutureBuilder(
                  future: proposalC.proposalById(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DetailProposalModel proposal = snapshot.data;
                      return Align(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      proposal.judul ?? "",
                                      style: WhiteTitleText(),
                                      textAlign: TextAlign.center,
                                      maxLines: proposalC.maxLine,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Tanggal : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + proposal.tanggal.toString(),
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Dosen Pengusul : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + proposal.dnama ?? "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Reviewer : ",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + proposal.rnama ?? "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Status",
                                        style: DetailTextWhite(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        ": " + proposal.status ?? "",
                                        style: DetailTextWhite(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.white),
                                Text("Proposal", style: DetailTextWhite()),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    proposal.proposal != "" &&
                                            userC.idU.value == proposalC.idUser
                                        ? IconButton(
                                            onPressed: () {
                                              proposalC.editFile();
                                            },
                                            icon: Icon(
                                              Icons.attach_file,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(""),
                                    IconButton(
                                      onPressed: () {
                                        proposal.proposal != ""
                                            ? downloadC.requestDownload(
                                                link: proposal.proposal,
                                                jenis: "fileUsulan")
                                            : proposalC
                                                .showToast("Belum Ada File");
                                      },
                                      icon: proposal.proposal != ""
                                          ? LineIcon.file(
                                              color: Colors.white,
                                            )
                                          : LineIcon.upload(
                                              color: Colors.white),
                                    ),
                                    proposal.proposal != ""
                                        ? Expanded(
                                            child: Text(
                                              proposal.proposal ?? "",
                                              style: DetailTextWhite(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                            ),
                                          )
                                        : Expanded(
                                            child: Text(
                                              "Belum Ada File",
                                              style: DetailTextWhite(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                            ),
                                          )
                                  ],
                                )
                              ],
                            ),
                            width: 100.w,
                            height: 70.h,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                            decoration: BoxDecoration(
                                color: MyColor.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            },
          ),
          Obx(() => Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: IconButton(
                            icon: proposalC.isUp.value == true
                                ? LineIcon.arrowCircleUp()
                                : LineIcon.arrowCircleDown(),
                            onPressed: () {
                              proposalC.setHtopContainer();
                              proposalC.setUp();
                              proposalC.setVisibel();
                            },
                          ),
                        ),
                        Container(
                            width: 90.w,
                            height: 10.h,
                            child: Form(
                              key: komentar.key,
                              child: TextFormField(
                                controller: komentar.komentarTxt,
                                onSaved: komentar.isi,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 18),
                                decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
                                    hintText: "Komentar",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                    prefixIcon: InkWell(
                                        onTap: () {
                                          komentar.uploadKomentar();
                                        },
                                        child: LineIcon.arrowCircleLeft()),
                                    fillColor: Colors.white,
                                    filled: true),
                              ),
                            )),
                        Divider(
                          color: Colors.grey,
                        ),
                        Obx(() {
                          if (komentar.isLoading.value == true) {
                            return Center(child: CircularProgressIndicator());
                          } else if (komentar.komentarList.length == 0) {
                            return Center(
                              child: Text("Belum Ada Komentar"),
                            );
                          }
                          return Visibility(
                            visible: proposalC.visibility.value,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              height: 55.h,
                              width: 100.h,
                              child: ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: komentar.komentarList.length ?? 0,
                                itemBuilder: (context, int i) {
                                  KomentarProposal x = komentar.komentarList[i];
                                  return Slidable(
                                    enabled: userC.idU.value == x.idUsers
                                        ? true
                                        : false,
                                    actionPane: SlidableDrawerActionPane(),
                                    actions: [
                                      InkWell(
                                          onTap: () => komentar.showDialog(
                                              id: x.idKomentar),
                                          child: Icon(LineIcons.trash,
                                              color: Colors.red)),
                                      InkWell(
                                          onTap: () => komentar.showEdit(
                                              id: x.idKomentar,
                                              isi: x.isi ?? ""),
                                          child: Icon(LineIcons.edit,
                                              color: Colors.blue)),
                                    ],
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.indigo,
                                            child: Text(x.nama[0] + x.nama[1]),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(x.nama),
                                                Text(x.tanggal.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                Divider(color: Colors.black),
                                                Text(
                                                  x.isi ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 50,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: 100.w,
                  height: proposalC.hTopContainer.value,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
              ))
        ],
      )),
    );
  }
}
