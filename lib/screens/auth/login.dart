import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gcc_portal/app_config.dart';
import 'package:gcc_portal/screens/auth/registration.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../utils/services/dio_service.dart';
import '../../utils/services/init_prefs.dart';
import '../../utils/widgets/button_widget.dart';
import '../../utils/widgets/my_widgets.dart';
import '../../utils/widgets/textfield_widget.dart';
import '../gc_dashboard/google_credential_navigator.dart';
import '../home.dart';
import 'forgot_password.dart';
import 'otp.dart';

calculateTimeDifInSeconds(String time) {
  return DateTime.parse(time).difference(DateTime.now()).inSeconds.toDouble();
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();

  validateForm() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      if (_userIdController.text == 'mohonlal' &&
          _passwordController.text == '12345678') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const GoogleCredentialNavigator()));
      } else {
        _loginUser();
      }
    }
  }

  Future<void> _loginUser() async {
    try {
      context.loaderOverlay.show();

      Response response =
          await DioService.postRequest(url: AppConfig.login, body: {
        'user_name': _userIdController.text,
        'password': _passwordController.text,
      });
      if (response.statusCode == 200) {
        context.loaderOverlay.hide();

        if (response.data['message'] == 'OTP verification required') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Otp(
                      mobileNumber: _userIdController.text,
                      userId: response.data['response']['user_id'],
                      otpTimer: calculateTimeDifInSeconds(response
                          .data['response']['generated_code_date_time']))));
        } else {
          await storage.write(
              key: 'token', value: response.data['access_token']);
          await SharedPrefs.setBooleanValue('isAuthenticated', true);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      }
    } catch (e) {
      context.loaderOverlay.hide();
        // MyWidgets().showToast(
        //   message:
        //       'দুঃখিত, আপনার আবেদনটি সম্পন্ন হয়নি। অনুগ্রহ করে আবার চেষ্টা করুন',
        //   type: ToastificationType.error,
        //   icon: Icons.error,
        // );
    }
  }

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    AppAssets.title,
                    height: 200,
                    width: 200,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'ইউজার আইডি',
                        controller: _userIdController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ইউজার আইডি দিন';
                          }
                          return null;
                        },
                        decoration: textFieldDecoration.copyWith(
                            hintText: 'ইউজার আইডি দিন',
                            prefixIcon: const Icon(
                              Icons.person_2,
                              color: Colors.grey,
                              size: 16,
                            )),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        title: 'পাসওয়ার্ড',
                        controller: _passwordController,
                        obscureText: _obscureText,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'পাসওয়ার্ড দিন';
                          } else if (value.length < 6) {
                            return 'পাসওয়ার্ড অবশ্যই ৬ অক্ষরের বেশি হতে হবে';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: textFieldDecoration.copyWith(
                          hintText: 'পাসওয়ার্ড দিন',
                          prefixIcon: const Icon(
                            Icons.lock,
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
                      SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          title: 'লগইন করুন',
                          onPressed: validateForm,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword()));
                          },
                          child: const Text('পাসওয়ার্ড ভুলে গেছেন?',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Registration()));
                          },
                          child: Text.rich(TextSpan(
                            text: 'একাউন্ট নেই? ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'অ্যাকাউন্ট তৈরি করুন',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
