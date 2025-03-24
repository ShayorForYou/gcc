import 'dart:convert';

DashboardDataModel dashboardDataModelFromJson(String str) =>
    DashboardDataModel.fromJson(json.decode(str));

String dashboardDataModelToJson(DashboardDataModel data) =>
    json.encode(data.toJson());

class DashboardDataModel {
  Data data;
  int status;
  String message;

  DashboardDataModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  List<FinancialYear> financialYearAsc;
  List<FinancialYear> financialYearDesc;
  int totalHolding;
  int totalTaxAmount;
  int totalTaxAssesment;
  List<dynamic> taxPichart;
  Barchart taxBarchart;
  int totalTradeLicense;
  int totalTradeLicenseSuccess;
  int completeTradeLicense;
  int newTradeLicense;
  int processingTradeLicense;
  int cancelTradeLicense;
  List<dynamic> tradePichart;
  Barchart tradeBarchart;

  Data({
    required this.financialYearAsc,
    required this.financialYearDesc,
    required this.totalHolding,
    required this.totalTaxAmount,
    required this.totalTaxAssesment,
    required this.taxPichart,
    required this.taxBarchart,
    required this.totalTradeLicense,
    required this.totalTradeLicenseSuccess,
    required this.completeTradeLicense,
    required this.newTradeLicense,
    required this.processingTradeLicense,
    required this.cancelTradeLicense,
    required this.tradePichart,
    required this.tradeBarchart,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        financialYearAsc: List<FinancialYear>.from(
            json["financial_year_asc"].map((x) => FinancialYear.fromJson(x))),
        financialYearDesc: List<FinancialYear>.from(
            json["financial_year_desc"].map((x) => FinancialYear.fromJson(x))),
        totalHolding: json["total_holding"],
        totalTaxAmount: json["total_tax_amount"],
        totalTaxAssesment: json["total_tax_assesment"],
        taxPichart: List<dynamic>.from(
            json["tax_pichart"].map((x) => (x))),
        taxBarchart: Barchart.fromJson(json["tax_barchart"]),
        totalTradeLicense: json["total_trade_license"],
        totalTradeLicenseSuccess: json["total_trade_license_success"],
        completeTradeLicense: json["complete_trade_license"],
        newTradeLicense: json["new_trade_license"],
        processingTradeLicense: json["processing_trade_license"],
        cancelTradeLicense: json["cancel_trade_license"],
        tradePichart: List.from(
            json["trade_pichart"].map((x) => (x))),
        tradeBarchart: Barchart.fromJson(json["trade_barchart"]),
      );

  Map<String, dynamic> toJson() => {
        "financial_year_asc":
            List<dynamic>.from(financialYearAsc.map((x) => x.toJson())),
        "financial_year_desc":
            List<dynamic>.from(financialYearDesc.map((x) => x.toJson())),
        "total_holding": totalHolding,
        "total_tax_amount": totalTaxAmount,
        "total_tax_assesment": totalTaxAssesment,
        "tax_pichart": List<dynamic>.from(taxPichart.map((x) => x.toJson())),
        "tax_barchart": taxBarchart.toJson(),
        "total_trade_license": totalTradeLicense,
        "total_trade_license_success": totalTradeLicenseSuccess,
        "complete_trade_license": completeTradeLicense,
        "new_trade_license": newTradeLicense,
        "processing_trade_license": processingTradeLicense,
        "cancel_trade_license": cancelTradeLicense,
        "trade_pichart":
            List<dynamic>.from(tradePichart.map((x) => x.toJson())),
        "trade_barchart": tradeBarchart.toJson(),
      };
}

class FinancialYear {
  int financialYearId;
  String financialYear;
  int yearCode;
  int financialYearStatus;
  dynamic createdBy;
  dynamic updatedBy;

  FinancialYear({
    required this.financialYearId,
    required this.financialYear,
    required this.yearCode,
    required this.financialYearStatus,
    required this.createdBy,
    required this.updatedBy,
  });

  factory FinancialYear.fromJson(Map<String, dynamic> json) => FinancialYear(
        financialYearId: json["financial_year_id"],
        financialYear: json["financial_year"],
        yearCode: json["year_code"],
        financialYearStatus: json["financial_year_status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "financial_year_id": financialYearId,
        "financial_year": financialYear,
        "year_code": yearCode,
        "financial_year_status": financialYearStatus,
        "created_by": createdBy,
        "updated_by": updatedBy,
      };
}

class Barchart {
  List<String> labels;
  List<Dataset> datasets;

  Barchart({
    required this.labels,
    required this.datasets,
  });

  factory Barchart.fromJson(Map<String, dynamic> json) => Barchart(
        labels: List<String>.from(json["labels"].map((x) => x)),
        datasets: List<Dataset>.from(
            json["datasets"].map((x) => Dataset.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "datasets": List<dynamic>.from(datasets.map((x) => x.toJson())),
      };
}

class Dataset {
  String label;
  List<int> data;
  String backgroundColor;
  int maxBarThickness;

  Dataset({
    required this.label,
    required this.data,
    required this.backgroundColor,
    required this.maxBarThickness,
  });

  factory Dataset.fromJson(Map<String, dynamic> json) => Dataset(
        label: json["label"],
        data: List<int>.from(json["data"].map((x) => x)),
        backgroundColor: json["backgroundColor"],
        maxBarThickness: json["maxBarThickness"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "data": List<dynamic>.from(data.map((x) => x)),
        "backgroundColor": backgroundColor,
        "maxBarThickness": maxBarThickness,
      };
}

class TaxPichart {
  String name;
  int taxAmount;
  String backgroundColor;

  TaxPichart({
    required this.name,
    required this.taxAmount,
    required this.backgroundColor,
  });

  factory TaxPichart.fromJson(Map<String, dynamic> json) => TaxPichart(
        name: json["name"],
        taxAmount: json["tax_amount"],
        backgroundColor: json["background_color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tax_amount": taxAmount,
        "background_color": backgroundColor,
      };
}

class TradePichart {
  String name;
  int totalTradeLicense;
  String backgroundColor;

  TradePichart({
    required this.name,
    required this.totalTradeLicense,
    required this.backgroundColor,
  });

  factory TradePichart.fromJson(Map<String, dynamic> json) => TradePichart(
        name: json["name"],
        totalTradeLicense: json["total_trade_license"],
        backgroundColor: json["background_color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total_trade_license": totalTradeLicense,
        "background_color": backgroundColor,
      };
}
