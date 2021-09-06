import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/controller/patenC.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/view/addPaten.dart';
import 'package:lppm_unhv2/view/detailPaten.dart';
import 'package:lppm_unhv2/view/editPaten.dart';
import 'package:lppm_unhv2/view/searchPaten.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class PatenLppm extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final PatenC patenC = Get.put(PatenC());
  final optionLaporanC = Get.put(OptionLaporan());
  final userC = Get.put(UsersC());

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
              showSearch(context: context, delegate: SearchPaten());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("List Paten"),
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
                          optionLaporanC.getDropDownMenuTahunPaten();
                      optionLaporanC.jenis.value = "Paten";
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
            userC.levelU.value == "lppm"
                ? Text("")
                : InkWell(
                    onTap: () {
                      Get.to(() => AddPaten());
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
          ],
        ),
        body: SafeArea(
          child: Obx(() => RefreshIndicator(
                onRefresh: patenC.fethPaten,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: patenC.patenList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = patenC.patenList[i];
                        return InkWell(
                          onTap: () {
                            patenC.idPaten.value = x.id;
                            Get.to(DetailPaten());
                          },
                          child: Slidable(
                            enabled:
                                userC.levelU.value == "lppm" ? false : true,
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              InkWell(
                                  onTap: () => patenC.showDialog(id: x.id),
                                  child:
                                      Icon(LineIcons.trash, color: Colors.red)),
                              InkWell(
                                  onTap: () {
                                    patenC.idPaten.value = x.id;
                                    patenC.idPenelitian.value = x.idPenelitian;
                                    patenC.idUser.value = x.idUsers;
                                    patenC.fileTxt.value = x.file;
                                    patenC.judulInvansi = x.judulInvensi;
                                    patenC.noPermohonan = x.noPermohonan;
                                    patenC.tglPengajuan =
                                        x.tglPengajuan.toString() ?? "";
                                    patenC.tglPengajuandate = x.tglPengajuan;
                                    // patenC.dateController.text =
                                    //     x.tglPengajuan.toString();
                                    patenC.tahun = x.tahun;
                                    patenC.pemohon = x.pemohon;

                                    Get.to(() => EditPaten());
                                  },
                                  child:
                                      Icon(LineIcons.edit, color: Colors.blue)),
                            ],
                            child: ItemListContainer(
                              id: x.id,
                              image: "",
                              title: x.judulInvensi,
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
