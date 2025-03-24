import 'package:flutter/material.dart';
import 'package:gcc_portal/screens/auth/login.dart';

import '../../core/custom_height.dart';

class GoogleCredentialNavigator extends StatefulWidget {
  const GoogleCredentialNavigator({super.key});

  @override
  GeneralUserNavigationState createState() => GeneralUserNavigationState();
}

class GeneralUserNavigationState extends State<GoogleCredentialNavigator> {
  List<Widget> widgetList = [
    const GoogleCredentialDashboard(),
    const GoogleCredentialProfile(),
  ];

  int bottomNavigatonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ড্যাশবোর্ড'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/emptyProfile.jpg'),
              ),
            ),
          ],
        ),
        body: widgetList[bottomNavigatonIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey[900],
          selectedItemColor: Colors.white,
          backgroundColor: Colors.green,
          currentIndex: bottomNavigatonIndex,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ড্যাশবোর্ড',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'পোফাইল')
          ],
          onTap: (index) {
            setState(() {
              bottomNavigatonIndex = index;
            });
          },
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/cardBack.jpg'), opacity: .3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height40(),
                        height30(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 25,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  backgroundImage: Image.asset(
                                    'assets/emptyProfile.jpg',
                                    fit: BoxFit.contain,
                                  ).image,
                                ),
                              ),
                              width10(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'মোহন লাল',
                                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                                  ),
                                  height2(),
                                  const Text(
                                    '01670242311',
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        height20(),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    bottomNavigatonIndex = 0;
                                  });
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'হোম',
                                          style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w700),
                                        ),
                                        width5(),
                                        const Icon(
                                          Icons.home_outlined,
                                          color: Colors.blueGrey,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            width15(),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()), (Route<dynamic> route) => false);
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 2,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'লগআউট',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                        width5(),
                                        const Icon(
                                          Icons.exit_to_app_sharp,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        height15(),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      bottomNavigatonIndex = 1;
                    });
                  },
                  leading: const Icon(Icons.person),
                  title: const Text('প্রোফাইল'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleCredentialDashboard extends StatelessWidget {
  const GoogleCredentialDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'আপনার কোনো তথ্য খুঁজে পাওয়া যায়নি।\nস্থানীয় জনপ্রতিনিধির সাথে যোগাযোগ করা যেতে পারে।',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black.withOpacity(.7)),
          ),
        ),
      ],
    ));
  }
}

class GoogleCredentialProfile extends StatelessWidget {
  const GoogleCredentialProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            height20(),
            Card(
              elevation: 2.0,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.4),
                    ),
                    child: const Text(
                      'আবেদনকারীর ব্যক্তিগত তথ্য',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(.50),
                        2: FractionColumnWidth(.50),
                      },
                      border: TableBorder.all(color: Colors.grey),
                      children: [
                        customTableRow(title: 'দেশ', data: 'Bangladesh'),
                        customTableRow(title: 'বিভাগ', data: 'Bangladesh'),
                        customTableRow(title: 'জেলা', data: 'Dhaka'),
                        customTableRow(title: 'ওয়ার্ড', data: 'Modhupur'),
                        customTableRow(title: 'ইউনিয়ন', data: 'Tejkuni Para'),
                        customTableRow(title: 'মোবাইল', data: '01670242311'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow customTableRow({required String title, required String data}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          data, //'HelperClass().convertDateTime('checkTicketModel.programOnDate!.programDate'),
          style: const TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}
