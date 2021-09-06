import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/bukuC.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/controller/userC.dart';
import 'package:lppm_unhv2/view/addBuku.dart';
import 'package:lppm_unhv2/view/detailBuku.dart';
import 'package:lppm_unhv2/view/searchBuku.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

import '../editBuku.dart';

class BukuLppm extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final BukuC bukuC = Get.put(BukuC());
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
              showSearch(context: context, delegate: SearchBuku());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("List Buku"),
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
                          optionLaporanC.getDropDownMenuTahunBuku();
                      optionLaporanC.jenis.value = "Buku";
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
                      Get.to(() => AddBuku());
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
                onRefresh: bukuC.fetchBuku,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: bukuC.bukuList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = bukuC.bukuList[i];
                        return InkWell(
                          onTap: () {
                            bukuC.idBuku.value = x.id;
                            Get.to(DetailBuku());
                          },
                          child: Slidable(
                            enabled:
                                userC.levelU.value == "lppm" ? false : true,
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              InkWell(
                                  onTap: () => bukuC.showDialog(id: x.id),
                                  child:
                                      Icon(LineIcons.trash, color: Colors.red)),
                              InkWell(
                                  onTap: () {
                                    bukuC.judul = x.judul;
                                    bukuC.pengarang = x.pengarang;
                                    bukuC.penerbit = x.penerbit;
                                    bukuC.tahunTerbit = x.tahun;
                                    bukuC.ketebalan = x.ketebalan;
                                    bukuC.noEdisi = x.noEdisi;
                                    bukuC.fileTxt.value = x.file;
                                    bukuC.idBuku.value = x.id;
                                    bukuC.idPenelitian.value = x.idPenelitian;
                                    bukuC.idUser.value = x.idUsers;
                                    Get.to(() => EditBuku());
                                  },
                                  child:
                                      Icon(LineIcons.edit, color: Colors.blue)),
                            ],
                            child: ItemListContainer(
                              id: x.id,
                              image: "",
                              title: x.judul,
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
