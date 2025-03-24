import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gcc_portal/utils/widgets/datepicker_widget.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:toastification/toastification.dart';

import '../../../app_config.dart';
import '../../../utils/services/dio_service.dart';
import '../../../utils/widgets/button_widget.dart';
import '../../../utils/widgets/dialog_widget.dart';
import '../../../utils/widgets/my_widgets.dart';
import '../../../utils/widgets/textfield_widget.dart';
import '../manage_trade_license.dart';

class Attachments extends StatefulWidget {
  final PageController pageController;

  const Attachments({super.key, required this.pageController});

  @override
  State<Attachments> createState() => _AttachmentsState();
}

class _AttachmentsState extends State<Attachments> {
  ScrollController scrollController = ScrollController();

  void _pickFiles(
      {required String title, List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      // allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
      allowedExtensions: allowedExtensions,
      allowMultiple: false,
      allowCompression: true,
      compressionQuality: 50,
      lockParentWindow: true,
    );
    if (result != null) {
      switch (title) {
        case 'ownerImageAttachment':
          TradeLicenseForm.ownerImageAttachment = result;
          setState(() {});
          break;
        case 'ownerSignatureAttachment':
          TradeLicenseForm.ownerSignatureAttachment = result;
          setState(() {});
          break;
        case 'ownerNidAttachment':
          TradeLicenseForm.ownerNidAttachment = result;
          setState(() {});
          break;
        case 'holderSignatureAttachment':
          TradeLicenseForm.rentFileAttachment = result;
          setState(() {});
          break;
        case 'organizationImageAttachment':
          TradeLicenseForm.fireServiceAttachment = result;
          setState(() {});
          break;
        case 'organizationSignatureAttachment':
          TradeLicenseForm.nocAttachment = result;
          setState(() {});
          break;
      }
    }
  }

