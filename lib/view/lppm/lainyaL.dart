import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/lainyaC.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/view/addLainya.dart';
import 'package:lppm_unhv2/view/detailLainya.dart';
import 'package:lppm_unhv2/view/editLainya.dart';
import 'package:lppm_unhv2/view/searchLainya.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class LainyaLppm extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final LainnyaC lainyaC = Get.put(LainnyaC());
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
              showSearch(context: context, delegate: SearchLainya());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("List Lainya"),
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
                          optionLaporanC.getDropDownMenuTahunLainya();
                      optionLaporanC.jenis.value = "Lainya";
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
                      Get.to(() => AddLainya());
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
                onRefresh: lainyaC.fethLainya,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: lainyaC.lainnyaList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = lainyaC.lainnyaList[i];
                        return InkWell(
                          onTap: () {
                            lainyaC.idLainya.value = x.id;
                            Get.to(DetailLainya());
                          },
                          child: Slidable(
                            enabled:
                                userC.levelU.value == "lppm" ? false : true,
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              InkWell(
                                  onTap: () => lainyaC.showDialog(id: x.id),
                                  child:
                                      Icon(LineIcons.trash, color: Colors.red)),
                              InkWell(
                                  onTap: () {
                                    lainyaC.nama = x.nama;
                                    lainyaC.keterangan = x.keterangan;
                                    lainyaC.idLainya.value = x.id;
                                    lainyaC.idPenelitian.value = x.idPenelitian;
                                    lainyaC.fileTxt.value = x.file;
                                    Get.to(() => EditLainya());
                                  },
                                  child:
                                      Icon(LineIcons.edit, color: Colors.blue)),
                            ],
                            child: ItemListContainer(
                              id: x.id,
                              image: "",
                              title: x.nama,
                              dateNews: x.tahun.toString(),
                              jenis: "buku",
                            ),
                          ),
                        );
                      }),
                ),
              )),
        ));
  }
}
