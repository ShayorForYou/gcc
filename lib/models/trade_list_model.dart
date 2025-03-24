import 'dart:convert';

List<TradeLicenseListModel> tradeLicenseListModelFromJson(String str) =>
    List<TradeLicenseListModel>.from(
        json.decode(str).map((x) => TradeLicenseListModel.fromJson(x)));

String tradeLicenseListModelToJson(List<TradeLicenseListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TradeLicenseListModel {
  int? applicationId;
  int? servicesId;
  int? subServiceId;
  DateTime? applicatonDate;
  int? temApplicationSl;
  dynamic applicationSl;
  int? organizationId;
  int? holdingId;
  int? financialYearId;
  dynamic businessNatureId;
  dynamic businessOrgTypeId;
  dynamic businessSubTypeId;
  dynamic businessTypeId;
  dynamic businessNatureFeeId;
  int? isActive;
  dynamic ownerMobileNumber;
  dynamic orgNameBangla;
  dynamic orgNameEnglish;
  dynamic businessDescription;
  DateTime? firstIssueDate;
  dynamic businessAddress;
  dynamic demandRegisterNo;
  dynamic oldTradeNumber;
  dynamic marketName;
  dynamic floorNo;
  dynamic shopNo;
  dynamic businessPlaceType;
  dynamic workType;
  dynamic companyRgcRegNumber;
  dynamic paidFeeAssetAmount;
  dynamic signBoardWidth;
  dynamic signBoardHeight;
  dynamic factoryStatus;
  dynamic crimicalStatus;
  dynamic smartTradeLicenceNumber;
  dynamic renewDate;
  dynamic expireDate;
  dynamic renewalDuration;
  int? initialFeeAmount;
  dynamic nocMemoNumber;
  dynamic nocMemoDate;
  dynamic twentyFourNoticeMemoNumber;
  dynamic twentyFourNoticeMemoDate;
  dynamic factoryMemoNumber;
  dynamic factoryMemoDate;
  dynamic fireserviceMemoNumber;
  dynamic fireserviceMemoDate;
  dynamic boilerMemoNumber;
  dynamic boilerMemoDate;
  dynamic dueTaxMemoNumber;
  dynamic dueTaxMemoDate;
  dynamic holdingTaxBillNumbor;
  dynamic holdingTaxBillDate;
  dynamic ownerImageAttachement;
  dynamic ownerSignatureAttachement;
  dynamic ownerNidAttachement;
  dynamic ownerNidNumber;
  dynamic ownerDateOfBirth;
  dynamic ownerName;
  dynamic ownerNameBangla;
  dynamic ownerFatherName;
  dynamic ownerMotherName;
  dynamic ownerSpouseName;
  dynamic tinNumber;
  dynamic binNumber;
  dynamic email;
  dynamic phone;
  dynamic presentHoldingNo;
  dynamic presentRoadNo;
  dynamic presentMoholla;
  dynamic presentPostcode;
  dynamic presentThanaId;
  dynamic presentDistrictId;
  dynamic presentDivisionId;
  dynamic permanentHoldingNo;
  dynamic permanentRoadNo;
  dynamic permanentMoholla;
  dynamic permanentPostcode;
  dynamic permanentThanaId;
  dynamic permanentDistrictId;
  dynamic permanentDivisionId;
  dynamic businessStartDate;
  dynamic dolillAttachement;
  dynamic rentFileAttachement;
  dynamic boilierCharpottroAttachement;
  dynamic fireServiceAttachement;
  dynamic layoutAttachement;
  dynamic twentyFourNoticeAttachement;
  dynamic holdingAttachement;
  dynamic bokeyaAttachement;
  dynamic industrialAttachement;
  dynamic tradeLicenceAttachement;
  dynamic nocAttachement;
  dynamic measurementCertificateAttachement;
  dynamic crimicalUseAttachement;
  dynamic taxSsMentAtachement;
  dynamic pescribeApplicationForm;
  dynamic surcharge;
  dynamic taxAmount;
  dynamic bokeya;
  dynamic correctionFee;
  dynamic signboardTax;
  dynamic vat;
  dynamic bookFee;
  dynamic advertisementFee;
  dynamic variousFee;
  dynamic formFee;
  dynamic othersFee;
  String? applicationStatus;
  dynamic licenceFee;
  dynamic renewLastDate;
  dynamic surrenderDescription;
  int? updatedBy;
  int? createdBy;
  dynamic toUserId;
  dynamic businessNature;
  FinancialYear? financialYear;
  Holding? holding;
  Organization? organization;
  dynamic businessType;
  dynamic toUser;
  BusinessOrgType? businessOrgType;
  SubService? subService;

  TradeLicenseListModel({
    this.applicationId,
    this.servicesId,
    this.subServiceId,
    this.applicatonDate,
    this.temApplicationSl,
    this.applicationSl,
    this.organizationId,
    this.holdingId,
    this.financialYearId,
    this.businessNatureId,
    this.businessOrgTypeId,
    this.businessSubTypeId,
    this.businessTypeId,
    this.businessNatureFeeId,
    this.isActive,
    this.ownerMobileNumber,
    this.orgNameBangla,
    this.orgNameEnglish,
    this.businessDescription,
    this.firstIssueDate,
    this.businessAddress,
    this.demandRegisterNo,
    this.oldTradeNumber,
    this.marketName,
    this.floorNo,
    this.shopNo,
    this.businessPlaceType,
    this.workType,
    this.companyRgcRegNumber,
    this.paidFeeAssetAmount,
    this.signBoardWidth,
    this.signBoardHeight,
    this.factoryStatus,
    this.crimicalStatus,
    this.smartTradeLicenceNumber,
    this.renewDate,
    this.expireDate,
    this.renewalDuration,
    this.initialFeeAmount,
    this.nocMemoNumber,
    this.nocMemoDate,
    this.twentyFourNoticeMemoNumber,
    this.twentyFourNoticeMemoDate,
    this.factoryMemoNumber,
    this.factoryMemoDate,
    this.fireserviceMemoNumber,
    this.fireserviceMemoDate,
    this.boilerMemoNumber,
    this.boilerMemoDate,
    this.dueTaxMemoNumber,
    this.dueTaxMemoDate,
    this.holdingTaxBillNumbor,
    this.holdingTaxBillDate,
    this.ownerImageAttachement,
    this.ownerSignatureAttachement,
    this.ownerNidAttachement,
    this.ownerNidNumber,
    this.ownerDateOfBirth,
    this.ownerName,
    this.ownerNameBangla,
    this.ownerFatherName,
    this.ownerMotherName,
    this.ownerSpouseName,
    this.tinNumber,
    this.binNumber,
    this.email,
    this.phone,
    this.presentHoldingNo,
    this.presentRoadNo,
    this.presentMoholla,
    this.presentPostcode,
    this.presentThanaId,
    this.presentDistrictId,
    this.presentDivisionId,
    this.permanentHoldingNo,
    this.permanentRoadNo,
    this.permanentMoholla,
    this.permanentPostcode,
    this.permanentThanaId,
    this.permanentDistrictId,
    this.permanentDivisionId,
    this.businessStartDate,
    this.dolillAttachement,
    this.rentFileAttachement,
    this.boilierCharpottroAttachement,
    this.fireServiceAttachement,
    this.layoutAttachement,
    this.twentyFourNoticeAttachement,
    this.holdingAttachement,
    this.bokeyaAttachement,
    this.industrialAttachement,
    this.tradeLicenceAttachement,
    this.nocAttachement,
    this.measurementCertificateAttachement,
    this.crimicalUseAttachement,
    this.taxSsMentAtachement,
    this.pescribeApplicationForm,
    this.surcharge,
    this.taxAmount,
    this.bokeya,
    this.correctionFee,
    this.signboardTax,
    this.vat,
    this.bookFee,
    this.advertisementFee,
    this.variousFee,
    this.formFee,
    this.othersFee,
    this.applicationStatus,
    this.licenceFee,
    this.renewLastDate,
    this.surrenderDescription,
    this.updatedBy,
    this.createdBy,
    this.toUserId,
    this.businessNature,
    this.financialYear,
    this.holding,
    this.organization,
    this.businessType,
    this.toUser,
    this.businessOrgType,
    this.subService,
  });

  factory TradeLicenseListModel.fromJson(Map<String, dynamic> json) =>
      TradeLicenseListModel(
        applicationId: json["application_id"],
        servicesId: json["services_id"],
        subServiceId: json["sub_service_id"],
        applicatonDate: json["applicaton_date"] == null
            ? null
            : DateTime.parse(json["applicaton_date"]),
        temApplicationSl: json["tem_application_sl"],
        applicationSl: json["application_sl"],
        organizationId: json["organization_id"],
        holdingId: json["holding_id"],
        financialYearId: json["financial_year_id"],
        businessNatureId: json["business_nature_id"],
        businessOrgTypeId: json["business_org_type_id"],
        businessSubTypeId: json["business_sub_type_id"],
        businessTypeId: json["business_type_id"],
        businessNatureFeeId: json["business_nature_fee_id"],
        isActive: json["is_active"],
        ownerMobileNumber: json["owner_mobile_number"],
        orgNameBangla: json["org_name_bangla"],
        orgNameEnglish: json["org_name_english"],
        businessDescription: json["business_description"],
        firstIssueDate: json["first_issue_date"] == null
            ? null
            : DateTime.parse(json["first_issue_date"]),
        businessAddress: json["business_address"],
        demandRegisterNo: json["demand_register_no"],
        oldTradeNumber: json["old_trade_number"],
        marketName: json["market_name"],
        floorNo: json["floor_no"],
        shopNo: json["shop_no"],
        businessPlaceType: json["business_place_type"],
        workType: json["work_type"],
        companyRgcRegNumber: json["company_rgc_reg_number"],
        paidFeeAssetAmount: json["paid_fee_asset_amount"],
        signBoardWidth: json["sign_board_width"],
        signBoardHeight: json["sign_board_height"],
        factoryStatus: json["factory_status"],
        crimicalStatus: json["crimical_status"],
        smartTradeLicenceNumber: json["smart_trade_licence_number"],
        renewDate: json["renew_date"],
        expireDate: json["expire_date"],
        renewalDuration: json["renewal_duration"],
        initialFeeAmount: json["initial_fee_amount"],
        nocMemoNumber: json["noc_memo_number"],
        nocMemoDate: json["noc_memo_date"],
        twentyFourNoticeMemoNumber: json["twenty_four_notice_memo_number"],
        twentyFourNoticeMemoDate: json["twenty_four_notice_memo_date"],
        factoryMemoNumber: json["factory_memo_number"],
        factoryMemoDate: json["factory_memo_date"],
        fireserviceMemoNumber: json["fireservice_memo_number"],
        fireserviceMemoDate: json["fireservice_memo_date"],
        boilerMemoNumber: json["boiler_memo_number"],
        boilerMemoDate: json["boiler_memo_date"],
        dueTaxMemoNumber: json["due_tax_memo_number"],
        dueTaxMemoDate: json["due_tax_memo_date"],
        holdingTaxBillNumbor: json["holding_tax_bill_numbor"],
        holdingTaxBillDate: json["holding_tax_bill_date"],
        ownerImageAttachement: json["owner_image_attachement"],
        ownerSignatureAttachement: json["owner_signature_attachement"],
        ownerNidAttachement: json["owner_nid_attachement"],
        ownerNidNumber: json["owner_nid_number"],
        ownerDateOfBirth: json["owner_date_of_birth"],
        ownerName: json["owner_name"],
        ownerNameBangla: json["owner_name_bangla"],
        ownerFatherName: json["owner_father_name"],
        ownerMotherName: json["owner_mother_name"],
        ownerSpouseName: json["owner_spouse_name"],
        tinNumber: json["tin_number"],
        binNumber: json["bin_number"],
        email: json["email"],
        phone: json["phone"],
        presentHoldingNo: json["present_holding_no"],
        presentRoadNo: json["present_road_no"],
        presentMoholla: json["present_moholla"],
        presentPostcode: json["present_postcode"],
        presentThanaId: json["present_thana_id"],
        presentDistrictId: json["present_district_id"],
        presentDivisionId: json["present_division_id"],
        permanentHoldingNo: json["permanent_holding_no"],
        permanentRoadNo: json["permanent_road_no"],
        permanentMoholla: json["permanent_moholla"],
        permanentPostcode: json["permanent_postcode"],
        permanentThanaId: json["permanent_thana_id"],
        permanentDistrictId: json["permanent_district_id"],
        permanentDivisionId: json["permanent_division_id"],
        businessStartDate: json["business_start_date"],
        dolillAttachement: json["dolill_attachement"],
        rentFileAttachement: json["rent_file_attachement"],
        boilierCharpottroAttachement: json["boilier_charpottro_attachement"],
        fireServiceAttachement: json["fire_service_attachement"],
        layoutAttachement: json["layout_attachement"],
        twentyFourNoticeAttachement: json["twenty_four_notice_attachement"],
        holdingAttachement: json["holding_attachement"],
        bokeyaAttachement: json["bokeya_attachement"],
        industrialAttachement: json["industrial_attachement"],
        tradeLicenceAttachement: json["trade_licence_attachement"],
        nocAttachement: json["noc_attachement"],
        measurementCertificateAttachement:
        json["measurement_certificate_attachement"],
        crimicalUseAttachement: json["crimical_use_attachement"],
        taxSsMentAtachement: json["tax_ss_ment_atachement"],
        pescribeApplicationForm: json["pescribe_application_form"],
        surcharge: json["surcharge"],
        taxAmount: json["tax_amount"],
        bokeya: json["bokeya"],
        correctionFee: json["correction_fee"],
        signboardTax: json["signboard_tax"],
        vat: json["vat"],
        bookFee: json["book_fee"],
        advertisementFee: json["advertisement_fee"],
        variousFee: json["various_fee"],
        formFee: json["form_fee"],
        othersFee: json["others_fee"],
        applicationStatus: json["application_status"],
        licenceFee: json["licence_fee"],
        renewLastDate: json["renew_last_date"],
        surrenderDescription: json["surrender_description"],
        updatedBy: json["updated_by"],
        createdBy: json["created_by"],
        toUserId: json["to_user_id"],
        businessNature: json["business_nature"],
        financialYear: json["financial_year"] == null
            ? null
            : FinancialYear.fromJson(json["financial_year"]),
        holding:
        json["holding"] == null ? null : Holding.fromJson(json["holding"]),
        organization: json["organization"] == null
            ? null
            : Organization.fromJson(json["organization"]),
        businessType: json["business_type"],
        toUser: json["to_user"],
        businessOrgType: json["business_org_type"] == null
            ? null
            : BusinessOrgType.fromJson(json["business_org_type"]),
        subService: json["sub_service"] == null
            ? null
            : SubService.fromJson(json["sub_service"]),
      );

  Map<String, dynamic> toJson() => {
    "application_id": applicationId,
    "services_id": servicesId,
    "sub_service_id": subServiceId,
    "applicaton_date":
    "${applicatonDate!.year.toString().padLeft(4, '0')}-${applicatonDate!.month.toString().padLeft(2, '0')}-${applicatonDate!.day.toString().padLeft(2, '0')}",
    "tem_application_sl": temApplicationSl,
    "application_sl": applicationSl,
    "organization_id": organizationId,
    "holding_id": holdingId,
    "financial_year_id": financialYearId,
    "business_nature_id": businessNatureId,
    "business_org_type_id": businessOrgTypeId,
    "business_sub_type_id": businessSubTypeId,
    "business_type_id": businessTypeId,
    "business_nature_fee_id": businessNatureFeeId,
    "is_active": isActive,
    "owner_mobile_number": ownerMobileNumber,
    "org_name_bangla": orgNameBangla,
    "org_name_english": orgNameEnglish,
    "business_description": businessDescription,
    "first_issue_date": firstIssueDate?.toIso8601String(),
    "business_address": businessAddress,
    "demand_register_no": demandRegisterNo,
    "old_trade_number": oldTradeNumber,
    "market_name": marketName,
    "floor_no": floorNo,
    "shop_no": shopNo,
    "business_place_type": businessPlaceType,
    "work_type": workType,
    "company_rgc_reg_number": companyRgcRegNumber,
    "paid_fee_asset_amount": paidFeeAssetAmount,
    "sign_board_width": signBoardWidth,
    "sign_board_height": signBoardHeight,
    "factory_status": factoryStatus,
    "crimical_status": crimicalStatus,
    "smart_trade_licence_number": smartTradeLicenceNumber,
    "renew_date": renewDate,
    "expire_date": expireDate,
    "renewal_duration": renewalDuration,
    "initial_fee_amount": initialFeeAmount,
    "noc_memo_number": nocMemoNumber,
    "noc_memo_date": nocMemoDate,
    "twenty_four_notice_memo_number": twentyFourNoticeMemoNumber,
    "twenty_four_notice_memo_date": twentyFourNoticeMemoDate,
    "factory_memo_number": factoryMemoNumber,
    "factory_memo_date": factoryMemoDate,
    "fireservice_memo_number": fireserviceMemoNumber,
    "fireservice_memo_date": fireserviceMemoDate,
    "boiler_memo_number": boilerMemoNumber,
    "boiler_memo_date": boilerMemoDate,
    "due_tax_memo_number": dueTaxMemoNumber,
    "due_tax_memo_date": dueTaxMemoDate,
    "holding_tax_bill_numbor": holdingTaxBillNumbor,
    "holding_tax_bill_date": holdingTaxBillDate,
    "owner_image_attachement": ownerImageAttachement,
    "owner_signature_attachement": ownerSignatureAttachement,
    "owner_nid_attachement": ownerNidAttachement,
    "owner_nid_number": ownerNidNumber,
    "owner_date_of_birth": ownerDateOfBirth,
    "owner_name": ownerName,
    "owner_name_bangla": ownerNameBangla,
    "owner_father_name": ownerFatherName,
    "owner_mother_name": ownerMotherName,
    "owner_spouse_name": ownerSpouseName,
    "tin_number": tinNumber,
    "bin_number": binNumber,
    "email": email,
    "phone": phone,
    "present_holding_no": presentHoldingNo,
    "present_road_no": presentRoadNo,
    "present_moholla": presentMoholla,
    "present_postcode": presentPostcode,
    "present_thana_id": presentThanaId,
    "present_district_id": presentDistrictId,
    "present_division_id": presentDivisionId,
    "permanent_holding_no": permanentHoldingNo,
    "permanent_road_no": permanentRoadNo,
    "permanent_moholla": permanentMoholla,
    "permanent_postcode": permanentPostcode,
    "permanent_thana_id": permanentThanaId,
    "permanent_district_id": permanentDistrictId,
    "permanent_division_id": permanentDivisionId,
    "business_start_date": businessStartDate,
    "dolill_attachement": dolillAttachement,
    "rent_file_attachement": rentFileAttachement,
    "boilier_charpottro_attachement": boilierCharpottroAttachement,
    "fire_service_attachement": fireServiceAttachement,
    "layout_attachement": layoutAttachement,
    "twenty_four_notice_attachement": twentyFourNoticeAttachement,
    "holding_attachement": holdingAttachement,
    "bokeya_attachement": bokeyaAttachement,
    "industrial_attachement": industrialAttachement,
    "trade_licence_attachement": tradeLicenceAttachement,
    "noc_attachement": nocAttachement,
    "measurement_certificate_attachement":
    measurementCertificateAttachement,
    "crimical_use_attachement": crimicalUseAttachement,
    "tax_ss_ment_atachement": taxSsMentAtachement,
    "pescribe_application_form": pescribeApplicationForm,
    "surcharge": surcharge,
    "tax_amount": taxAmount,
    "bokeya": bokeya,
    "correction_fee": correctionFee,
    "signboard_tax": signboardTax,
    "vat": vat,
    "book_fee": bookFee,
    "advertisement_fee": advertisementFee,
    "various_fee": variousFee,
    "form_fee": formFee,
    "others_fee": othersFee,
    "application_status": applicationStatus,
    "licence_fee": licenceFee,
    "renew_last_date": renewLastDate,
    "surrender_description": surrenderDescription,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "to_user_id": toUserId,
    "business_nature": businessNature,
    "financial_year": financialYear?.toJson(),
    "holding": holding?.toJson(),
    "organization": organization?.toJson(),
    "business_type": businessType,
    "to_user": toUser,
    "business_org_type": businessOrgType?.toJson(),
    "sub_service": subService?.toJson(),
  };
}

class FinancialYear {
  int? financialYearId;
  String? financialYear;

  FinancialYear({
    this.financialYearId,
    this.financialYear,
  });

  factory FinancialYear.fromJson(Map<String, dynamic> json) => FinancialYear(
    financialYearId: json["financial_year_id"],
    financialYear: json["financial_year"],
  );

  Map<String, dynamic> toJson() => {
    "financial_year_id": financialYearId,
    "financial_year": financialYear,
  };
}

class Holding {
  int? holdingId;
  int? userId;
  int? organizationId;
  dynamic oldHoldingNo;
  String? block;
  String? newHoldingNo;
  int? smartCardNumber;
  DateTime? holdingAddDate;
  int? wordId;
  int? unionId;
  dynamic roadId;
  int? mouzaId;
  int? taxZoneId;
  dynamic buildingUseId;
  dynamic businessOrgTypeId;
  dynamic ownerFullNameBangla;
  dynamic ownerFullNameEnglish;
  dynamic ownerNid;
  dynamic ownerDateOfBirth;
  dynamic ownerCurrentAddress;
  dynamic ownerPermanentAddress;
  dynamic ownerMobile;
  dynamic ownerEmail;
  dynamic ownerPhone;
  dynamic ownerFatherName;
  dynamic ownerMotherName;
  DateTime? firstIssueDate;
  dynamic demandRegisterNo;
  dynamic ownerImageAttachement;
  dynamic ownerSignatureAttachement;
  dynamic ownerNidAttachement;
  dynamic dolillAttachement;
  dynamic holdingAttachement;
  int? holdingStatus;
  int? createdBy;
  dynamic updatedBy;
  Word? word;
  TaxZone? taxZone;

  Holding({
    this.holdingId,
    this.userId,
    this.organizationId,
    this.oldHoldingNo,
    this.block,
    this.newHoldingNo,
    this.smartCardNumber,
    this.holdingAddDate,
    this.wordId,
    this.unionId,
    this.roadId,
    this.mouzaId,
    this.taxZoneId,
    this.buildingUseId,
    this.businessOrgTypeId,
    this.ownerFullNameBangla,
    this.ownerFullNameEnglish,
    this.ownerNid,
    this.ownerDateOfBirth,
    this.ownerCurrentAddress,
    this.ownerPermanentAddress,
    this.ownerMobile,
    this.ownerEmail,
    this.ownerPhone,
    this.ownerFatherName,
    this.ownerMotherName,
    this.firstIssueDate,
    this.demandRegisterNo,
    this.ownerImageAttachement,
    this.ownerSignatureAttachement,
    this.ownerNidAttachement,
    this.dolillAttachement,
    this.holdingAttachement,
    this.holdingStatus,
    this.createdBy,
    this.updatedBy,
    this.word,
    this.taxZone,
  });

  factory Holding.fromJson(Map<String, dynamic> json) => Holding(
    holdingId: json["holding_id"],
    userId: json["user_id"],
    organizationId: json["organization_id"],
    oldHoldingNo: json["old_holding_no"],
    block: json["block"],
    newHoldingNo: json["new_holding_no"],
    smartCardNumber: json["smart_card_number"],
    holdingAddDate: json["holding_add_date"] == null
        ? null
        : DateTime.parse(json["holding_add_date"]),
    wordId: json["word_id"],
    unionId: json["union_id"],
    roadId: json["road_id"],
    mouzaId: json["mouza_id"],
    taxZoneId: json["tax_zone_id"],
    buildingUseId: json["building_use_id"],
    businessOrgTypeId: json["business_org_type_id"],
    ownerFullNameBangla: json["owner_full_name_bangla"],
    ownerFullNameEnglish: json["owner_full_name_english"],
    ownerNid: json["owner_nid"],
    ownerDateOfBirth: json["owner_date_of_birth"],
    ownerCurrentAddress: json["owner_current_address"],
    ownerPermanentAddress: json["owner_permanent_address"],
    ownerMobile: json["owner_mobile"],
    ownerEmail: json["owner_email"],
    ownerPhone: json["owner_phone"],
    ownerFatherName: json["owner_father_name"],
    ownerMotherName: json["owner_mother_name"],
    firstIssueDate: json["first_issue_date"] == null
        ? null
        : DateTime.parse(json["first_issue_date"]),
    demandRegisterNo: json["demand_register_no"],
    ownerImageAttachement: json["owner_image_attachement"],
    ownerSignatureAttachement: json["owner_signature_attachement"],
    ownerNidAttachement: json["owner_nid_attachement"],
    dolillAttachement: json["dolill_attachement"],
    holdingAttachement: json["holding_attachement"],
    holdingStatus: json["holding_status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    word: json["word"] == null ? null : Word.fromJson(json["word"]),
    taxZone: json["tax_zone"] == null
        ? null
        : TaxZone.fromJson(json["tax_zone"]),
  );

  Map<String, dynamic> toJson() => {
    "holding_id": holdingId,
    "user_id": userId,
    "organization_id": organizationId,
    "old_holding_no": oldHoldingNo,
    "block": block,
    "new_holding_no": newHoldingNo,
    "smart_card_number": smartCardNumber,
    "holding_add_date":
    "${holdingAddDate!.year.toString().padLeft(4, '0')}-${holdingAddDate!.month.toString().padLeft(2, '0')}-${holdingAddDate!.day.toString().padLeft(2, '0')}",
    "word_id": wordId,
    "union_id": unionId,
    "road_id": roadId,
    "mouza_id": mouzaId,
    "tax_zone_id": taxZoneId,
    "building_use_id": buildingUseId,
    "business_org_type_id": businessOrgTypeId,
    "owner_full_name_bangla": ownerFullNameBangla,
    "owner_full_name_english": ownerFullNameEnglish,
    "owner_nid": ownerNid,
    "owner_date_of_birth": ownerDateOfBirth,
    "owner_current_address": ownerCurrentAddress,
    "owner_permanent_address": ownerPermanentAddress,
    "owner_mobile": ownerMobile,
    "owner_email": ownerEmail,
    "owner_phone": ownerPhone,
    "owner_father_name": ownerFatherName,
    "owner_mother_name": ownerMotherName,
    "first_issue_date":
    "${firstIssueDate!.year.toString().padLeft(4, '0')}-${firstIssueDate!.month.toString().padLeft(2, '0')}-${firstIssueDate!.day.toString().padLeft(2, '0')}",
    "demand_register_no": demandRegisterNo,
    "owner_image_attachement": ownerImageAttachement,
    "owner_signature_attachement": ownerSignatureAttachement,
    "owner_nid_attachement": ownerNidAttachement,
    "dolill_attachement": dolillAttachement,
    "holding_attachement": holdingAttachement,
    "holding_status": holdingStatus,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "word": word?.toJson(),
    "tax_zone": taxZone?.toJson(),
  };
}

class TaxZone {
  int? taxZoneId;
  String? taxZoneName;

  TaxZone({
    this.taxZoneId,
    this.taxZoneName,
  });

  factory TaxZone.fromJson(Map<String, dynamic> json) => TaxZone(
    taxZoneId: json["tax_zone_id"],
    taxZoneName: json["tax_zone_name"],
  );

  Map<String, dynamic> toJson() => {
    "tax_zone_id": taxZoneId,
    "tax_zone_name": taxZoneName,
  };
}

class Word {
  int? wordId;
  String? wordNameBangla;

  Word({
    this.wordId,
    this.wordNameBangla,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
    wordId: json["word_id"],
    wordNameBangla: json["word_name_bangla"],
  );

  Map<String, dynamic> toJson() => {
    "word_id": wordId,
    "word_name_bangla": wordNameBangla,
  };
}

class Organization {
  int? organizationId;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  int? unionId;
  int? wordId;
  dynamic policeStationId;
  dynamic constituencyId;
  String? orgNameBangla;
  String? orgNameEnglish;
  String? subDomain;
  String? domain;
  String? orgMobile;
  String? orgEmail;
  String? orgAddress;
  String? orgLogo;
  int? isActive;
  int? userLimit;
  int? orgType;
  dynamic isDefault;
  dynamic orgStartTime;
  dynamic orgEndTime;
  int? createdBy;
  dynamic updatedBy;
  District? district;
  Upazila? upazila;

  Organization({
    this.organizationId,
    this.divisionId,
    this.districtId,
    this.upazilaId,
    this.unionId,
    this.wordId,
    this.policeStationId,
    this.constituencyId,
    this.orgNameBangla,
    this.orgNameEnglish,
    this.subDomain,
    this.domain,
    this.orgMobile,
    this.orgEmail,
    this.orgAddress,
    this.orgLogo,
    this.isActive,
    this.userLimit,
    this.orgType,
    this.isDefault,
    this.orgStartTime,
    this.orgEndTime,
    this.createdBy,
    this.updatedBy,
    this.district,
    this.upazila,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    organizationId: json["organization_id"],
    divisionId: json["division_id"],
    districtId: json["district_id"],
    upazilaId: json["upazila_id"],
    unionId: json["union_id"],
    wordId: json["word_id"],
    policeStationId: json["police_station_id"],
    constituencyId: json["constituency_id"],
    orgNameBangla: json["org_name_bangla"],
    orgNameEnglish: json["org_name_english"],
    subDomain: json["sub_domain"],
    domain: json["domain"],
    orgMobile: json["org_mobile"],
    orgEmail: json["org_email"],
    orgAddress: json["org_address"],
    orgLogo: json["org_logo"],
    isActive: json["is_active"],
    userLimit: json["user_limit"],
    orgType: json["org_type"],
    isDefault: json["is_default"],
    orgStartTime: json["org_start_time"],
    orgEndTime: json["org_end_time"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    district: json["district"] == null
        ? null
        : District.fromJson(json["district"]),
    upazila:
    json["upazila"] == null ? null : Upazila.fromJson(json["upazila"]),
  );

  Map<String, dynamic> toJson() => {
    "organization_id": organizationId,
    "division_id": divisionId,
    "district_id": districtId,
    "upazila_id": upazilaId,
    "union_id": unionId,
    "word_id": wordId,
    "police_station_id": policeStationId,
    "constituency_id": constituencyId,
    "org_name_bangla": orgNameBangla,
    "org_name_english": orgNameEnglish,
    "sub_domain": subDomain,
    "domain": domain,
    "org_mobile": orgMobile,
    "org_email": orgEmail,
    "org_address": orgAddress,
    "org_logo": orgLogo,
    "is_active": isActive,
    "user_limit": userLimit,
    "org_type": orgType,
    "is_default": isDefault,
    "org_start_time": orgStartTime,
    "org_end_time": orgEndTime,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "district": district?.toJson(),
    "upazila": upazila?.toJson(),
  };
}

class District {
  int? districtId;
  String? districtNameBangla;

  District({
    this.districtId,
    this.districtNameBangla,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    districtId: json["district_id"],
    districtNameBangla: json["district_name_bangla"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId,
    "district_name_bangla": districtNameBangla,
  };
}

class Upazila {
  int? upazilaId;
  String? upazilaNameBangla;

  Upazila({
    this.upazilaId,
    this.upazilaNameBangla,
  });

  factory Upazila.fromJson(Map<String, dynamic> json) => Upazila(
    upazilaId: json["upazila_id"],
    upazilaNameBangla: json["upazila_name_bangla"],
  );

  Map<String, dynamic> toJson() => {
    "upazila_id": upazilaId,
    "upazila_name_bangla": upazilaNameBangla,
  };
}

class BusinessOrgType {
  final int? businessOrgTypeId;
  final String? businessOrgTypeName;
  final String? businessOrgTypeNameBn;
  final int? isActive;

  BusinessOrgType({
    this.businessOrgTypeId,
    this.businessOrgTypeName,
    this.businessOrgTypeNameBn,
    this.isActive,
  });

  factory BusinessOrgType.fromJson(Map<String, dynamic> json) => BusinessOrgType(
    businessOrgTypeId: json["business_org_type_id"],
    businessOrgTypeName: json["business_org_type_name"],
    businessOrgTypeNameBn: json["business_org_type_name_bn"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "business_org_type_id": businessOrgTypeId,
    "business_org_type_name": businessOrgTypeName,
    "business_org_type_name_bn": businessOrgTypeNameBn,
    "is_active": isActive,
  };
}

class SubService {
  int? subServiceId;
  String? licenceTypeName;

  SubService({
    this.subServiceId,
    this.licenceTypeName,
  });

  factory SubService.fromJson(Map<String, dynamic> json) => SubService(
    subServiceId: json["sub_service_id"],
    licenceTypeName: json["licence_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "sub_service_id": subServiceId,
    "licence_type_name": licenceTypeName,
  };
}
