import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_portal/app_config.dart';
import 'package:gcc_portal/models/dashboard_data_model.dart';
import 'package:gcc_portal/screens/trade_license/manage_trade_license.dart';
import 'package:gcc_portal/utils/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toastification/toastification.dart';

import '../utils/services/dio_service.dart';
import '../utils/widgets/button_widget.dart';
import '../utils/widgets/charts_widget.dart';
import '../utils/widgets/dropdown_widget.dart';
import '../utils/widgets/my_widgets.dart';
import '../utils/widgets/shimmer_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<ChartData> pieChartData;
  late List<ChartData> data;
  late TooltipBehavior _tooltip;
  final List<String> _chips = [
    // 'হোল্ডিং ট্যাক্স',
    'ট্রেড লাইসেন্স',
    'মোটর বিহীন যানবাহনের লাইসেন্স',
  ];
  final List _selectedChip = [0, 1, 2];
  DashboardDataModel? dashboardDataModel;
  double _totalTaxAmount = 0;
  double _totalTradeLicense = 0;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
  }

  Future<DashboardDataModel> _loadDashboardData() async {
    try {
      final response = await DioService.postRequest(
        body: {},
        url: AppConfig.getDashboardData,
      );

      dashboardDataModel = DashboardDataModel.fromJson(response.data);
      _totalTaxAmount = dashboardDataModel!.data.taxPichart
          .fold(0, (sum, item) => sum + (item["tax_amount"] as num));
      _totalTradeLicense = dashboardDataModel!.data.tradePichart
          .fold(0, (sum, item) => sum + (item["total_trade_license"] as num));

      return dashboardDataModel!;
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 404) {
          MyWidgets().showToast(
              message: 'No implementations found',
              icon: Icons.cancel_rounded,
              type: ToastificationType.error);
        }
      }
      print('Error fetching dashboard data: $e');
      throw Exception('Failed to load dashboard data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'ড্যাশবোর্ড'),
      body: FutureBuilder(
          future: _loadDashboardData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const BuildShimmer();
            }
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data == null) {
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
                    )
                  ],
                ),
              );
            }

            return RefreshIndicator(
              backgroundColor: Theme.of(context).colorScheme.primary,
              color: Colors.white,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              displacement: 6,
              edgeOffset: 2,
              onRefresh: () async {
                await Future<void>.delayed(const Duration(seconds: 2));
                setState(() {});
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: Platform.isIOS ? 40 : 20,
                        top: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _chips.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final isSelected = _selectedChip.contains(index);
                              return ActionChip(
                                label: Text(
                                  _chips[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                avatar: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : null,
                                backgroundColor: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade50,
                                elevation: 2,
                                shadowColor: Colors.grey.shade50,
                                side: BorderSide.none,
                                onPressed: () {
                                  setState(() {
                                    if (_selectedChip.contains(index)) {
                                      _selectedChip.remove(index);
                                    } else {
                                      _selectedChip.add(index);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: CustomDropdown(
                                  items: dashboardDataModel!
                                      .data.financialYearAsc
                                      .map<DropdownMenuItem<int>>((e) {
                                    return DropdownMenuItem<int>(
                                      value: e.financialYearId,
                                      child: Text(e.financialYear),
                                    );
                                  }).toList(),
                                  value: dashboardDataModel!
                                      .data.financialYearAsc[0].financialYearId,
                                  onChanged: (value) {
                                    setState(() {
                                      print("value $value");
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: CustomDropdown(
                                  items: dashboardDataModel!
                                      .data.financialYearDesc
                                      .map<DropdownMenuItem<int>>((e) {
                                    return DropdownMenuItem<int>(
                                      value: e.financialYearId,
                                      child: Text(e.financialYear),
                                    );
                                  }).toList(),
                                  value: dashboardDataModel!.data
                                      .financialYearDesc[0].financialYearId,
                                  onChanged: (value) {
                                    setState(() {
                                      // _dropDownValue = value as int?;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColor.withOpacity(0.8),
                              ],
                            ),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Theme.of(context)
                            //         .primaryColor
                            //         .withOpacity(0.3),
                            //     spreadRadius: 1,
                            //     blurRadius: 8,
                            //     offset: const Offset(0, 4),
                            //   ),
                            // ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ManageTradeLicense(isEdit: false),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -20,
                                    top: -20,
                                    child: Icon(
                                      FontAwesomeIcons.fileCirclePlus,
                                      size: 100,
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  // Content
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 25,
                                      horizontal: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                FontAwesomeIcons.plus,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Text(
                                              'ট্রেড লাইসেন্স আবেদন করুন',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.95),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          FontAwesomeIcons.chevronRight,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 1.35,
                          children: [
                            BuildStatsCard(
                              title: 'মোট হোল্ডিং সংখ্যা',
                              value: dashboardDataModel!.data.totalHolding
                                  .toString(),
                              icon: FontAwesomeIcons.house,
                              color: Colors.blue,
                            ),
                            BuildStatsCard(
                              title: 'মোট ট্যাক্স এসেসমেন্ট',
                              value: NumberFormat.currency(
                                      customPattern: '#,##,###.## Tk',
                                      decimalDigits: 0)
                                  .format(dashboardDataModel!
                                      .data.totalTaxAssesment),
                              icon: Icons.multiline_chart,
                              color: Colors.green,
                            ),
                            BuildStatsCard(
                              title: 'মোট আদায়কৃত হোল্ডিং ট্যাক্স',
                              value: NumberFormat.currency(
                                      customPattern: '#,##,###.## Tk',
                                      decimalDigits: 0)
                                  .format(
                                      dashboardDataModel!.data.totalTaxAmount),
                              icon: Icons.insert_chart_rounded,
                              color: Colors.orange,
                            ),
                            BuildStatsCard(
                              title: 'মোট নিষ্পত্তিকৃত ট্রেড লাইসেন্স সংখ্যা',
                              value: dashboardDataModel!
                                  .data.completeTradeLicense
                                  .toString(),
                              icon: FontAwesomeIcons.circleCheck,
                              color: Colors.purple,
                            ),
                            BuildStatsCard(
                              title: 'নতুন ট্রেড লাইসেন্স সংখ্যা',
                              value: dashboardDataModel!.data.newTradeLicense
                                  .toString(),
                              icon: Icons.new_releases,
                              color: Colors.teal,
                            ),
                            BuildStatsCard(
                              title: 'ট্রেড লাইসেন্স আবেদন পক্রিয়াধীন',
                              value: dashboardDataModel!
                                  .data.processingTradeLicense
                                  .toString(),
                              icon: FontAwesomeIcons.hourglassHalf,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        if (dashboardDataModel!
                            .data.taxBarchart.labels.isNotEmpty)
                          BarChartWidget(
                            color: Colors.redAccent,
                            title:
                                'মোট ট্যাক্স বকেয়া (${(dashboardDataModel!.data.totalTaxAssesment - dashboardDataModel!.data.totalTaxAmount).toStringAsFixed(2)} Tk)',
                            labels: List<String>.from(
                                dashboardDataModel!.data.taxBarchart.labels),
                            datasets:
                                dashboardDataModel!.data.taxBarchart.datasets,
                            tooltip: _tooltip, // Tooltip behavior
                          ),
                        if (dashboardDataModel!
                            .data.tradeBarchart.datasets.isNotEmpty)
                          BarChartWidget(
                            color: Theme.of(context).colorScheme.primary,
                            title:
                                'মোট ট্রেড লাইসেন্স সংখ্যা (${(dashboardDataModel!.data.totalTradeLicense)})',
                            labels: List<String>.from(
                                dashboardDataModel!.data.tradeBarchart.labels),
                            datasets:
                                dashboardDataModel!.data.tradeBarchart.datasets,
                            tooltip: _tooltip,
                          ),
                        if (dashboardDataModel?.data.tradePichart.isNotEmpty ??
                            false)
                          DoughnutChartWidget(
                            title: 'জোন ভিত্তিক ট্রেড লাইসেন্স',
                            color: Theme.of(context).colorScheme.primary,
                            total: _totalTradeLicense.toString(),
                            isTrade: true,
                            dataSource: dashboardDataModel?.data.tradePichart,
                          ),
                        if (dashboardDataModel?.data.taxPichart.isNotEmpty ??
                            false)
                          DoughnutChartWidget(
                            title: 'জোন ভিত্তিক ট্যাক্স',
                            color: Theme.of(context).colorScheme.primary,
                            total: _totalTaxAmount.toString() ?? '',
                            isTrade: false,
                            dataSource: dashboardDataModel!.data.taxPichart,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class BuildStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Function()? onTap;

  const BuildStatsCard(
      {required this.title,
      required this.value,
      required this.icon,
      required this.color,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
