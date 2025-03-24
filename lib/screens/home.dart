import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gcc_portal/screens/dashboard.dart';
import 'package:gcc_portal/screens/settings.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../utils/widgets/dialog_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List pages = [
    const Dashboard(),
    const TradeLicenseList(),
    const Settings(),
  ];

  bool _checkIndex() {
    if (_selectedIndex == 0) {
      return true;
    } else {
      setState(() {
        _selectedIndex = 0;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (result, _) async {
        if (_selectedIndex == 0) {
          CustomDialog.show(
            context: context,
            title: 'এপ্লিকেশন বন্ধ করুন',
            content: 'আপনি কি নিশ্চিত যে আপনি এপ্লিকেশন থেকে বের হতে চান?',
            onCancel: () {
              Navigator.of(context).pop();
            },
            onConfirm: () {
              SystemNavigator.pop();
            },
          );
        } else {
          _checkIndex();
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -1),
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SalomonBottomBar(
              items: [
                SalomonBottomBarItem(
                  activeIcon: const Icon(FontAwesomeIcons.house, size: 18),
                  icon: const Icon(FontAwesomeIcons.house, size: 16),
                  title:
                      const Text('ড্যাশবোর্ড', style: TextStyle(fontSize: 12)),
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                SalomonBottomBarItem(
                  activeIcon: const Icon(FontAwesomeIcons.info, size: 18),
                  icon: const Icon(FontAwesomeIcons.info, size: 16),
                  title: const Text('ট্রেড লাইসেন্স তালিকা',
                      style: TextStyle(fontSize: 12)),
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
                SalomonBottomBarItem(
                  activeIcon: const Icon(FontAwesomeIcons.gear, size: 18),
                  icon: const Icon(FontAwesomeIcons.gear, size: 16),
                  title: const Text('সেটিংস'),
                  selectedColor: Theme.of(context).colorScheme.primary,
                ),
              ],
              itemPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: pages[_selectedIndex],
        ),
      ),
    );
  }
}
