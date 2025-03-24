import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_steps/applicant_address.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_steps/applicant_info.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_steps/attachments.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_steps/business_info.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_steps/holding_info.dart';
import 'package:gcc_portal/screens/trade_license/trade_license_steps/organization_info.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/widgets/appbar_widget.dart';
import '../../utils/widgets/dialog_widget.dart';
import '../home.dart';

class ManageTradeLicense extends StatefulWidget {
  final bool isEdit;
  final int pageIndex;

  const ManageTradeLicense(
      {super.key, required this.isEdit, this.pageIndex = 0});

  @override
  State<ManageTradeLicense> createState() => _ManageTradeLicenseState();
}

class _ManageTradeLicenseState extends State<ManageTradeLicense> {
  final PageController _pageController = PageController(viewportFraction: 1);

  void _showExitDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      title: 'আবেদন প্রক্রিয়া বন্ধ করুন',
      content:
      'আপনি কি নিশ্চিত যে আপনি আপনার আবেদন প্রক্রিয়া থেকে বের হয়ে যেতে চান',
      onCancel: () {
        Navigator.pop(context);
      },
      onConfirm: () {
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            )
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(widget.pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (result, _) async {
        _showExitDialog(context);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'ট্রেড লাইসেন্স',
          showBackButton: true,
          onBackButtonPressed: () {
            _showExitDialog(context);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.isEdit
                    ? 'ট্রেড লাইসেন্স সম্পাদনা'
                    : 'ট্রেড লাইসেন্স আবেদন',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 6,
                  effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 16,
                      spacing: 12,
                      activeDotColor: Theme
                          .of(context)
                          .colorScheme
                          .primary),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    HoldingInfo(pageController: _pageController),
                    ApplicantInfo(pageController: _pageController),
                    ApplicantAddress(pageController: _pageController),
                    OrganizationInfo(pageController: _pageController),
                    BusinessInfo(pageController: _pageController),
                    Attachments(pageController: _pageController),
                  ],
                ),
              ),
              // }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    reset();
    super.dispose();
  }
}

reset() {
  /// Clear lists
  TradeLicenseForm.taxZoneList = [];
  TradeLicenseForm.wardList = [];
  TradeLicenseForm.mouzaList = [];
  TradeLicenseForm.businessOrgTypeList = [];
  TradeLicenseForm.businessTypeList = [];
  TradeLicenseForm.businessSubTypeList = [];
  TradeLicenseForm.businessNatureList = [];

  /// Reset selection values
  TradeLicenseForm.taxZone = null;
  TradeLicenseForm.ward = null;
  TradeLicenseForm.mouza = null;
  TradeLicenseForm.businessOrgType = null;
  TradeLicenseForm.businessType = null;
  TradeLicenseForm.businessSubType = null;
  TradeLicenseForm.businessNature = null;
  TradeLicenseForm.businessPlaceType = null;
  TradeLicenseForm.businessWorkType = null;
  TradeLicenseForm.isExplosive = 0;
  TradeLicenseForm.isFactory = 0;

  /// Reset dates
  TradeLicenseForm.businessStartDate = null;
  TradeLicenseForm.businessRegistrationDate = null;
  TradeLicenseForm.applicantDob = null;

  /// Dispose and reset holding info controllers
  TradeLicenseForm.blockController?.dispose();
  TradeLicenseForm.blockController = TextEditingController();

  TradeLicenseForm.streetController?.dispose();
  TradeLicenseForm.streetController = TextEditingController();

  TradeLicenseForm.holdingController?.dispose();
  TradeLicenseForm.holdingController = TextEditingController();

  TradeLicenseForm.applicantNameBanglaController?.dispose();
  TradeLicenseForm.applicantNameBanglaController = TextEditingController();

  TradeLicenseForm.applicantNameEnglishController?.dispose();
  TradeLicenseForm.applicantNameEnglishController = TextEditingController();

  TradeLicenseForm.applicantNidController?.dispose();
  TradeLicenseForm.applicantNidController = TextEditingController();

  TradeLicenseForm.applicantMobileController?.dispose();
  TradeLicenseForm.applicantMobileController = TextEditingController();

  TradeLicenseForm.applicantPhoneController?.dispose();
  TradeLicenseForm.applicantPhoneController = TextEditingController();

  TradeLicenseForm.applicantEmailController?.dispose();
  TradeLicenseForm.applicantEmailController = TextEditingController();

  TradeLicenseForm.applicantSpouseController?.dispose();
  TradeLicenseForm.applicantSpouseController = TextEditingController();

  TradeLicenseForm.applicantMotherController?.dispose();
  TradeLicenseForm.applicantMotherController = TextEditingController();

  /// Dispose and reset organization info controllers
  TradeLicenseForm.organizationNameBanglaController.dispose();
  TradeLicenseForm.organizationNameBanglaController = TextEditingController();

  TradeLicenseForm.organizationNameEnglishController.dispose();
  TradeLicenseForm.organizationNameEnglishController = TextEditingController();

  TradeLicenseForm.businessDetailsController.dispose();
  TradeLicenseForm.businessDetailsController = TextEditingController();

  TradeLicenseForm.businessAddressController.dispose();
  TradeLicenseForm.businessAddressController = TextEditingController();

  TradeLicenseForm.marketNameController.dispose();
  TradeLicenseForm.marketNameController = TextEditingController();

  TradeLicenseForm.floorNumberController.dispose();
  TradeLicenseForm.floorNumberController = TextEditingController();

  TradeLicenseForm.shopNumberController.dispose();
  TradeLicenseForm.shopNumberController = TextEditingController();

  // Dispose and reset business info controllers
  TradeLicenseForm.businessSignBoardWidthController.dispose();
  TradeLicenseForm.businessSignBoardWidthController = TextEditingController();

  TradeLicenseForm.businessSignBoardHeightController.dispose();
  TradeLicenseForm.businessSignBoardHeightController = TextEditingController();

  TradeLicenseForm.rgcNumberController.dispose();
  TradeLicenseForm.rgcNumberController = TextEditingController();

  TradeLicenseForm.paidFeeAssetAmountController.dispose();
  TradeLicenseForm.paidFeeAssetAmountController = TextEditingController();

  /// Reset application ID
  TradeLicenseForm.applicationId = null;
}

