import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lppm_unhv2/controller/loginC.dart';
import 'package:lppm_unhv2/widget/myColor.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget {
  final LoginC loginC = Get.put(LoginC());
  // final keyLogin = new GlobalKey<FormState>();
  final keyLogin = new GlobalKey<FormState>(debugLabel: 'error');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(body: Obx(() {
      if (loginC.loginProcess.value == true) {
        return Container(
          width: 100.w,
          height: 100.h,
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleLogin(width: width, height: height),
              Container(
                alignment: Alignment.bottomCenter,
                width: width,
                height: height / 2 * 1.2,
                decoration: BoxDecoration(
                  color: Color(0xffE4E4E4),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Form(
                  key: keyLogin,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 25),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppin"),
                          ),
                        ),
                      ),
                      Container(
                          width: width - 50,
                          height: 50,
                          child: TextFormField(
                            controller: loginC.usernameTxt,
                            validator: (String value) =>
                                EmailValidator.validate(value)
                                    ? null
                                    : "Email Tidak Valid",
                            onSaved: (e) => loginC.username = e,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 18),
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Email",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                prefixIcon: Icon(Icons.email),
                                fillColor: Colors.white,
                                filled: true),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          width: width - 50,
                          height: 50,
                          child: TextFormField(
                            controller: loginC.passwordTxt,
                            validator: (String value) => value.trim().isEmpty
                                ? "Masukan password!"
                                : null,
                            onSaved: (e) => loginC.password = e,
                            obscureText: loginC.isShow.value,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Password",
                                suffixIcon: Obx(() => IconButton(
                                    onPressed: () => loginC.setIsShow(),
                                    icon: Icon(loginC.isShow.value == true
                                        ? Icons.visibility_off
                                        : Icons.visibility))),
                                prefixIcon: Icon(Icons.lock),
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                                fillColor: Colors.white,
                                filled: true),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          width: width - 50,
                          height: 50,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    MyColor.primaryColor,
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              onPressed: () {
                                final form = keyLogin.currentState;
                                if (form.validate()) {
                                  form.save();
                                  loginC.fetchLogin();
                                }
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}

class TitleLogin extends StatelessWidget {
  const TitleLogin({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.4 - 20,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image(
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            image: AssetImage("asset/image/logo_unh.png"),
          ),
          Text(
            "LPPM Universitas \n Nurdin Hamzah",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: MyColor.primaryColor,
                fontFamily: "Poppins Bold"),
          ),
        ],
      ),
    );
  }
}
