import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_portal/screens/auth/login.dart';
import 'package:gcc_portal/screens/trade_license/manage_trade_license.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_list.dart';
import 'package:gcc_portal/utils/widgets/appbar_widget.dart';
import 'package:gcc_portal/utils/widgets/dialog_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../utils/services/dio_service.dart';
import '../utils/services/init_prefs.dart';
import '../utils/widgets/my_widgets.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _logOut() async {
    context.loaderOverlay.show();
    await SharedPrefs.clearValues();
    await storage.deleteAll();
    if (mounted) {
      context.loaderOverlay.hide();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'সেটিংস',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              FontAwesomeIcons.userLarge,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'প্রোফাইল',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'আপনার প্রোফাইল দেখুন এবং সম্পাদনা করুন',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Accordion(
                    disableScrolling: true,
                    paddingListHorizontal: 0,
                    paddingListBottom: 0,
                    scaleWhenAnimating: false,
                    openAndCloseAnimation: true,
                    headerBackgroundColorOpened:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    children: [
                      _buildAccordionSection(
                        context: context,
                        title: 'ট্রেড লাইসেন্স',
                        icon: FontAwesomeIcons.store,
                        items: [
                          MenuItem(
                            title: 'ট্রেড লাইসেন্স যোগ করুন',
                            icon: Icons.add_business,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ManageTradeLicense(isEdit: false),
                                ),
                              );
                            },
                          ),
                          MenuItem(
                            title: 'ট্রেড লাইসেন্স তালিকা',
                            icon: Icons.list_alt,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TradeLicenseList(
                                      showBackButton: true),
                                ),
                              );
                            },
                          ),
                          MenuItem(
                            title: 'নবায়ন তালিকা',
                            icon: Icons.refresh,
                            onTap: () {},
                          ),
                          MenuItem(
                            title: 'রিপ্লেসমেন্ট',
                            icon: Icons.swap_horiz,
                            onTap: () {},
                          ),
                          MenuItem(
                            title: 'সমর্পণ',
                            icon: Icons.assignment_return,
                            onTap: () {},
                          ),
                          MenuItem(
                            title: 'সংশোধন',
                            icon: Icons.edit_note,
                            onTap: () {},
                          ),
                        ],
                      ),
                      _buildAccordionSection(
                        context: context,
                        title: 'হোল্ডিং ট্যাক্স তথ্য',
                        icon: FontAwesomeIcons.buildingUser,
                        items: [
                          MenuItem(
                            title: 'হোল্ডিং ট্যাক্স তথ্য যোগ করুন',
                            icon: Icons.add_home_work,
                            onTap: () {},
                          ),
                          MenuItem(
                            title: 'হোল্ডিং ট্যাক্স তালিকা',
                            icon: Icons.format_list_bulleted,
                            onTap: () {},
                          ),
                          MenuItem(
                            title: 'ট্যাক্সের ধরণ',
                            icon: Icons.category,
                            onTap: () {},
                          ),
                          MenuItem(
                            title: 'কোয়াটার',
                            icon: Icons.calendar_today,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    onPressed: () {
                      CustomDialog.show(
                        context: context,
                        title: 'লগ আউট করুন',
                        content: 'আপনি কি নিশ্চিত যে আপনি লগ আউট করতে চান?',
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                        onConfirm: _logOut,
                      );
                    },
                    icon: const Icon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AccordionSection _buildAccordionSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<MenuItem> items,
  }) {
    return AccordionSection(
      isOpen: false,
      headerBackgroundColorOpened:
          Theme.of(context).primaryColor.withOpacity(0.1),
      headerBackgroundColor: Colors.grey.shade100,
      contentBorderColor: Colors.transparent,
      rightIcon: const Icon(Icons.arrow_drop_down),
      headerPadding: const EdgeInsets.all(10),
      header: const Text(
        'হোল্ডিং ট্যাক্স তথ্য',
      ),
      content: Column(
        children: items.map((item) => BuildMenuItem(item: item)).toList(),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class BuildMenuItem extends StatelessWidget {
  final MenuItem item;

  const BuildMenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade800,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