class TradeLicenseForm {
  static int? applicationId;

  ///Holding Info Fields
  static List<DropdownMenuItem<int>> taxZoneList = [];
  static List<DropdownMenuItem<int>> wardList = [];
  static List<DropdownMenuItem<int>> mouzaList = [];
  static int? taxZone;
  static int? ward;
  static int? mouza;
  static TextEditingController? blockController = TextEditingController();
  static TextEditingController? streetController = TextEditingController();
  static TextEditingController? holdingController = TextEditingController();

  ///

  ///Applicant Info Fields
  static TextEditingController? applicantNameBanglaController =
  TextEditingController();
  static TextEditingController? applicantNameEnglishController =
  TextEditingController();
  static TextEditingController? applicantNidController =
  TextEditingController();
  static DateTime? applicantDob;
  static TextEditingController? applicantMobileController =
  TextEditingController();
  static TextEditingController? applicantPhoneController =
  TextEditingController();
  static TextEditingController? applicantEmailController =
  TextEditingController();
  static TextEditingController? applicantSpouseController =
  TextEditingController();
  static TextEditingController? applicantMotherController =
  TextEditingController();

  ///

  ///Applicant Address Fields
  static List<DropdownMenuItem<int>> presentDivisionList = [];
  static List<DropdownMenuItem<int>> presentDistrictList = [];
  static List<DropdownMenuItem<int>> presentThanaList = [];
  static int? presentDivision;
  static int? presentDistrict;
  static int? presentThana;
  static TextEditingController presentPostCodeController =
  TextEditingController();
  static TextEditingController presentAreaController = TextEditingController();
  static TextEditingController presentStreetController =
  TextEditingController();
  static TextEditingController presentHoldingController =
  TextEditingController();

  static bool isSameAddress = true;

  static List<DropdownMenuItem<int>> permanentDivisionList = [];
  static List<DropdownMenuItem<int>> permanentDistrictList = [];
  static List<DropdownMenuItem<int>> permanentThanaList = [];
  static int? permanentDivision;
  static int? permanentDistrict;
  static int? permanentThana;
  static TextEditingController permanentPostCodeController =
  TextEditingController();
  static TextEditingController permanentAreaController =
  TextEditingController();
  static TextEditingController permanentStreetController =
  TextEditingController();
  static TextEditingController permanentHoldingController =
  TextEditingController();

