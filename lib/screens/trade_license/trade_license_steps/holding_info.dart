import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_portal/app_config.dart';
import 'package:gcc_portal/screens/trade_license/manage_trade_license.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../utils/services/dio_service.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dropdown_widget.dart';
import '../../../utils/widgets/my_widgets.dart';
import '../../../utils/widgets/textfield_widget.dart';

class HoldingInfo extends StatefulWidget {
  final PageController pageController;

  const HoldingInfo({super.key, required this.pageController});

  @override
  State<HoldingInfo> createState() => _HoldingInfoState();
}

class _HoldingInfoState extends State<HoldingInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _fetchTaxZone();
    super.initState();
  }

  Future<void> _fetchTaxZone() async {
    try {
      Response response =
          await DioService.postRequest(body: {}, url: AppConfig.getTaxZone);
      if (response.statusCode == 200) {
      setState(() {
        TradeLicenseForm.taxZoneList.clear();
        for (var item in response.data) {
          TradeLicenseForm.taxZoneList.add(DropdownMenuItem(
            value: item['tax_zone_id'],
            child: Text(item['tax_zone_name']),
          ));
        }
      });
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, ট্যাক্স জোন লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchWard(int taxZoneId) async {
    try {
      Response response = await DioService.postRequest(
        body: {'tax_zone_id': taxZoneId},
        url: AppConfig.getWard,
      );
      if (response.statusCode == 200) {
        setState(() {
          TradeLicenseForm.wardList.clear();
          TradeLicenseForm.ward = null;
          TradeLicenseForm.mouza = null;
          TradeLicenseForm.mouzaList.clear();

          for (var item in response.data) {
            TradeLicenseForm.wardList.add(DropdownMenuItem(
              value: item['word_id'],
              child: Text(item['word_name_bangla']),
            ));
          }
        });
      }
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, ওয়ার্ড তথ্য লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  Future<void> _fetchMouza(int wardId) async {
    try {
      Response response = await DioService.postRequest(
        body: {'ward_id': wardId},
        url: AppConfig.getMouza,
      );
      // if (response.statusCode == 200) {
      setState(() {
        TradeLicenseForm.mouzaList.clear();
        TradeLicenseForm.mouza = null;

        for (var item in response.data) {
          TradeLicenseForm.mouzaList.add(DropdownMenuItem(
            value: item['mouza_id'],
            child: Text(item['mouza_name']),
          ));
        }
      });
    } on DioException catch (e) {
      MyWidgets().showToast(
        type: ToastificationType.error,
        message: 'দুঃখিত, মৌজা তথ্য লোড করতে ত্রুটি হয়েছে',
        icon: Icons.error,
      );
    }
  }

  _submitForm() async {
    try {
      context.loaderOverlay.show();
      Response response =
          await DioService.postRequest(url: AppConfig.saveTradeLicense, body: {
        "tax_zone_id": TradeLicenseForm.taxZone,
        "word_id": TradeLicenseForm.ward,
        "mouza_id": TradeLicenseForm.mouza,
        "block": TradeLicenseForm.blockController?.text,
        "owner_street_address": TradeLicenseForm.streetController?.text,
        "owner_holding": TradeLicenseForm.holdingController?.text,
        "is_active": 0
      });

      print(response.data);

      context.loaderOverlay.hide();
      if (response.statusCode == 200) {
        TradeLicenseForm.applicationId =
            response.data['response']['application_id'];
        widget.pageController.jumpToPage(
          1,
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
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text('হোল্ডিং তথ্য',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ট্যাক্স জোন',
                  isRequired: true,
                  value: TradeLicenseForm.taxZone,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('প্রতিষ্ঠান নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.taxZoneList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.taxZone = value;
                      if (value != null) {
                        _fetchWard(value);
                      } else {
                        TradeLicenseForm.wardList.clear();
                        TradeLicenseForm.ward = null;
                        TradeLicenseForm.mouzaList.clear();
                        TradeLicenseForm.mouza = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'ওয়ার্ড',
                  isRequired: true,
                  value: TradeLicenseForm.ward,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('ওয়ার্ড নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.wardList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.ward = value;
                      if (value != null) {
                        _fetchMouza(value);
                      } else {
                        TradeLicenseForm.mouzaList.clear();
                        TradeLicenseForm.mouza = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  title: 'মৌজা',
                  value: TradeLicenseForm.mouza,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('মৌজা নির্বাচন করুন'),
                    ),
                    ...TradeLicenseForm.mouzaList
                  ],
                  onChanged: (value) {
                    setState(() {
                      TradeLicenseForm.mouza = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: 'ব্লক',
                        controller: TradeLicenseForm.blockController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        decoration: textFieldDecoration.copyWith(
                          hintText: 'ব্লক লিখুন',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomTextField(
                        title: 'রাস্তা/মহল্লা',
                        controller: TradeLicenseForm.streetController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: textFieldDecoration.copyWith(
                          hintText: 'রাস্তা/মহল্লা লিখুন',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  title: 'হোল্ডিং নম্বর',
                  isRequired: true,
                  controller: TradeLicenseForm.holdingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'হোল্ডিং নম্বর দিন';
                    }
                    return null;
                  },
                  decoration: textFieldDecoration.copyWith(
                    hintText: 'হোল্ডিং নম্বর লিখুন',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    title: 'পরবর্তী',
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          TradeLicenseForm.taxZone != null &&
                          TradeLicenseForm.ward != null) {
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
                )
              ],
            ),
          );
        });
  }
}
