import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/view/addJurnal.dart';
import 'package:lppm_unhv2/view/detailJurnal.dart';
import 'package:lppm_unhv2/view/editJurnal.dart';
import 'package:lppm_unhv2/view/searchJurnal.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class JurnalD extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final JurnalC jurnalC = Get.put(JurnalC());

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
              showSearch(context: context, delegate: SearchJurnal());
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("List Jurnal"),
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
                Get.to(() => AddJurnal());
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
          child: Obx(() => RefreshIndicator(
                onRefresh: jurnalC.fetchJurnalDosen,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: jurnalC.jurnalDosenlList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = jurnalC.jurnalDosenlList[i];
                        return InkWell(
                          onTap: () {
                            jurnalC.abstrakTxt.value = x.abstrak;
                            jurnalC.coverTxt.value = x.cover;
                            jurnalC.idUser.value = x.idUser;
                            jurnalC.judulJurnal = x.judul;
                            jurnalC.link = x.link;
                            jurnalC.no = x.no;
                            jurnalC.volume = x.volume;
                            jurnalC.tahun = x.tahun;
                            jurnalC.skema = x.skema;
                            jurnalC.skemaTxt.value = x.skema;
                            jurnalC.idJurnal.value = x.id;
                            Get.to(DetailJurnal());
                          },
                          child: Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actions: [
                              InkWell(
                                  onTap: () => jurnalC.showDialog(id: x.id),
                                  child:
                                      Icon(LineIcons.trash, color: Colors.red)),
                              InkWell(
                                  onTap: () {
                                    jurnalC.abstrakTxt.value = x.abstrak;
                                    jurnalC.coverTxt.value = x.cover;
                                    jurnalC.idUser.value = x.idUser;
                                    jurnalC.judulJurnal = x.judul;
                                    jurnalC.link = x.link;
                                    jurnalC.no = x.no;
                                    jurnalC.volume = x.volume;
                                    jurnalC.tahun = x.tahun;
                                    jurnalC.skema = x.skema;
                                    jurnalC.skemaTxt.value = x.skema;
                                    jurnalC.idJurnal.value = x.id;
                                    jurnalC.idPenelitian.value = x.idPenelitian;
                                    Get.to(() => EditJurnal());
                                  },
                                  child:
                                      Icon(LineIcons.edit, color: Colors.blue)),
                            ],
                            child: ItemListContainer(
                              id: x.id,
                              image: x.cover ?? "",
                              title: x.judul,
                              dateNews: x.tanggal.toString(),
                              jenis: "jurnal",
                            ),
                          ),
                        );
                      }),
                ),
              )),
        ));
  }
}