  _submitForm() async {
    try {
      context.loaderOverlay.show();
      final formData = FormData.fromMap({
        'application_id': TradeLicenseForm.applicationId,
        'owner_image_attachment': await MultipartFile.fromFile(
          TradeLicenseForm.ownerImageAttachment!.files.first.path!,
          filename: TradeLicenseForm.ownerImageAttachment!.files.first.name,
        ),
        "is_active": 5
      });
      Response response = await DioService.postRequest(
          url: AppConfig.saveTradeLicense, body: formData);

      print(response.data);
      if (mounted) {
        context.loaderOverlay.hide();
        if (response.statusCode == 200) {
          MyWidgets().showToast(
            message: 'আপনার আবেদনটি সম্পন্ন হয়েছে।',
            type: ToastificationType.error,
            icon: Icons.error,
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        debugPrint(e.toString());

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text('সংযুক্তিসমুহ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 10),
              AttachmentContainer(
                title: 'আবেদনকারীর (মালিকের) পাসপোর্ট সাইজের ছবি',
                subTitle:
                    '\nশুধুমাত্র JPG, JPEG, PNG, এবং WEBP ফাইল গ্রহণযোগ্য',
                fileName:
                    TradeLicenseForm.ownerImageAttachment?.files.first.name ??
                        '',
                onTap: () => _pickFiles(
                  title: 'ownerImageAttachment',
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
                ),
              ),
              const SizedBox(height: 20),
              AttachmentContainer(
                title: 'আবেদনকারীর (মালিকের) স্বাক্ষর',
                subTitle:
                    '\nশুধুমাত্র JPG, JPEG, PNG, এবং WEBP ফাইল গ্রহণযোগ্য',
                fileName: TradeLicenseForm
                        .ownerSignatureAttachment?.files.first.name ??
                    '',
                onTap: () => _pickFiles(
                  title: 'ownerSignatureAttachment',
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
                ),
              ),
              const SizedBox(height: 20),
              AttachmentContainer(
                title: 'জাতীয় পরিচয়পত্র/Passport এর কপি',
                subTitle: '\n শুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                fileName:
                    TradeLicenseForm.ownerNidAttachment?.files.first.name ?? '',
                onTap: () => _pickFiles(
                  title: 'ownerNidAttachment',
                  allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
                ),
              ),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: 'ভাড়ার চুক্তিপত্র',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName:
                      TradeLicenseForm.rentFileAttachment?.files.first.name ??
                          '',
                  onTap: () => _pickFiles(
                        title: 'rentFileAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'বিস্ফোরক পরিদপ্তর/ফায়ার সার্ভিস এর স্মারক নম্বর',
                controller: TradeLicenseForm.fireServiceMemoNumberController,
                decoration: textFieldDecoration.copyWith(
                  hintText: 'স্মারক নম্বর',
                ),
              ),
              const SizedBox(height: 20),
              DatepickerWidget(
                  title: 'বিস্ফোরক পরিদপ্তর/ফায়ার সার্ভিস এর তারিখ',
                  hint: TradeLicenseForm.fireServiceMemoDate == null
                      ? 'DD-MM-YYYY'
                      : DateFormat('MMM d, yyyy')
                          .format(TradeLicenseForm.fireServiceMemoDate!),
                  header: 'বিস্ফোরক পরিদপ্তর/ফায়ার সার্ভিস এর তারিখ',
                  initialDateTime:
                      TradeLicenseForm.fireServiceMemoDate ?? DateTime.now(),
                  onConfirm: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateTimeChanged: (DateTime newDate) {
                    TradeLicenseForm.fireServiceMemoDate = newDate;
                  }),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: 'বিস্ফোরক পরিদপ্তর/ফায়ার সার্ভিস এর ছাড়পত্র',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName: TradeLicenseForm
                          .fireServiceAttachment?.files.first.name ??
                      '',
                  onTap: () => _pickFiles(
                        title: 'fireServiceAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'NOC এর স্মারক নম্বর',
                controller: TradeLicenseForm.nocMemoNumberController,
                decoration: textFieldDecoration.copyWith(
                  hintText: 'স্মারক নম্বর',
                ),
              ),
              const SizedBox(height: 20),
              DatepickerWidget(
                  title: 'NOC এর তারিখ',
                  hint: TradeLicenseForm.nocMemoDate == null
                      ? 'DD-MM-YYYY'
                      : DateFormat('MMM d, yyyy')
                          .format(TradeLicenseForm.nocMemoDate!),
                  header: 'NOC এর তারিখ',
                  initialDateTime:
                      TradeLicenseForm.nocMemoDate ?? DateTime.now(),
                  onConfirm: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateTimeChanged: (DateTime newDate) {
                    TradeLicenseForm.nocMemoDate = newDate;
                  }),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: 'অনাপত্তি পত্র (NOC)',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName:
                      TradeLicenseForm.nocAttachment?.files.first.name ?? '',
                  onTap: () => _pickFiles(
                        title: 'nocAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              CustomTextField(
                title: '২৪(২) ধারার নোটিশ স্মারক নম্বর',
                controller:
                    TradeLicenseForm.twentyFourNoticeMemoNumberController,
                decoration: textFieldDecoration.copyWith(
                  hintText: '২৪(২) ধারার নোটিশ স্মারক নম্বর',
                ),
              ),
              const SizedBox(height: 20),
              DatepickerWidget(
                  title: '২৪(২) ধারার নোটিশ তারিখ',
                  hint: TradeLicenseForm.twentyFourNoticeMemoDate == null
                      ? 'DD-MM-YYYY'
                      : DateFormat('MMM d, yyyy')
                          .format(TradeLicenseForm.twentyFourNoticeMemoDate!),
                  header: '২৪(২) ধারার নোটিশ তারিখ',
                  initialDateTime: TradeLicenseForm.twentyFourNoticeMemoDate ??
                      DateTime.now(),
                  onConfirm: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateTimeChanged: (DateTime newDate) {
                    TradeLicenseForm.twentyFourNoticeMemoDate = newDate;
                  }),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: '২৪(২) ধারার নোটিশ',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName: TradeLicenseForm
                          .twentyFourNoticeAttachment?.files.first.name ??
                      '',
                  onTap: () => _pickFiles(
                        title: 'twentyFourNoticeAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'ব্যবহৃত বয়লারের ছাড়পত্রের স্মারক নম্বর',
                controller: TradeLicenseForm.boilerMemoNumberController,
                decoration: textFieldDecoration.copyWith(
                  hintText: 'ব্যবহৃত বয়লারের ছাড়পত্রের স্মারক নম্বর',
                ),
              ),
              const SizedBox(height: 20),
              DatepickerWidget(
                  title: 'ব্যবহৃত বয়লারের ছাড়পত্রের তারিখ',
                  hint: TradeLicenseForm.boilerMemoDate == null
                      ? 'DD-MM-YYYY'
                      : DateFormat('MMM d, yyyy')
                          .format(TradeLicenseForm.boilerMemoDate!),
                  header: 'ব্যবহৃত বয়লারের ছাড়পত্রের তারিখ',
                  initialDateTime:
                      TradeLicenseForm.boilerMemoDate ?? DateTime.now(),
                  onConfirm: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateTimeChanged: (DateTime newDate) {
                    TradeLicenseForm.boilerMemoDate = newDate;
                  }),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: 'ব্যবহৃত বয়লারের ছাড়পত্র (প্রযোজ্য ক্ষেত্রে)',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName: TradeLicenseForm
                          .boilerCharpottroAttachment?.files.first.name ??
                      '',
                  onTap: () => _pickFiles(
                        title: 'boilerCharpottroAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'বকেয়া করের অঙ্গীকারপত্রের স্মারক নম্বর',
                controller: TradeLicenseForm.dueTaxMemoNumberController,
                decoration: textFieldDecoration.copyWith(
                  hintText: 'বকেয়া করের অঙ্গীকারপত্রের স্মারক নম্বর',
                ),
              ),
              const SizedBox(height: 20),
              DatepickerWidget(
                  title: 'বকেয়া করের অঙ্গীকারপত্রের তারিখ',
                  hint: TradeLicenseForm.dueTaxMemoDate == null
                      ? 'DD-MM-YYYY'
                      : DateFormat('MMM d, yyyy')
                          .format(TradeLicenseForm.dueTaxMemoDate!),
                  header: 'বকেয়া করের অঙ্গীকারপত্রের তারিখ',
                  initialDateTime:
                      TradeLicenseForm.dueTaxMemoDate ?? DateTime.now(),
                  onConfirm: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateTimeChanged: (DateTime newDate) {
                    TradeLicenseForm.dueTaxMemoDate = newDate;
                  }),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: 'বকেয়া করের অঙ্গীকারপত্র',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName:
                      TradeLicenseForm.bokeyaAttachment?.files.first.name ?? '',
                  onTap: () => _pickFiles(
                        title: 'bokeyaAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              CustomTextField(
                title: 'সনওয়ারী হোল্ডিং করের স্মারক নম্বর',
                controller: TradeLicenseForm.holdingTaxBillNumberController,
                decoration: textFieldDecoration.copyWith(
                  hintText: 'সনওয়ারী হোল্ডিং করের স্মারক নম্বর',
                ),
              ),
              const SizedBox(height: 10),
              DatepickerWidget(
                  title: 'সনওয়ারী হোল্ডিং করের তারিখ',
                  hint: TradeLicenseForm.holdingTaxBillDate == null
                      ? 'DD-MM-YYYY'
                      : DateFormat('MMM d, yyyy')
                          .format(TradeLicenseForm.holdingTaxBillDate!),
                  header: 'সনওয়ারী হোল্ডিং করের তারিখ',
                  initialDateTime:
                      TradeLicenseForm.holdingTaxBillDate ?? DateTime.now(),
                  onConfirm: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onDateTimeChanged: (DateTime newDate) {
                    TradeLicenseForm.holdingTaxBillDate = newDate;
                  }),
              const SizedBox(height: 20),
              AttachmentContainer(
                  title: 'সনওয়ারী হোল্ডিং করের বিল',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য',
                  fileName:
                      TradeLicenseForm.holdingAttachment?.files.first.name ??
                          '',
                  onTap: () => _pickFiles(
                        title: 'holdingAttachment',
                        allowedExtensions: [
                          'pdf',
                          'jpg',
                          'jpeg',
                          'png',
                          'webp'
                        ],
                      )),
              const SizedBox(height: 20),
              const AttachmentContainer(
                  title: 'লে-আউট প্ল্যানের অনুমোদন কপি',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য'),
              const SizedBox(height: 20),
              const AttachmentContainer(
                  title: 'কেমিকেল ব্যবহার সম্পর্কে সু-স্পষ্ট মতামত',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য'),
              const SizedBox(height: 20),
              const AttachmentContainer(
                  title: 'হোল্ডিং ট্যাক্স',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য'),
              const SizedBox(height: 20),
              const AttachmentContainer(
                  title: 'নির্ধারিত আবেদন পত্র',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য'),
              const SizedBox(height: 20),
              const AttachmentContainer(
                  title: 'মূল ট্রেড লাইসেন্স',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য'),
              const SizedBox(height: 20),
              const AttachmentContainer(
                  title: 'স্থাপনা পরিমাপের প্রত্যয়ন',
                  subTitle: '\nশুধুমাত্র pdf এবং image ফাইল গ্রহণযোগ্য'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    title: 'পূর্বে',
                    buttonColor: Colors.grey,
                    onPressed: () {
                      widget.pageController.jumpToPage(4);
                    },
                  ),
                  const SizedBox(width: 10),
                  ButtonWidget(
                    title: 'জমা দিন',
                    onPressed: () {
                      if (TradeLicenseForm.ownerImageAttachment == null) {
                        MyWidgets().showToast(
                          type: ToastificationType.error,
                          message: 'আবেদনকারীর ছবি দিন',
                          icon: Icons.error,
                        );
                        scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      } else {
                        CustomDialog.show(
                          context: context,
                          title: 'আপনি কি জমা দিতে চান?',
                          onConfirm: () {
                            _submitForm();
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          content: 'আপনি কি জমা দিতে চান?',
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
        itemCount: 1,
      ),
    );
  }
}

class AttachmentContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function()? onTap;
  final String? fileName;

  const AttachmentContainer(
      {super.key,
      required this.title,
      required this.subTitle,
      this.fileName,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            children: [
              TextSpan(
                text: subTitle,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'Nikosh',
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        DottedBorder(
          color: Theme.of(context).colorScheme.primary,
          stackFit: StackFit.passthrough,
          strokeWidth: 2,
          radius: const Radius.circular(10),
          borderType: BorderType.RRect,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: onTap,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'আপনার সংযুক্তি যোগ করুন',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    if (fileName != null && fileName!.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        fileName!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