  ///

  ///Organization Info Fields
  static TextEditingController organizationNameBanglaController =
  TextEditingController();
  static TextEditingController organizationNameEnglishController =
  TextEditingController();
  static TextEditingController businessDetailsController =
  TextEditingController();
  static DateTime? businessStartDate;
  static DateTime? businessRegistrationDate;

  static TextEditingController businessAddressController =
  TextEditingController();
  static TextEditingController marketNameController = TextEditingController();
  static TextEditingController floorNumberController = TextEditingController();
  static TextEditingController shopNumberController = TextEditingController();

  ///

  ///Business Info Fields
  static List<DropdownMenuItem<int>> businessOrgTypeList = [];
  static List<DropdownMenuItem<int>> businessTypeList = [];
  static List<DropdownMenuItem<int>> businessSubTypeList = [];
  static List<DropdownMenuItem<int>> businessNatureList = [];
  static List<DropdownMenuItem<int>> businessPlaceTypeList = const [
    DropdownMenuItem(
      value: null,
      child: Text('ব্যবসায় স্থানের প্রকৃতি নির্বাচন করুন'),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text('ভাড়া'),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text('নিজস্ব'),
    ),
  ];
  static List<DropdownMenuItem<int>> businessWorkTypeList = const [
    DropdownMenuItem(
      value: null,
      child: Text('কার্যক্রমের ধরন নির্বাচন করুন'),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text('খুচরা'),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text('পাইকারি'),
    ),
    DropdownMenuItem(
      value: 3,
      child: Text('অন্যান্য'),
    ),
  ];
  static TextEditingController businessSignBoardWidthController =
  TextEditingController();
  static TextEditingController businessSignBoardHeightController =
  TextEditingController();
  static List<DropdownMenuItem<int>> isFactoryList = [
    const DropdownMenuItem(
      value: 0,
      child: Text('না'),
    ),
    const DropdownMenuItem(
      value: 1,
      child: Text('হ্যাঁ'),
    ),
  ];
  static List<DropdownMenuItem<int>> isExplosiveList = const [
    DropdownMenuItem(
      value: 0,
      child: Text('না'),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text('হ্যাঁ'),
    ),
  ];
  static TextEditingController rgcNumberController = TextEditingController();
  static TextEditingController paidFeeAssetAmountController =
  TextEditingController();
  static int? businessOrgType;
  static int? businessType;
  static int? businessSubType;
  static int? businessNature;
  static int? businessPlaceType;
  static int? businessWorkType;
  static int isExplosive = 0;
  static int isFactory = 0;

  ///

  /// Attachment Fields
  static FilePickerResult? ownerImageAttachment;
  static FilePickerResult? ownerSignatureAttachment;
  static FilePickerResult? ownerNidAttachment;
  static FilePickerResult? rentFileAttachment;
  static FilePickerResult? fireServiceAttachment;
  static TextEditingController fireServiceMemoNumberController =
  TextEditingController();
  static DateTime? fireServiceMemoDate;
  static FilePickerResult? nocAttachment;
  static TextEditingController nocMemoNumberController =
  TextEditingController();
  static DateTime? nocMemoDate;
  static FilePickerResult? twentyFourNoticeAttachment;
  static TextEditingController twentyFourNoticeMemoNumberController =
  TextEditingController();
  static DateTime? twentyFourNoticeMemoDate;
  static FilePickerResult? boilerCharpottroAttachment;
  static TextEditingController boilerMemoNumberController =
  TextEditingController();
  static DateTime? boilerMemoDate;
  static FilePickerResult? bokeyaAttachment;
  static TextEditingController dueTaxMemoNumberController =
  TextEditingController();
  static DateTime? dueTaxMemoDate;
  static FilePickerResult? holdingAttachment;
  static TextEditingController holdingTaxBillNumberController =
  TextEditingController();
  static DateTime? holdingTaxBillDate;
  static FilePickerResult? tradeLicenseAttachment;
  static FilePickerResult? measurementCertificateAttachment;
  static FilePickerResult? chemicalUseAttachment;
  static FilePickerResult? taxAssessmentAttachment;

///
}
