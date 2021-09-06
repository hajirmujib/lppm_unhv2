import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lppm_unhv2/controller/jurnalC.dart';
import 'package:lppm_unhv2/controller/optionLaporan.dart';
import 'package:lppm_unhv2/view/detailJurnal.dart';
import 'package:lppm_unhv2/view/searchJurnal.dart';
import 'package:lppm_unhv2/widget/ItemList.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class JurnalLppm extends StatelessWidget {
  // const ListJurnalView({ Key? key }) : super(key: key);
  final JurnalC jurnalC = Get.put(JurnalC());
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
                // penelitianC.fetchPenelitian();
                // ExcelPenelitian().createExcel();
                // jurnalC.fetchJurnal();

                optionLaporanC.jenis.value = "Jurnal";
                // optionLaporanC.changeTahunJurnal();
                optionLaporanC.dropDownMenuTahunPenelitian =
                    optionLaporanC.getDropDownMenuTahunJurnal();
                optionLaporanC.showDialog();
              },
              child: Container(
                width: 10.w,
                height: 10.w,
                margin: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: LineIcon.book(
                  size: 20,
                  color: MyColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Obx(() => RefreshIndicator(
                onRefresh: jurnalC.fetchJurnal,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                      itemCount: jurnalC.jurnalList.length ?? 0,
                      itemBuilder: (context, int i) {
                        var x = jurnalC.jurnalList[i];
                        return InkWell(
                          onTap: () {
                            jurnalC.idJurnal.value = x.id;
                            Get.to(DetailJurnal());
                          },
                          child: ItemListContainer(
                            id: x.id,
                            image: x.cover ?? "",
                            title: x.judul,
                            dateNews: x.tanggal.toString(),
                            jenis: "jurnal",
                          ),
                        );
                      }),
                ),
              )),
        ));
  }
}
