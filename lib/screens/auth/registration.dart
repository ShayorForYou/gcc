import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_portal/app_config.dart';
import 'package:gcc_portal/screens/auth/otp.dart';
import 'package:gcc_portal/utils/widgets/appbar_widget.dart';
import 'package:gcc_portal/utils/widgets/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../utils/services/dio_service.dart';
import '../../utils/widgets/datepicker_widget.dart';
import '../../utils/widgets/dropdown_widget.dart';
import '../../utils/widgets/my_widgets.dart';
import '../../utils/widgets/textfield_widget.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _usernameControllerBangla =
      TextEditingController();
  final TextEditingController _usernameControllerEnglish =
      TextEditingController();
  final TextEditingController _userDesignationBangla = TextEditingController();
  final TextEditingController _userDesignationEnglish = TextEditingController();
  final TextEditingController _userNid = TextEditingController();
  final TextEditingController _userMobileNumber = TextEditingController();
  final TextEditingController _userMobileNumberConfirm =
      TextEditingController();
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();
  final TextEditingController _userConfirmPassword = TextEditingController();
  DateTime? _selectedDate;
  bool _obscureText = true;

  final List<DropdownMenuItem> _dropdownItems = [];
  int? _dropDownValue;
  final _formKey = GlobalKey<FormState>();

  validateForm() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate() && (_dropDownValue != null)) {
      await registerUser();
    } else {
      MyWidgets().showToast(
        icon: Icons.error,
        message: 'সঠিক তথ্য দিন',
        type: ToastificationType.error,
      );
    }
  }

  Future<void> registerUser() async {
    try {
      context.loaderOverlay.show();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate =
          _selectedDate != null ? formatter.format(_selectedDate!) : '';
      Map<String, dynamic> requestBody = {
        'organization_id': _dropDownValue,
        'user_name': _userMobileNumber.text,
        'full_name_english': _usernameControllerEnglish.text,
        'cell_number': _userMobileNumber.text,
        'password': _userPassword.text,
        'password_confirmation': _userConfirmPassword.text,
        'nid_number': _userNid.text,
        'date_of_birth': formattedDate,
      };
      Response response = await DioService.postRequest(
        url: AppConfig.register,
        body: requestBody,
      );
      if (mounted) {
        context.loaderOverlay.hide();
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp(
                        mobileNumber: _userMobileNumber.text,
                        userId: response.data['response']['user_id'],
                        otpTimer: calculateTimeDifInSeconds(response
                            .data['response']['generated_code_date_time']),
                      )));
        }
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

  Future<void> _getDropDownItems() async {
    try {
      context.loaderOverlay.show();
      Response response = await DioService.postRequest(
          body: {}, url: AppConfig.getOrganization);
      if (mounted) {
        context.loaderOverlay.hide();
        if (response.statusCode == 200) {
          for (var item in response.data['response']) {
            _dropdownItems.add(DropdownMenuItem(
              value: item['organization_id'],
              child: Text(item['org_name_bangla']),
            ));
          }
          setState(() {});
        }
      }
    } catch (e) {
      if (mounted) {
        context.loaderOverlay.hide();
        MyWidgets().showToast(
          icon: Icons.error,
          message:
              'দুঃখিত, ইন্টারনেট সংযোগে ত্রুটি হয়েছে, অনুগ্রহ করে আবার চেষ্টা করুন',
          type: ToastificationType.error,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getDropDownItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'রেজিস্ট্রেশন',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomDropdown(
                          title: 'প্রতিষ্ঠান নির্বাচন করুন',
                          isRequired: true,
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: Text('প্রতিষ্ঠান নির্বাচন করুন'),
                            ),
                            ..._dropdownItems
                          ],
                          value: _dropDownValue,
                          onChanged: (value) {
                            setState(() {
                              _dropDownValue = value as int?;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      DatepickerWidget(
                          title: 'জন্ম তারিখ',
                          hint: _selectedDate == null
                              ? 'জন্ম তারিখ'
                              : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                          header: 'জন্ম তারিখ নির্বাচন করুন',
                          initialDateTime: _selectedDate ??
                              DateTime.now()
                                  .subtract(const Duration(days: 18 * 365)),
                          onDateTimeChanged: (DateTime newDate) {
                              print(newDate);
                              _selectedDate = newDate;
                          },
                          minimumDate: DateTime(1920),
                          maximumDate: DateTime.now()
                              .subtract(const Duration(days: 18 * 365)),
                          mode: CupertinoDatePickerMode.date,
                          onConfirm: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                          onCancel: () {
                            setState(() {
                              _selectedDate = null;
                            });
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('আবেদনকারীর তথ্য',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'আবেদনকারীর নাম (ইংরেজীতে)',
                    isRequired: true,
                    controller: _usernameControllerEnglish,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'আবেদনকারীর নাম লিখুন (ইংরেজীতে)';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'আবেদনকারীর নাম (ইংরেজীতে)',
                      prefixIcon: const Icon(
                        Icons.person_2_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'আবেদনকারীর জাতীয় পরিচয় পত্র নম্বর লিখুন',
                    controller: _userNid,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(17),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'জাতীয় পরিচয় পত্র নম্বর',
                      prefixIcon: const Icon(
                        Icons.credit_card_sharp,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'আবেদনকারীর মোবাইল নম্বর লিখুন',
                    isRequired: true,
                    controller: _userMobileNumber,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'মোবাইল নম্বর দিন';
                      } else if (!RegExp(r'^01[3-9]\d{8}$').hasMatch(value)) {
                        return 'সঠিক মোবাইল নম্বর দিন';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: '01xxxxxxxxx',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.mobileScreenButton,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'মোবাইল নম্বর নিশ্চিত করুন',
                    isRequired: true,
                    controller: _userMobileNumberConfirm,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'মোবাইল নম্বর নিশ্চিত করুন';
                      } else if (value != _userMobileNumber.text) {
                        return 'মোবাইল নম্বর মিলেনি';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'মোবাইল নম্বর নিশ্চিত করুন',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'ইউজার আইডি',
                    controller: _userMobileNumberConfirm,
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'ইউজার আইডি',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.user,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'নতুন পাসওয়ার্ড লিখুন',
                    isRequired: true,
                    controller: _userPassword,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'পাসওয়ার্ড দিন';
                      } else if (value.length < 6) {
                        return 'পাসওয়ার্ড অবশ্যই ৬ অক্ষরের বেশি হতে হবে';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
                          .hasMatch(value)) {
                        return 'পাসওয়ার্ড অবশ্যই একটি ডিজিট, একটি বড় হাতের অক্ষর, একটি ছোট হাতের অক্ষর এবং একটি বিশেষ চিহ্ন থাকতে হবে';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                    maxLines: 1,
                    decoration: textFieldDecoration.copyWith(
                      errorMaxLines: 2,
                      hintText: 'পাসওয়ার্ড দিন',
                      prefixIcon: const Icon(
                        Icons.password_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    title: 'নতুন পাসওয়ার্ড পুনরায় লিখুন',
                    isRequired: true,
                    controller: _userConfirmPassword,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'পাসওয়ার্ড নিশ্চিত করুন';
                      } else if (value != _userPassword.text) {
                        return 'পাসওয়ার্ড মিলেনি';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: textFieldDecoration.copyWith(
                      hintText: 'পাসওয়ার্ড নিশ্চিত করুন',
                      prefixIcon: const Icon(
                        Icons.password_rounded,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                        title: 'রেজিস্ট্রেশন করুন',
                        onPressed: () {
                          validateForm();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameControllerBangla.dispose();
    _usernameControllerEnglish.dispose();
    _userDesignationBangla.dispose();
    _userDesignationEnglish.dispose();
    _userNid.dispose();
    _userMobileNumber.dispose();
    _userMobileNumberConfirm.dispose();
    _userEmail.dispose();
    _userPassword.dispose();
    _userConfirmPassword.dispose();
    super.dispose();
  }
}
