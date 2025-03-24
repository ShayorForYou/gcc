import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_portal/screens/trade_license/manage_trade_license.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../app_config.dart';
import '../../../utils/services/dio_service.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/datepicker_widget.dart';
import '../../../utils/widgets/my_widgets.dart';
import '../../../utils/widgets/textfield_widget.dart';

class ApplicantInfo extends StatefulWidget {
  final PageController pageController;

  const ApplicantInfo({super.key, required this.pageController});

  @override
  State<ApplicantInfo> createState() => _ApplicantInfoState();
}

class _ApplicantInfoState extends State<ApplicantInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm() async {
    try {
      context.loaderOverlay.show();
      Response response =
          await DioService.postRequest(url: AppConfig.saveTradeLicense, body: {
        'application_id': TradeLicenseForm.applicationId,
        "owner_name_bangla":
            TradeLicenseForm.applicantNameBanglaController?.text,
        "owner_name": TradeLicenseForm.applicantNameEnglishController?.text,
        "owner_nid_number": TradeLicenseForm.applicantNidController?.text,
        "owner_date_of_birth": TradeLicenseForm.applicantDob != null
            ? DateFormat('yyyy-MM-dd').format(TradeLicenseForm.applicantDob!)
            : null,
        "owner_mobile_number": TradeLicenseForm.applicantMobileController?.text,
        "phone": TradeLicenseForm.applicantPhoneController?.text,
        "email": TradeLicenseForm.applicantEmailController?.text,
        "owner_father_name": TradeLicenseForm.applicantSpouseController?.text,
        "owner_mother_name": TradeLicenseForm.applicantMotherController?.text,
        "is_active": 1
      });

      print(response.data);

      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        widget.pageController.jumpToPage(
          2,
        );
      }
    } catch (e) {
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
                    child: Text('আবেদনকারীর তথ্য',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'নাম (বাংলা)',
                    isRequired: true,
                    controller: TradeLicenseForm.applicantNameBanglaController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[\u0980-\u09FF\s]'))
                    ],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'নাম দিন';
                      }
                      return null;
                    },
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'নাম লিখুন',
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.grey,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'নাম (ইংরেজি)',
                    controller: TradeLicenseForm.applicantNameEnglishController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      LengthLimitingTextInputFormatter(30),
                    ],
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'নাম লিখুন(ইংরেজি)',
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.grey,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'জাতীয় পরিচয়পত্র নম্বর',
                    controller: TradeLicenseForm.applicantNidController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      LengthLimitingTextInputFormatter(17),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'জাতীয় পরিচয়পত্র নম্বর লিখুন',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          title: 'মোবাইল নম্বর',
                          controller:
                              TradeLicenseForm.applicantMobileController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            LengthLimitingTextInputFormatter(11),
                          ],
                          decoration: textFieldDecoration.copyWith(
                              hintText: 'মোবাইল নম্বর লিখুন',
                              prefixIcon: const Icon(
                                Icons.phone_iphone_rounded,
                                color: Colors.grey,
                                size: 16,
                              )),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: DatepickerWidget(
                            title: 'জন্ম তারিখ',
                            header: 'জন্ম তারিখ নির্বাচন করুন',
                            hint: TradeLicenseForm.applicantDob == null
                                ? 'DD-MM-YYYY'
                                : DateFormat('MMM d, yyyy')
                                    .format(TradeLicenseForm.applicantDob!),
                            onConfirm: () {
                              setState(() {});
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              setState(() {
                                TradeLicenseForm.applicantDob = null;
                              });
                              Navigator.pop(context);
                            },
                            initialDateTime: TradeLicenseForm.applicantDob ??
                                DateTime.now()
                                    .subtract(const Duration(days: 18 * 365)),
                            minimumDate: DateTime(1920),
                            maximumDate: DateTime.now()
                                .subtract(const Duration(days: 18 * 365)),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime newDate) {
                              TradeLicenseForm.applicantDob = newDate;
                            },
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'ফোন',
                    controller: TradeLicenseForm.applicantPhoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'ফোন নম্বর লিখুন',
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'ইমেইল',
                    controller: TradeLicenseForm.applicantEmailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                    ],
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'ইমেইল লিখুন',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'পিতা/স্বামী',
                    controller: TradeLicenseForm.applicantSpouseController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'পিতা/স্বামীর নাম লিখুন',
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.grey,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'মাতা',
                    controller: TradeLicenseForm.applicantMotherController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    decoration: textFieldDecoration.copyWith(
                        hintText: 'মাতার নাম লিখুন',
                        prefixIcon: const Icon(
                          Icons.person_2,
                          color: Colors.grey,
                          size: 16,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWidget(
                        title: 'পূর্বে',
                        buttonColor: Colors.grey,
                        onPressed: () {
                          widget.pageController.jumpToPage(0);
                        },
                      ),
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
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
