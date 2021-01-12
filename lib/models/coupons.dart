class Coupons {
  int id;
  String code;
  String amount;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String discountType;
  String description;
  int usageCount;
  bool individualUse;
  List<int> productIds;
  int usageLimit;
  bool freeShipping;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;

  Coupons(
      {this.id,
      this.code,
      this.amount,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.discountType,
      this.description,
      this.usageCount,
      this.individualUse,
      this.productIds,
      this.usageLimit,
      this.freeShipping,
      this.excludeSaleItems,
      this.minimumAmount,
      this.maximumAmount});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountType = json['discount_type'];
    description = json['description'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    productIds = json['product_ids'].cast<int>();
    usageLimit = json['usage_limit'];
    freeShipping = json['free_shipping'];
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['discount_type'] = this.discountType;
    data['description'] = this.description;
    data['usage_count'] = this.usageCount;
    data['individual_use'] = this.individualUse;
    data['product_ids'] = this.productIds;
    data['usage_limit'] = this.usageLimit;
    data['free_shipping'] = this.freeShipping;
    data['exclude_sale_items'] = this.excludeSaleItems;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    return data;
  }
}
