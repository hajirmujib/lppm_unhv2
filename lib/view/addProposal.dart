import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/usulanProposalC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class AddProposal extends StatelessWidget {
  // const AddProposal({ Key? key }) : super(key: key);
  final proposalC = Get.put(UsulanProposalC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Upload Usulan Proposal",
          style: TextStyle(
              color: Colors.white, fontFamily: "Poppin", fontSize: 15),
          maxLines: 3,
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
              width: 20,
              height: 2,
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
              proposalC.addProposal();
            },
            child: Container(
              width: 10.w,
              height: 10.w,
              margin: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: LineIcon.plus(
                size: 20,
                color: MyColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        width: 100.w,
        height: 100.h,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
            child: Form(
          key: proposalC.keyAdd,
          child: Column(
            children: [
              Text(
                "Judul Propsoal",
                style: TitleListText(),
              ),
              TextFormField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return "Tidak Boleh Kosong";
                  }
                  return null;
                },
                onSaved: (e) => proposalC.judul = e,
                maxLines: 4,
                initialValue: proposalC.judul,
                style: TextStyle(color: Colors.black54, fontSize: 15),
                decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.indigo)),
                    hintText: "Judul",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    fillColor: Colors.white,
                    filled: true),
              ),
              Divider(
                color: Colors.grey,
              ),
              Text(
                "Jenis",
                style: TitleListText(),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: MyColor.primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonFormField<String>(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text("Penelitian"),
                      value: "penelitian",
                    ),
                    DropdownMenuItem(
                      child: Text("Pengabdian"),
                      value: "pengabdian",
                    ),
                  ],
                  onChanged: (String value) {
                    proposalC.jenis = value;
                  },
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Text(
                "File Proposal",
                style: TitleListText(),
              ),
              Obx(() => Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(children: [
                      IconButton(
                        icon: LineIcon.upload(),
                        onPressed: () {
                          proposalC.pickProposalFile();
                        },
                      ),
                      proposalC.proposal.value.path != ""
                          ? Expanded(
                              child: Text(
                                proposalC.proposal.value.path.split('/').last,
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 3,
                              ),
                            )
                          : Expanded(
                              child: Text(
                                proposalC.proposalText.toString() == ""
                                    ? "File Name"
                                    : proposalC.proposalText.toString(),
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 3,
                              ),
                            )
                    ]),
                  ))
            ],
          ),
        )),
      )),
    );
  }
}
