import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/grafikC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:lppm_unhv2/widget/titleListText.dart';
import 'package:sizer/sizer.dart';

class GrafikV extends StatelessWidget {
  // const Grafik({ Key? key }) : super(key: key);
  final grafikC = Get.put(GrafikC());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Grafik",
          style: TextStyle(
              fontFamily: "Poppins Bold",
              color: MyColor.primaryColor,
              fontSize: 18),
        ),
        leading: InkWell(
          onTap: () {
            grafikC.arr = [];
            Get.back();
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
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Grafik " + grafikC.jenis.value + " Dosen UNH",
                  style: TitleListText(),
                )),
                Text(
                    grafikC.arrInt.length != 1
                        ? "Tahun " +
                            grafikC.tahunMin.toString() +
                            " - " +
                            grafikC.tahunMax.toString()
                        : "Tahun " + grafikC.tahunMin.toString(),
                    style: TitleListText()),
              ],
            ),
          ),
          // Center(
          //     child: grafikC.arrInt.length > 1
          //         ? Text(
          //             "Tahun" +
          //                 grafikC.tahunMulai.value +
          //                 "-" +
          //                 grafikC.tahunSelesai.value,
          //             style: TitleListText())
          //         : Text("Tahun" + grafikC.tahunMulai.value,
          //             style: TitleListText())),
          Container(
            width: 100.w,
            height: 60.h,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: MyColor.primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Obx(
              () => charts.BarChart(
                grafikC.seriesList.toList(),
                animate: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
