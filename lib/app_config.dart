class AppConfig {
  static const String baseUrl = 'http://146.190.202.13:1501';
  // static const String baseUrl = 'http://192.168.50.148:8080';
  static const String apiUrl = '$baseUrl/api/v1';
  static const String login = '/login';
  static const String getOrganization = '/organization';
  static const String register = '/register';
  static const String verifyOtp = '/verify_otp';
  static const String resendOtp = '/resend';
  static const String getDashboardData = '/dashboard/data';
  static const String getTradeLicenseList = '/trade-license/list';
  static const String saveTradeLicense = '/trade-license/save';
  static const String getTaxZone = '/tax-zone';
  static const String getWard = '/tax-zone-word';
  static const String getMouza = '/mouza';
  static const String getDivision = '/division';
  static const String getDistrict = '/district';
  static const String getThana = '/thana';
  static const String getBusinessOrgType = '/business-org-types';
  static const String getBusinessType = '/business-type';
  static const String getBusinessSubType = '/business-sub-type';
  static const String getBusinessNature = '/business-nature';
}

class AppAssets {
  static const String _imagePath = 'assets/';
  static const String _svgPath = 'assets/svg/';
  static const String _fontPath = 'assets/fonts/';

  /// Images
  static const String slide2 = '${_imagePath}2nd_slide.png';
  static const String bdFlag = '${_imagePath}bd.png';
  static const String emptyProfile = '${_imagePath}emptyProfile.jpg';
  static const String font1 = '${_imagePath}font1.png';
  static const String gccLogo = '${_imagePath}gcc.png';
  static const String mainLogo = '${_imagePath}main_logo.png';
  static const String myGccNew = '${_imagePath}my-gcc-new.png';
  static const String sisl = '${_imagePath}sisl.png';
  static const String title = '${_imagePath}title.png';
  static const String title2 = '${_imagePath}title2.png';
  static const String yunus = '${_imagePath}yunus.png';

  /// SVG
  static const String applicationSvg = '${_svgPath}application.svg';
  static const String calculationSvg = '${_svgPath}calculation.svg';
  static const String informationSvg = '${_svgPath}information.svg';
  static const String loginSvg = '${_svgPath}login.svg';
  static const String noInternetSvg = '${_svgPath}no_internet.svg';
  static const String passwordSvg = '${_svgPath}password.svg';
  static const String renewSvg = '${_svgPath}renew.svg';
  static const String securitySvg = '${_svgPath}security.svg';

  /// Fonts
  static const String fontUbuntuRegular = '${_fontPath}Ubuntu-Regular.ttf';
  static const String fontUbuntuBold = '${_fontPath}Ubuntu-Bold.ttf';
  static const String fontUbuntuLight = '${_fontPath}Ubuntu-Light.ttf';
  static const String fontUbuntuMedium = '${_fontPath}Ubuntu-Medium.ttf';
  static const String fontNikosh = 'Nikosh';
  static const String fontUbuntu = 'Ubuntu';
}
