import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_portal/utils/widgets/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../app_config.dart';
import '../../../utils/services/dio_service.dart';
import '../../../utils/widgets/datepicker_widget.dart';
import '../../../utils/widgets/my_widgets.dart';
import '../../../utils/widgets/textfield_widget.dart';
import '../manage_trade_license.dart';

class OrganizationInfo extends StatefulWidget {
  final PageController pageController;

  const OrganizationInfo({super.key, required this.pageController});

  @override
  State<OrganizationInfo> createState() => _OrganizationInfoState();
}

class _OrganizationInfoState extends State<OrganizationInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm() async {
    try {
      context.loaderOverlay.show();
      Response response =
          await DioService.postRequest(url: AppConfig.saveTradeLicense, body: {
        'application_id': TradeLicenseForm.applicationId,
        'org_name_bangla':
            TradeLicenseForm.organizationNameBanglaController.text,
        'org_name_english':
            TradeLicenseForm.organizationNameEnglishController.text,
        'business_description': TradeLicenseForm.businessDetailsController.text,
        'business_start_date': TradeLicenseForm.businessStartDate != null
            ? DateFormat('yyyy-MM-dd')
                .format(TradeLicenseForm.businessStartDate!)
            : null,
        'first_issue_date': TradeLicenseForm.businessRegistrationDate != null
            ? DateFormat('yyyy-MM-dd')
                .format(TradeLicenseForm.businessRegistrationDate!)
            : null,
        'business_address': TradeLicenseForm.businessAddressController.text,
        'market_name': TradeLicenseForm.marketNameController.text,
        'floor_no': TradeLicenseForm.floorNumberController.text,
        'shop_no': TradeLicenseForm.shopNumberController.text,
        "is_active": 3
      });

      print(response.data);

      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        widget.pageController.jumpToPage(
          4,
        );
      }
    } catch (e) {
      print(e.toString());

      context.loaderOverlay.hide();
      MyWidgets().showToast(
        message:
        'দুঃখিত, আপনার আবেদনটি সম্পন্ন হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন',
        type: ToastificationType.error,
        icon: Icons.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text('প্রতিষ্ঠানের তথ্য',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'প্রতিষ্ঠানের নাম (বাংলা)',
                    isRequired: true,
                    controller:
                        TradeLicenseForm.organizationNameBanglaController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'প্রতিষ্ঠানের নাম প্রয়োজনীয় (বাংলা)';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[\u0980-\u09FF\s]'))
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'প্রতিষ্ঠানের নাম বাংলায় লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'প্রতিষ্ঠানের নাম (ইংরেজি)',
                    isRequired: true,
                    controller:
                        TradeLicenseForm.organizationNameEnglishController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'প্রতিষ্ঠানের নাম প্রয়োজনীয় (ইংরেজি)';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'ইংরেজিতে নাম লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'ব্যবসার বিবরণ',
                    controller: TradeLicenseForm.businessDetailsController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'ব্যবসার বিবরণ লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DatepickerWidget(
                        title: 'ব্যবসা শুরুর তারিখ',
                        hint: TradeLicenseForm.businessStartDate == null
                            ? 'DD-MM-YYYY'
                            : DateFormat('MMM d, yyyy')
                                .format(TradeLicenseForm.businessStartDate!),
                        header: 'ব্যবসা শুরুর তারিখ নির্বাচন করুন',
                        initialDateTime: TradeLicenseForm.businessStartDate ??
                            DateTime.now(),
                        onDateTimeChanged: (DateTime newDate) {
                          TradeLicenseForm.businessStartDate = newDate;
                        },
                        minimumDate: DateTime(1920),
                        maximumDate: DateTime.now(),
                        onConfirm: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          setState(() {
                            TradeLicenseForm.businessStartDate = null;
                          });
                          Navigator.pop(context);
                        },
                        mode: CupertinoDatePickerMode.date, // Optional
                      ),
                      const SizedBox(width: 20),
                      DatepickerWidget(
                        title: '১ম নিবন্ধনের তারিখ',
                        hint: TradeLicenseForm.businessRegistrationDate == null
                            ? 'DD-MM-YYYY'
                            : DateFormat('MMM d, yyyy').format(
                                TradeLicenseForm.businessRegistrationDate!),
                        header: '১ম নিবন্ধনের তারিখ নির্বাচন করুন',
                        initialDateTime:
                            TradeLicenseForm.businessRegistrationDate ??
                                DateTime.now(),
                        onDateTimeChanged: (DateTime newDate) {
                          TradeLicenseForm.businessRegistrationDate = newDate;
                        },
                        minimumDate: DateTime(1920),
                        maximumDate: DateTime.now(),
                        onConfirm: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          setState(() {
                            TradeLicenseForm.businessRegistrationDate = null;
                          });
                          Navigator.pop(context);
                        },
                        mode: CupertinoDatePickerMode.date, // Optional
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'ব্যবসায় প্রতিষ্ঠানের ঠিকানা',
                    controller: TradeLicenseForm.businessAddressController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'ব্যবসায় প্রতিষ্ঠানের ঠিকানা লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'মার্কেটের নাম',
                    controller: TradeLicenseForm.marketNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'মার্কেটের নাম লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'ফ্লোর নম্বর',
                    controller: TradeLicenseForm.floorNumberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'ফ্লোর নম্বর লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'দোকান নম্বর',
                    controller: TradeLicenseForm.shopNumberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'দোকান নম্বর লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWidget(
                          title: 'পূর্বে',
                          buttonColor: Colors.grey,
                          onPressed: () {
                            widget.pageController.jumpToPage(2);
                          }),
                      const SizedBox(width: 10),
                      ButtonWidget(
                          title: 'পরবর্তী',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitForm();
                            } else {
                              MyWidgets().showToast(
                                message: 'সব * চিহ্নিত ঘর পূরণ করুন',
                                icon: Icons.error,
                                type: ToastificationType.error,
                              );
                            }
                          })
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
