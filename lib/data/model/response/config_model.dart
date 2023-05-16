class ConfigModel {
  AppSetting? appSetting;
  TermCondition? termCondition;
  AppPolicy? appPolicy;
  TermCondition? aboutUs;
  Company? company;

  ConfigModel(
      {this.appSetting,
        this.termCondition,
        this.appPolicy,
        this.aboutUs,
        this.company});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    appSetting = json['app_setting'] != null
        ? new AppSetting.fromJson(json['app_setting'])
        : null;
    termCondition = json['term_condition'] != null
        ? new TermCondition.fromJson(json['term_condition'])
        : null;
    appPolicy = json['app_policy'] != null
        ? new AppPolicy.fromJson(json['app_policy'])
        : null;
    aboutUs = json['about_us'] != null
        ? new TermCondition.fromJson(json['about_us'])
        : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appSetting != null) {
      data['app_setting'] = this.appSetting!.toJson();
    }
    if (this.termCondition != null) {
      data['term_condition'] = this.termCondition!.toJson();
    }
    if (this.appPolicy != null) {
      data['app_policy'] = this.appPolicy!.toJson();
    }
    if (this.aboutUs != null) {
      data['about_us'] = this.aboutUs!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class AppSetting {
  int? id;
  String? appName;
  String? version;
  String? androidUrl;
  String? iosUrl;
  Null? createdAt;
  String? updatedAt;

  AppSetting(
      {this.id,
        this.appName,
        this.version,
        this.androidUrl,
        this.iosUrl,
        this.createdAt,
        this.updatedAt});

  AppSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    version = json['version'];
    androidUrl = json['android_url'];
    iosUrl = json['ios_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['version'] = this.version;
    data['android_url'] = this.androidUrl;
    data['ios_url'] = this.iosUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TermCondition {
  int? id;
  String? title;
  String? contentType;
  String? description;
  String? status;
  Null? createdAt;
  Null? updatedAt;

  TermCondition(
      {this.id,
        this.title,
        this.contentType,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  TermCondition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    contentType = json['content_type'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content_type'] = this.contentType;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AppPolicy {
  int? id;
  String? title;
  String? contentType;
  String? description;
  String? status;
  Null? createdAt;
  String? updatedAt;

  AppPolicy(
      {this.id,
        this.title,
        this.contentType,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  AppPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    contentType = json['content_type'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content_type'] = this.contentType;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? companyOwner;
  String? address;
  String? email;
  String? phone;
  String? websiteUrl;
  String? status;
  String? logo;
  int? sunday;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;
  Null? createdAt;
  String? updatedAt;

  Company(
      {this.id,
        this.companyName,
        this.companyOwner,
        this.address,
        this.email,
        this.phone,
        this.websiteUrl,
        this.status,
        this.logo,
        this.sunday,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.createdAt,
        this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyOwner = json['company_owner'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    websiteUrl = json['website_url'];
    status = json['status'];
    logo = json['logo'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
    saturday = json['saturday'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['company_owner'] = this.companyOwner;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['website_url'] = this.websiteUrl;
    data['status'] = this.status;
    data['logo'] = this.logo;
    data['sunday'] = this.sunday;
    data['monday'] = this.monday;
    data['tuesday'] = this.tuesday;
    data['wednesday'] = this.wednesday;
    data['thursday'] = this.thursday;
    data['friday'] = this.friday;
    data['saturday'] = this.saturday;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}