import 'dart:convert';

class OrdersSummery {
  OrdersSummery({
    this.wcPending,
    this.wcCompleted,
    this.wcOnHold,
    this.wcProcessing,
    this.wcRefunded,
    this.wcCancelled,
    this.wcFailed,
    this.total,
  });

  int wcPending;
  int wcCompleted;
  int wcOnHold;
  int wcProcessing;
  int wcRefunded;
  int wcCancelled;
  int wcFailed;
  int total;

  factory OrdersSummery.fromRawJson(String str) => OrdersSummery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdersSummery.fromJson(Map<String, dynamic> json) => OrdersSummery(
    wcPending: json["wc-pending"],
    wcCompleted: json["wc-completed"],
    wcOnHold: json["wc-on-hold"],
    wcProcessing: json["wc-processing"],
    wcRefunded: json["wc-refunded"],
    wcCancelled: json["wc-cancelled"],
    wcFailed: json["wc-failed"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "wc-pending": wcPending,
    "wc-completed": wcCompleted,
    "wc-on-hold": wcOnHold,
    "wc-processing": wcProcessing,
    "wc-refunded": wcRefunded,
    "wc-cancelled": wcCancelled,
    "wc-failed": wcFailed,
    "total": total,
  };
}
