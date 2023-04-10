import 'package:dpmaker/Constants/Constants.dart';
import 'package:dpmaker/Localization/AppStrings.dart';
import 'package:dpmaker/Route/Routes.dart';
import 'package:dpmaker/Utils/Extentions.dart';
import 'package:dpmaker/Utils/HiveStoreUtil.dart';
import 'package:dpmaker/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:custom_elements/custom_elements.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkBoxVal = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => backPressed(context),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.login.toLocalized(context),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: TextEditingController(),
                              validator: (val) {
                                if (!Utils.isValidEmail(val)) {
                                  return "Enter valid email";
                                }
                                return null;
                              },
                              hint: "Enter email",
                              displayError: true,
                              keyboardType: TextInputType.emailAddress,
                              onChange: (val) {
                                formKey.currentState!.validate();
                              },
                            ),
                          ),
                          CustomCheckBox(
                            initVal: checkBoxVal,
                            radius: 5,
                            onChnage: (value) {
                              checkBoxVal = value;
                            },
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                CustomButton(
                  title: AppStrings.login.toLocalized(context),
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      Navigator.pushNamed(context,Routes.homeScreen);
                    }
                  },
                ),
                SizedBox(height: 5,),
                CustomButton(
                  title: AppStrings.change_language.toLocalized(context),
                  onTap: () {
                    if(currentAppLocal.value == supportedLocales.first){
                      currentAppLocal.value = supportedLocales[1];
                    } else {
                      currentAppLocal.value = supportedLocales.first;
                    }
                  },
                ),
                SizedBox(height: 5,),
                CustomText(
                  text: HiveStoreUtil.getString(HiveStoreUtil.storageKey),
                ),
                SizedBox(height: 5,),
              ],
            )),
      ),
    );
  }
}
