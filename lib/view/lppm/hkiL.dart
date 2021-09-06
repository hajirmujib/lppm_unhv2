import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/hkiC.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/view/addHki.dart';
import 'package:lppm_unhv2/view/detailHki.dart';
import 'package:lppm_unhv2/view/editHki.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import '../searchHki.dart';

class HkiLppm extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final HkiC hkiC = Get.put(HkiC());
  final userC = Get.put(UsersC());
  final optionLaporanC = Get.put(OptionLaporan());

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
              showSearch(context: context, delegate: SearchHki());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("List HKI"),
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
            userC.levelU.value == "lppm"
                ? InkWell(
                    onTap: () {
                      optionLaporanC.dropDownMenuTahunPenelitian =
                          optionLaporanC.getDropDownMenuTahunHki();
                      optionLaporanC.jenis.value = "Hki";
                      optionLaporanC.showDialog();
                    },
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: LineIcon.book(
                        size: 20,
                        color: MyColor.primaryColor,
                      ),
                    ),
                  )
                : Text(""),
            userC.levelU.value != "lppm"
                ? InkWell(
                    onTap: () {
                      Get.to(() => AddHki());
                    },
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: LineIcon.plus(
                        size: 20,
                        color: MyColor.primaryColor,
                      ),
                    ),
                  )
                : Text(""),
          ],
        ),
        body: SafeArea(
          child: Obx(() => RefreshIndicator(
                onRefresh: hkiC.fetchHki,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: hkiC.hkiList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = hkiC.hkiList[i];
                        return InkWell(
                          onTap: () {
                            hkiC.idHki.value = x.id;
                            Get.to(DetailHki());
                          },
                          child: Slidable(
                            enabled: userC.levelU.value=="lppm"?false:true,
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              InkWell(
                                  onTap: () => hkiC.showDialog(id: x.id),
                                  child:
                                      Icon(LineIcons.trash, color: Colors.red)),
                              InkWell(
                                  onTap: () {
                                    hkiC.fileTxt.value = x.file;
                                    hkiC.idHki.value = x.id;
                                    hkiC.idPenelitian.value = x.idPenelitian;
                                    hkiC.idUser.value = x.idUsers;
                                    hkiC.jangkaWaktu = x.jangkaWaktu;
                                    hkiC.jenisCiptaan = x.jenisCiptaan;
                                    hkiC.judulCiptaan = x.judulCiptaan;
                                    hkiC.nama = x.nama;
                                    hkiC.noPencatatan = x.noPencatatan;
                                    hkiC.noPermohonan = x.noPermohonan;
                                    hkiC.tempatDiumumkan = x.tempatDiumumkan;
                                    hkiC.tglDiumumkan =
                                        x.tglDiumumkan.toString() ?? "";
                                    hkiC.tglPermohonan =
                                        x.tglPermohonan.toString() ?? "";

                                    Get.to(() => EditHki());
                                  },
                                  child:
                                      Icon(LineIcons.edit, color: Colors.blue)),
                            ],
                            child: ItemListContainer(
                              id: x.id,
                              image: "",
                              title: x.judulCiptaan,
                              dateNews: x.tahun.toString(),
                              jenis: "paten",
                            ),
                          ),
                        );
                      }),
                ),
              )),
        ));
  }
}
