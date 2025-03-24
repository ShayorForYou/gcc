import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_portal/utils/widgets/button_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../app_config.dart';
import '../../../utils/services/dio_service.dart';
import '../../../utils/widgets/dropdown_widget.dart';
import '../../../utils/widgets/my_widgets.dart';
import '../../../utils/widgets/textfield_widget.dart';
import '../manage_trade_license.dart';

class ApplicantAddress extends StatefulWidget {
  final PageController pageController;

  const ApplicantAddress({super.key, required this.pageController});

  @override
  State<ApplicantAddress> createState() => _ApplicantAddressState();
}

class _ApplicantAddressState extends State<ApplicantAddress> {
  @override
  void initState() {
    _fetchDivision();
    super.initState();
  }

  Future<void> _fetchDivision() async {
    try {
      Response response =
          await DioService.postRequest(body: {}, url: AppConfig.getDivision);
      if (response.statusCode == 200) {
        TradeLicenseForm.presentDivisionList.clear();
        TradeLicenseForm.permanentDivisionList.clear();
        setState(() {
          for (var item in response.data) {
            TradeLicenseForm.presentDivisionList.add(DropdownMenuItem(
              value: item['division_id'],
              child: Text(item['division_name']),
            ));
            TradeLicenseForm.permanentDivisionList.add(DropdownMenuItem(
              value: item['division_id'],
              child: Text(item['division_name']),
            ));
          }
        });
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, বিভাগ লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, বিভাগ লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchDistrict() async {
    try {
      Response response = await DioService.postRequest(
          body: {'division_id': TradeLicenseForm.presentDivision},
          url: AppConfig.getDistrict);
      if (response.statusCode == 200) {
        TradeLicenseForm.presentDistrictList.clear();
        TradeLicenseForm.presentThanaList.clear();
        for (var item in response.data) {
          TradeLicenseForm.presentDistrictList.add(DropdownMenuItem(
            value: item['district_id'],
            child: Text(item['district_name_bangla']),
          ));
        }
        setState(() {});
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, জেলা লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, জেলা লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchThana() async {
    try {
      Response response = await DioService.postRequest(
          body: {'district_id': TradeLicenseForm.presentDistrict},
          url: AppConfig.getThana);
      if (response.statusCode == 200) {
        setState(() {
          TradeLicenseForm.taxZoneList.clear();
          for (var item in response.data) {
            TradeLicenseForm.presentThanaList.add(DropdownMenuItem(
              value: item['police_station_id'],
              child: Text(item['thana_name_bangla']),
            ));
          }
        });
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, থানা লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, থানা লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchPermanentDistrict() async {
    try {
      Response response = await DioService.postRequest(
          body: {'division_id': TradeLicenseForm.permanentDivision},
          url: AppConfig.getDistrict);
      if (response.statusCode == 200) {
        TradeLicenseForm.permanentDistrictList.clear();
        TradeLicenseForm.permanentThanaList.clear();
        for (var item in response.data) {
          TradeLicenseForm.permanentDistrictList.add(DropdownMenuItem(
            value: item['district_id'],
            child: Text(item['district_name_bangla']),
          ));
        }
        setState(() {});
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, জেলা লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, জেলা লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchPermanentThana() async {
    try {
      Response response = await DioService.postRequest(
          body: {'district_id': TradeLicenseForm.permanentDistrict},
          url: AppConfig.getThana);
      if (response.statusCode == 200) {
        setState(() {
          TradeLicenseForm.permanentThanaList.clear();
          for (var item in response.data) {
            TradeLicenseForm.permanentThanaList.add(DropdownMenuItem(
              value: item['police_station_id'],
              child: Text(item['thana_name_bangla']),
            ));
          }
        });
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, থানা লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, থানা লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  _submitForm() async {
    try {
      context.loaderOverlay.show();
      Response response =
          await DioService.postRequest(url: AppConfig.saveTradeLicense, body: {
        'application_id': TradeLicenseForm.applicationId,
        'present_division_id': TradeLicenseForm.presentDivision,
        'present_district_id': TradeLicenseForm.presentDistrict,
        'present_thana_id': TradeLicenseForm.presentThana,
        'present_postcode': TradeLicenseForm.presentPostCodeController.text,
        'present_moholla': TradeLicenseForm.presentAreaController.text,
        'present_road_no': TradeLicenseForm.presentStreetController.text,
        'present_holding_no': TradeLicenseForm.presentHoldingController.text,
        'address_is_same': TradeLicenseForm.isSameAddress,
        'permanent_division_id': TradeLicenseForm.permanentDivision,
        'permanent_district_id': TradeLicenseForm.permanentDistrict,
        'permanent_thana_id': TradeLicenseForm.permanentThana,
        'permanent_postcode': TradeLicenseForm.permanentPostCodeController.text,
        'permanent_moholla': TradeLicenseForm.permanentAreaController.text,
        'permanent_road_no': TradeLicenseForm.permanentStreetController.text,
        'permanent_holding_no':
            TradeLicenseForm.permanentHoldingController.text,
        "is_active": 2
      });

      print(response.data);

      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        widget.pageController.jumpToPage(
          3,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text('আবেদনকারীর ঠিকানা',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 20),
                const Text(
                  'বর্তমান ঠিকানা',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'বিভাগ',
                  value: TradeLicenseForm.presentDivision,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('বিভাগ নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.presentDivisionList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.presentDivision = value;
                      _fetchDistrict();
                      TradeLicenseForm.presentDistrict = null;
                      TradeLicenseForm.presentDistrictList.clear();
                      TradeLicenseForm.presentThana = null;
                      TradeLicenseForm.presentThanaList.clear();
                      // }
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'জেলা',
                  value: TradeLicenseForm.presentDistrict,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('জেলা নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.presentDistrictList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.presentDistrict = value;
                      _fetchThana();
                      TradeLicenseForm.presentThana = null;
                      TradeLicenseForm.presentThanaList.clear();
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'থানা',
                  value: TradeLicenseForm.presentThana,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('থানা নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.presentThanaList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.presentThana = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'পোস্ট কোড',
                  controller: TradeLicenseForm.presentPostCodeController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'পোস্ট কোড লিখুন',
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'মহল্লা',
                  controller: TradeLicenseForm.presentAreaController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'মহল্লা লিখুন',
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'রাস্তা নম্বর',
                  controller: TradeLicenseForm.presentStreetController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'রাস্তা নম্বর লিখুন',
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'হোল্ডিং নম্বর',
                  controller: TradeLicenseForm.presentHoldingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'হোল্ডিং নম্বর লিখুন',
                  ),
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('স্থায়ী এবং বর্তমান ঠিকানা একই',
                      style: TextStyle(fontSize: 14)),
                  value: TradeLicenseForm.isSameAddress,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      TradeLicenseForm.isSameAddress = value!;
                      if (value == false) {}
                    });
                  },
                ),
                const SizedBox(height: 20),
                TradeLicenseForm.isSameAddress
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'স্থায়ী ঠিকানা',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomDropdown(
                            title: 'বিভাগ',
                            value: TradeLicenseForm.permanentDivision,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('বিভাগ নির্বাচন করুন'),
                              ),
                              ...TradeLicenseForm.permanentDivisionList
                            ],
                            onChanged: (value) {
                              setState(() {
                                TradeLicenseForm.permanentDivision = value;
                                _fetchPermanentDistrict();
                                TradeLicenseForm.permanentDistrict = null;
                                TradeLicenseForm.permanentDistrictList.clear();
                                TradeLicenseForm.permanentThana = null;
                                TradeLicenseForm.permanentThanaList.clear();
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomDropdown(
                            title: 'জেলা',
                            value: TradeLicenseForm.permanentDistrict,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('জেলা নির্বাচন করুন'),
                              ),
                              ...TradeLicenseForm.permanentDistrictList
                            ],
                            onChanged: (value) {
                              setState(() {
                                TradeLicenseForm.permanentDistrict = value;
                                _fetchPermanentThana();
                                TradeLicenseForm.permanentThana = null;
                                TradeLicenseForm.permanentThanaList.clear();
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomDropdown(
                            title: 'থানা',
                            value: TradeLicenseForm.permanentThana,
                            items: [
                              const DropdownMenuItem(
                                value: null,
                                child: Text('থানা নির্বাচন করুন'),
                              ),
                              ...TradeLicenseForm.permanentThanaList
                            ],
                            onChanged: (value) {
                              setState(() {
                                TradeLicenseForm.permanentThana = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            title: 'পোস্ট কোড',
                            controller:
                                TradeLicenseForm.permanentPostCodeController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                            decoration: textFieldDecoration.copyWith(
                              hintText: 'পোস্ট কোড লিখুন',
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            title: 'মহল্লা',
                            controller:
                                TradeLicenseForm.permanentAreaController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                            decoration: textFieldDecoration.copyWith(
                              hintText: 'মহল্লা লিখুন',
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            title: 'রাস্তা নম্বর',
                            controller:
                                TradeLicenseForm.permanentStreetController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                            decoration: textFieldDecoration.copyWith(
                              hintText: 'রাস্তা নম্বর লিখুন',
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            title: 'হোল্ডিং নম্বর',
                            controller:
                                TradeLicenseForm.permanentHoldingController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
                            decoration: textFieldDecoration.copyWith(
                              hintText: 'হোল্ডিং নম্বর লিখুন',
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWidget(
                      title: 'পূর্বে',
                      buttonColor: Colors.grey,
                      onPressed: () {
                        widget.pageController.jumpToPage(1);
                      },
                    ),
                    const SizedBox(width: 10),
                    ButtonWidget(
                      title: 'পরবর্তী',
                      onPressed: () {
                        _submitForm();
                      },
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
