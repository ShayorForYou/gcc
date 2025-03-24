import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_portal/screens/trade_license/manage_trade_license.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../app_config.dart';
import '../../../utils/services/dio_service.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dropdown_widget.dart';
import '../../../utils/widgets/my_widgets.dart';
import '../../../utils/widgets/textfield_widget.dart';

class BusinessInfo extends StatefulWidget {
  final PageController pageController;

  const BusinessInfo({super.key, required this.pageController});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  @override
  void initState() {
    _fetchBusinessOrgType();
    super.initState();
  }

  Future<void> _fetchBusinessOrgType() async {
    try {
      Response response = await DioService.postRequest(
        body: {},
        url: AppConfig.getBusinessOrgType,
      );
      if (response.statusCode == 200) {
        setState(() {
          TradeLicenseForm.businessOrgTypeList.clear();

          for (var item in response.data) {
            TradeLicenseForm.businessOrgTypeList.add(DropdownMenuItem(
              value: item['business_org_type_id'],
              child: Text(item['business_org_type_name']),
            ));
          }
        });
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, ব্যবসায় প্রতিষ্ঠানের ধরন লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, ব্যবসায় প্রতিষ্ঠানের ধরন লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchBusinessType(int businessOrgTypeId) async {
    try {
      Response response = await DioService.postRequest(
        body: {'business_org_type_id': businessOrgTypeId},
        url: AppConfig.getBusinessType,
      );
      if (response.statusCode == 200) {
        setState(() {
          TradeLicenseForm.businessTypeList.clear();
          TradeLicenseForm.businessType = null;
          TradeLicenseForm.businessSubTypeList.clear();
          TradeLicenseForm.businessSubType = null;
          TradeLicenseForm.businessNatureList.clear();
          TradeLicenseForm.businessNature = null;
          for (var item in response.data) {
            TradeLicenseForm.businessTypeList.add(DropdownMenuItem(
              value: item['business_type_id'],
              child: Text(item['business_type_name']),
            ));
          }
        });
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, ব্যবসার ধরণ লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchBusinessSubType(int businessTypeId) async {
    try {
      Response response = await DioService.postRequest(
        body: {'business_type_id': businessTypeId},
        url: AppConfig.getBusinessSubType,
      );
      if (response.statusCode == 200) {
        TradeLicenseForm.businessSubTypeList.clear();
        TradeLicenseForm.businessSubType = null;
        TradeLicenseForm.businessNatureList.clear();
        TradeLicenseForm.businessNature = null;
        setState(() {
          for (var item in response.data) {
            TradeLicenseForm.businessSubTypeList.add(DropdownMenuItem(
              value: item['business_sub_type_id'],
              child: Text(item['business_sub_type_name']),
            ));
          }
        });
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, ব্যবসার উপধরন লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, ব্যবসার উপধরন লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchBusinessNature() async {
    try {
      Response response = await DioService.postRequest(
        body: {},
        url: AppConfig.getBusinessNature,
      );
      if (response.statusCode == 200) {
        setState(() {
          TradeLicenseForm.businessNatureList.clear();
          TradeLicenseForm.businessNature = null;

          for (var item in response.data) {
            TradeLicenseForm.businessNatureList.add(DropdownMenuItem(
              value: item['business_nature_id'],
              child: Text(item['business_nature_name']),
            ));
          }
        });
      } else {
        MyWidgets().showToast(
          type: ToastificationType.error,
          message: 'দুঃখিত, ব্যবসার প্রকৃতি লোড করতে ত্রুটি হয়েছে',
          icon: Icons.error,
        );
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, ব্যবসার প্রকৃতি লোড করতে ত্রুটি হয়েছে',
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
        'business_org_type_id': TradeLicenseForm.businessOrgType,
        'business_type_id': TradeLicenseForm.businessType,
        'business_sub_type_id': TradeLicenseForm.businessSubType,
        'business_nature_id': TradeLicenseForm.businessNature,
        'business_place_type': TradeLicenseForm.businessPlaceType.toString(),
        'work_type': TradeLicenseForm.businessWorkType.toString(),
        'sign_board_width':
            TradeLicenseForm.businessSignBoardWidthController.text,
        'sign_board_height':
            TradeLicenseForm.businessSignBoardHeightController.text,
        'factory_status': TradeLicenseForm.isFactory.toString(),
        'crimical_status': TradeLicenseForm.isExplosive.toString(),
        'company_rgc_reg_number': TradeLicenseForm.rgcNumberController.text,
        'paid_fee_asset_amount':
            TradeLicenseForm.paidFeeAssetAmountController.text,
        "is_active": 4
      });

      print(response.data);

      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        widget.pageController.jumpToPage(
          5,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text('ব্যবসার তথ্য',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ব্যবসায় প্রতিষ্ঠানের ধরন',
                  isRequired: true,
                  value: TradeLicenseForm.businessOrgType,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('ব্যবসায় প্রতিষ্ঠানের ধরন নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.businessOrgTypeList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.businessOrgType = value;
                      if (value != null) {
                        _fetchBusinessType(value);
                      } else {
                        TradeLicenseForm.businessTypeList.clear();
                        TradeLicenseForm.businessType = null;
                        TradeLicenseForm.businessSubTypeList.clear();
                        TradeLicenseForm.businessSubType = null;
                        TradeLicenseForm.businessNatureList.clear();
                        TradeLicenseForm.businessNature = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ব্যবসার ধরণ',
                  isRequired: true,
                  value: TradeLicenseForm.businessType,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('ব্যবসার ধরণ নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.businessTypeList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.businessType = value;
                      if (value != null) {
                        _fetchBusinessSubType(value);
                      } else {
                        TradeLicenseForm.businessSubTypeList.clear();
                        TradeLicenseForm.businessSubType = null;
                        TradeLicenseForm.businessNatureList.clear();
                        TradeLicenseForm.businessNature = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ব্যবসার উপ-ধরণ',
                  isRequired: true,
                  value: TradeLicenseForm.businessSubType,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('ব্যবসার উপ-ধরণ নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.businessSubTypeList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.businessSubType = value;
                      if (value != null) {
                        _fetchBusinessNature();
                      } else {
                        TradeLicenseForm.businessNatureList.clear();
                        TradeLicenseForm.businessNature = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ব্যবসার প্রকৃতি',
                  isRequired: true,
                  value: TradeLicenseForm.businessNature,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('ব্যবসার প্রকৃতি নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.businessNatureList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.businessNature = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ব্যবসায় স্থানের প্রকৃতি',
                  isRequired: true,
                  value: TradeLicenseForm.businessPlaceType,
                  items: TradeLicenseForm.businessPlaceTypeList,
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.businessPlaceType = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'কার্যক্রমের ধরন',
                  isRequired: true,
                  value: TradeLicenseForm.businessWorkType,
                  items: TradeLicenseForm.businessWorkTypeList,
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.businessWorkType = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'সাইনবোর্ড প্রস্থ (ফিট ইংরেজী)',
                  // controller: _userIdController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'সাইনবোর্ড দৈর্ঘ্য',
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'সাইনবোর্ড দৈর্ঘ্য (ফিট ইংরেজী)',
                  // controller: _userIdController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'সাইনবোর্ড দৈর্ঘ্য',
                  ),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'কারখানা কি না?',
                  isRequired: true,
                  value: TradeLicenseForm.isFactory,
                  items: TradeLicenseForm.isFactoryList,
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.isFactory = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'রাসায়নিক/বিস্ফোরক?',
                  isRequired: true,
                  value: TradeLicenseForm.isExplosive,
                  items: TradeLicenseForm.isExplosiveList,
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.isExplosive = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (TradeLicenseForm.businessNature == 1)
                  Column(
                    children: [
                      CustomTextField(
                        title: 'কোম্পানীর আরজেএসসি রেজিস্ট্রেশন নম্বর',
                        // controller: _userIdController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: textFieldDecoration.copyWith(
                          hintText: 'কোম্পানীর আরজেএসসি রেজিস্ট্রেশন নম্বর দিন',
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'কোম্পানীর পরিশোধিত মূলধনের পরিমাণ (টাকা)',
                        // controller: _userIdController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: textFieldDecoration.copyWith(
                          hintText:
                              'কোম্পানীর পরিশোধিত মূলধনের পরিমাণ (টাকা) দিন',
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
                        widget.pageController.jumpToPage(3);
                      },
                    ),
                    const SizedBox(width: 10),
                    ButtonWidget(
                      title: 'পরবর্তী',
                      onPressed: () {
                        if (TradeLicenseForm.businessOrgType == null ||
                            TradeLicenseForm.businessType == null ||
                            TradeLicenseForm.businessSubType == null ||
                            TradeLicenseForm.businessNature == null ||
                            TradeLicenseForm.businessWorkType == null) {
                          MyWidgets().showToast(
                            message: 'সব * চিহ্নিত ঘর পূরণ করুন',
                            type: ToastificationType.error,
                            icon: Icons.error,
                          );
                        } else {
                          _submitForm();
                        }
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
