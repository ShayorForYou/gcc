import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_portal/models/otp_model.dart';
import 'package:gcc_portal/screens/home.dart';
import 'package:gcc_portal/utils/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../app_config.dart';
import '../../utils/services/dio_service.dart';
import '../../utils/services/init_prefs.dart';
import '../../utils/widgets/my_widgets.dart';

class Otp extends StatefulWidget {
  final double otpTimer;
  final String mobileNumber;
  final int userId;

  const Otp(
      {super.key,
      required this.mobileNumber,
      required this.otpTimer,
      required this.userId});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _otpController = TextEditingController();
  OtpModel? otpModel;

  late double _countDownTimer;
  Timer? _timer;
  late final PinTheme _focusedPinTheme;
  late final PinTheme _submittedPinTheme;
  late final PinTheme _errorPinTheme;
  final _defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  @override
  void initState() {
    super.initState();

    initializeTimer();
    _countDownTimer = widget.otpTimer;
    _focusedPinTheme = _defaultPinTheme.copyWith(
      decoration: _defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.green),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
    );

    _submittedPinTheme = _defaultPinTheme.copyWith(
      decoration: _defaultPinTheme.decoration!.copyWith(
        color: Colors.green.withOpacity(0.1),
        border: Border.all(color: Colors.green),
      ),
    );

    _errorPinTheme = _defaultPinTheme.copyWith(
      decoration: _defaultPinTheme.decoration!.copyWith(
        color: Colors.red.shade50,
        border: Border.all(color: Colors.red),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void initializeTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countDownTimer == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _countDownTimer--;
          });
        }
      },
    );
  }

  String _formatTimer() {
    if (_countDownTimer <= 0) return '';
    final minutes = _countDownTimer ~/ 60;
    final seconds = _countDownTimer.toInt() % 60;
    return DateFormat('mm:ss').format(DateTime(0, 0, 0, 0, minutes, seconds));
  }

  void resendOtp() async {
    try {
      context.loaderOverlay.show();
      Response response = await DioService.postRequest(
          url: AppConfig.resendOtp,
          addInterceptors: false,
          body: {
            'user_id': widget.userId,
          });
      if (response.statusCode == 200) {
        if (mounted) {
          context.loaderOverlay.hide();
          MyWidgets().showToast(
            message: response.data['message'],
            type: ToastificationType.success,
            icon: Icons.check,
          );
          setState(() {
            _countDownTimer = DateTime.parse(
                    response.data['response']['generated_code_date_time'])
                .difference(DateTime.now())
                .inSeconds
                .toDouble();
          });
          initializeTimer();
        }
      } else {
        if (mounted) {
          context.loaderOverlay.hide();
          MyWidgets().showToast(
            message: response.data['message'],
            type: ToastificationType.error,
            icon: Icons.error,
          );
        }
      }
    } catch (e) {
      _catchError(e);
    }
  }

  _catchError(error) {
    print("Error: $error");

    if (mounted) {
      context.loaderOverlay.hide();
      if (error is DioException) {
      } else {
        MyWidgets().showToast(
          message: 'দুঃখিত, আবেদনটি সম্পন্ন হয়নি, দয়া করে আবার চেষ্টা করুন',
          type: ToastificationType.error,
          icon: Icons.error,
        );
      }
    }
  }

  void verifyOtp(String otp) async {
    try {
      context.loaderOverlay.show();
      Response response = await DioService.postRequest(
          url: AppConfig.verifyOtp,
          addInterceptors: false,
          body: {
            'generated_code': otp,
            'user_id': widget.userId,
          });
      if (response.statusCode == 200) {
        context.loaderOverlay.hide();
        SharedPrefs.setBooleanValue('isAuthenticated', true);
        otpModel = OtpModel.fromJson(response.data);

        await storage.write(key: 'token', value: otpModel!.accessToken);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        context.loaderOverlay.hide();
        MyWidgets().showToast(
          message: response.data['message'],
          type: ToastificationType.error,
          icon: Icons.error,
        );
      }
    } catch (e) {
      _catchError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'ওটিপি যাচাইকরণ'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const VectorGraphic(
                  loader: AssetBytesLoader(AppAssets.passwordSvg),
                  width: 160,
                  height: 160,
                ),
                const SizedBox(height: 20),
                const Text(
                  'আপনার মোবাইল নম্বরে পাঠানো ওটিপি লিখুন',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.mobileNumber.length > 10
                      ? '${widget.mobileNumber.substring(0, 4)}******${widget.mobileNumber.substring(9)}'
                      : widget.mobileNumber,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Pinput(
                      autofocus: true,
                      isCursorAnimationEnabled: true,
                      pinAnimationType: PinAnimationType.fade,
                      defaultPinTheme: _defaultPinTheme,
                      focusedPinTheme: _focusedPinTheme,
                      submittedPinTheme: _submittedPinTheme,
                      errorPinTheme: _errorPinTheme,
                      closeKeyboardWhenCompleted: true,
                      controller: _otpController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      onCompleted: (value) {
                        verifyOtp(value);
                      },
                      animationCurve: Curves.easeInExpo,
                      length: 6,
                    )),
                const SizedBox(height: 20),
                const Text(
                  'ওটিপি পাননি?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                Text(
                  'পুনরায় ওটিপি পাঠানোর সময়',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                (_countDownTimer > 0)
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _formatTimer(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            minimumSize: const Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            splashFactory: InkRipple.splashFactory,
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            enableFeedback: true,
                          ),
                          onPressed: () {
                            resendOtp();
                          },
                          child: const Text(
                            'পুনরায় পাঠান',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   mainAxisSize: MainAxisSize.max,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     _countDownTimer > 0
                //         ? Row(
                //             children: [
                //               Divider(
                //                 color: Theme.of(context).colorScheme.primary,
                //                 thickness: 2,
                //               ),
                //               const SizedBox(width: 10),
                //               const Text(
                //                 'ওটিপি পুনরায় পাঠান',
                //                 style: TextStyle(fontSize: 14),
                //               ),
                //               const SizedBox(width: 6),
                //               Text(
                //                 _countDownTimer.toInt() > 60
                //                     ? DateFormat('mm:ss').format(DateTime(
                //                         0,
                //                         0,
                //                         0,
                //                         0,
                //                         _countDownTimer ~/ 60,
                //                         _countDownTimer.toInt() % 60))
                //                     : DateFormat('mm:ss').format(DateTime(0,
                //                         0, 0, 0, 0, _countDownTimer.toInt())),
                //                 style: const TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               const SizedBox(width: 6),
                //               const Text(
                //                 'সেকেন্ড পর',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                 ),
                //               ),
                //               Divider(
                //                 color: Theme.of(context).colorScheme.primary,
                //                 thickness: 2,
                //               )
                //             ],
                //           )
                //         : SizedBox(
                //             width: MediaQuery.of(context).size.width * 0.5,
                //             child: ElevatedButton(
                //               style: ElevatedButton.styleFrom(
                //                 elevation: 5,
                //                 backgroundColor:
                //                     Theme.of(context).colorScheme.primary,
                //                 minimumSize: const Size(100, 50),
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 splashFactory: InkRipple.splashFactory,
                //                 visualDensity:
                //                     VisualDensity.adaptivePlatformDensity,
                //                 enableFeedback: true,
                //               ),
                //               onPressed: () {
                //                 resendOtp();
                //               },
                //               child: const Text(
                //                 'পুনরায় পাঠান',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ),
                //           ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
