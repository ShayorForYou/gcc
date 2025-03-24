import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_portal/app_config.dart';
import 'package:gcc_portal/models/trade_list_model.dart';
import 'package:gcc_portal/screens/trade_license/manage_trade_license.dart';
import 'package:gcc_portal/utils/widgets/appbar_widget.dart';
import 'package:gcc_portal/utils/widgets/button_widget.dart';
import 'package:intl/intl.dart';

import '../../utils/services/dio_service.dart';
import '../../utils/widgets/dialog_widget.dart';

class TradeLicenseList extends StatefulWidget {
  final bool showBackButton;

  const TradeLicenseList({super.key, this.showBackButton = false});

  @override
  State<TradeLicenseList> createState() => _TradeLicenseListState();
}

class _TradeLicenseListState extends State<TradeLicenseList> {
  TradeLicenseListModel? tradeLicenseListModel;

  Future<List<TradeLicenseListModel>> getTradeLicenseList() async {
    Response response = await DioService.postRequest(
      body: {},
      url: AppConfig.getTradeLicenseList,
    );

    if (response.statusCode == 200) {
      print(response.data);
      var data = response.data as List;
      List<TradeLicenseListModel> tradeLicenseList = data
          .map((license) => TradeLicenseListModel.fromJson(license))
          .toList();

      return tradeLicenseList;
    } else {
      throw Exception('Failed to load trade license list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          title: 'ট্রেড লাইসেন্স তালিকা',
          showBackButton: widget.showBackButton),
      body: FutureBuilder<List<TradeLicenseListModel>>(
        future: getTradeLicenseList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CupertinoActivityIndicator(
              radius: 20,
            ));
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'কোন তথ্য খুঁজে পাওয়া যায়নি',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidgetWithIcon(
                    title: 'পুনরায় চেষ্টা করুন',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'নেটওয়ার্ক সংযোগে সমস্যা হয়েছে, অনুগ্রহ করে আবার চেষ্টা করুন'),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonWidgetWithIcon(
                    title: 'পুনরায় চেষ্টা করুন',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }

          final licenses = snapshot.data;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dividerThickness: 0.5,
                dataTextStyle: const TextStyle(
                  fontFamily: 'Ubuntu',
                ),
                headingTextStyle: const TextStyle(
                  fontSize: 16,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.transparent),
                    bottom: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.transparent),
                    right: BorderSide(color: Colors.transparent),
                  ),
                ),
                headingRowColor:
                    const WidgetStatePropertyAll(Color(0xffF2F2F2)),
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('ক্রমিক নং',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('আবেদন নম্বর',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('আবেদনের তারিখ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('ব্যবসার ধরণ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('আবেদনের ধরণ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('স্মার্ট ট্রেড লাইসেন্স নম্বর',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('প্রতিষ্ঠানের নাম',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('মোবাইল নম্বর',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('স্ট্যাটাস',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    headingRowAlignment: MainAxisAlignment.center,
                    label: Text('অ্যাকশন',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: licenses!.map((license) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Center(
                          child:
                              Text(license.applicationId.toString() ?? '-'))),
                      DataCell(Center(
                          child:
                              Text(license.applicationSl?.toString() ?? '-'))),
                      DataCell(Center(
                          child: Text(
                        DateFormat('dd-MM-yyyy')
                            .format(license.applicatonDate!),
                      ))),
                      DataCell(Center(
                          child: Text(license
                                      .businessOrgType?.businessOrgTypeName ==
                                  null
                              ? '-'
                              : license.businessOrgType?.businessOrgTypeName ??
                                  '-'))),
                      DataCell(Center(
                          child: Text(
                              license.subService!.licenceTypeName ?? '-'))),
                      DataCell(Center(
                          child: Text(license.smartTradeLicenceNumber ?? '-'))),
                      DataCell(Center(
                          child:
                              Text(license.orgNameBangla?.toString() ?? '-'))),
                      DataCell(Center(
                          child: Text(
                              license.ownerMobileNumber?.toString() ?? '-'))),
                      DataCell(Center(
                          child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColors[
                                  int.parse(license.applicationStatus!)] ??
                              Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getApplicationStatusText(
                              int.parse(license.applicationStatus!)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ))),
                      DataCell(Center(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_red_eye,
                                  size: 18, color: Colors.blue),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DetailsDialog(
                                      context: context, license: license),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(FontAwesomeIcons.penToSquare,
                                  size: 14, color: Colors.green),
                              onPressed: () {
                                CustomDialog.show(
                                    context: context,
                                    title: 'অ্যাপ্লিকেশন আপডেট করুন',
                                    content: 'আপডেট করতে চান?',
                                    onConfirm: () {
                                      TradeLicenseForm.holdingController?.text =
                                          license.holdingId.toString();
                                      TradeLicenseForm.applicationId = license.applicationId;
                                      TradeLicenseForm.ownerImageAttachment = license.ownerImageAttachement;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               ManageTradeLicense(
                                                pageIndex: license.isActive ?? 0,
                                            isEdit: true,
                                          ),
                                        ),
                                      );
                                    },
                                    onCancel: () {
                                      Navigator.pop(context);
                                    });
                              },
                            ),
                            if (int.parse(license.applicationStatus!) != 0)
                              IconButton(
                                icon: const Icon(Icons.multiline_chart,
                                    size: 18, color: Colors.amber),
                                onPressed: () {},
                              ),
                          ],
                        ),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsDialog extends StatelessWidget {
  final BuildContext context;
  final TradeLicenseListModel license;

  const DetailsDialog(
      {super.key, required this.context, required this.license});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'লাইসেন্সের বিস্তারিত',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 24),
            BuildDetailRow(
                label: 'প্রতিষ্ঠানের নাম',
                value: license.orgNameBangla == null
                    ? '-'
                    : license.orgNameBangla.toString()),
            BuildDetailRow(
                label: 'আবেদন নং',
                value: license.applicationSl == null
                    ? '-'
                    : license.applicationSl.toString()),
            BuildDetailRow(
                label: 'লাইসেন্স নং',
                value: license.smartTradeLicenceNumber == null
                    ? '-'
                    : license.smartTradeLicenceNumber.toString()),
            BuildDetailRow(
                label: 'ব্যবসার ধরণ',
                value: license.businessOrgType?.businessOrgTypeName == null
                    ? '-'
                    : license.businessOrgType!.businessOrgTypeName.toString()),
            BuildDetailRow(
                label: 'মোবাইল নম্বর',
                value: license.ownerMobileNumber == null
                    ? '-'
                    : license.ownerMobileNumber.toString()),
            BuildDetailRow(
                label: 'আবেদনের তারিখ',
                value: license.applicatonDate == null
                    ? '-'
                    : DateFormat('dd-MM-yyyy').format(license.applicatonDate!)),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor:
                      WidgetStateProperty.all(Colors.green.withOpacity(0.1)),
                  foregroundColor: WidgetStateProperty.all(Colors.green),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('বন্ধ করুন'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const BuildDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          const Text(': '),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _getApplicationStatusText(int status) {
  switch (status) {
    case 0:
      return 'অসম্পূর্ণ আবেদন';
    case 1:
      return 'অপেক্ষমান';
    case 2:
      return 'প্রক্রিয়াধীন';
    case 3:
      return 'পেমেন্ট অনুমোদিত';
    case 4:
      return 'ব্যাংক পেমেন্ট';
    case 5:
      return 'অনলাইন পেমেন্ট';
    case 6:
      return 'রসিদ সংযুক্তি';
    case 7:
      return 'পেমেন্ট হয়েছে';
    case 8:
      return 'পেমেন্ট বাতিল';
    case 9:
      return 'সম্পূর্ণ  হয়েছে';
    default:
      return '-';
  }
}

//0 - অসম্পূর্ণ আবেদন
// 1 - অপেক্ষমান
// 2 - প্রক্রিয়াধীন
// 3 - পেমেন্ট অনুমোদিত
// 4 - ব্যাংক পেমেন্ট
// 5 - অনলাইন পেমেন্ট
// 6 - রসিদ সংযুক্তি
// 7 - পেমেন্ট হয়েছে
// 8 - পেমেন্ট বাতিল
// 9 - সম্পূর্ণ  হয়েছে

final Map<int, Color> statusColors = {
  0: const Color(0xFFFF5722),
  1: const Color(0xFFFFC107),
  2: const Color(0xFF17A2B8),
  3: const Color(0xFF6C757D),
  4: const Color(0xFF007BFF),
  5: const Color(0xFF007BFF),
  6: const Color(0xFF28A745),
  7: const Color(0xFF9C27B0),
  8: const Color(0xFFDC3545),
  9: const Color(0xFF20C997),
};
