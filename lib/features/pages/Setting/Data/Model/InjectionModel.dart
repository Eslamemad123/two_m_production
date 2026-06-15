class InjectionModel {
  final String id;
  final String product;
  final String startDate;
  final String? endDate;
  final String state;
  final String totalCount;
  final int numberInjection;

  InjectionModel({
    required this.id,
    required this.product,
    required this.startDate,
     this.endDate,
    required this.state,
    required this.totalCount,
    required this.numberInjection,
  });

  factory InjectionModel.fromJson(Map<String, dynamic> json) {
    return InjectionModel(
      id: json['id'],
      product: json['product'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      state: json['state'],
      totalCount: json['totalCount'],
      numberInjection: json['numberInjection'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'startDate': startDate,
      'endDate': endDate,
      'state': state,
      'totalCount': totalCount,
      'numberInjection': numberInjection,
    };
  }
}
