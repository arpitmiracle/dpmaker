
import 'package:flutter/material.dart';
import 'package:custom_elements/custom_elements.dart';
import 'package:dpmaker/Utils/Extentions.dart';

class HomeScreen extends StatelessWidget {
  ValueNotifier<int> groupValue = ValueNotifier(0);
  ValueNotifier<String?> dropdownValue = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          prefixAction: () {
            Navigator.pop(context);
          },
          prefixIcon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          title: "DP Maker",
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: DateTime.now().timeFormat),
                CustomText(text: DateTime.now().dayFormat),
                CustomText(text: DateTime.now().dateFormat),
                SizedBox(height: 5),
                SizedBox(height: 5),
                CustomToggle(
                  onChanged: (bool? value) {

                  },
                  duration: Duration(milliseconds: 250),
                  value: true,
                ),
                SizedBox(height: 5),
                ValueListenableBuilder(valueListenable: groupValue, builder: (context, value, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CustomRadio(
                          value: 0,
                          groupValue: groupValue.value,
                          onChanged: (val) {
                            groupValue.value = val;
                          },
                        ),
                        SizedBox(width: 5),
                        CustomText(text: "Male")
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        CustomRadio(
                          value: 1,
                          groupValue: groupValue.value,
                          onChanged: (val) {
                            groupValue.value = val;
                          },
                        ),
                        SizedBox(width: 5),
                        CustomText(text: "Female")
                      ],
                    ),
                  ],
                ),),
                SizedBox(height: 5),
                CustomIconButton(icon: Icon(Icons.add),onPressed: () {
                },),
                SizedBox(height: 5),
                ValueListenableBuilder<String?>(
                  valueListenable: dropdownValue,
                  builder: (context, value,child) {
                    return CustomDropdownButton(
                      dropdownItems: ["English","Hindi","Gujarati",],
                      value: value,
                      hint: 'Select language',
                      onChanged: (value) {
                        dropdownValue.value = value;
                      },
                      buttonWidth: 50.w,
                      dropdownWidth: 50.w,
                      dropdownHeight: 50.h,
                    );
                  }
                ),
              ],
            ),
          )),
    );
  }
}
