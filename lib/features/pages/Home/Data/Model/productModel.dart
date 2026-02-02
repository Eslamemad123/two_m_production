class ProductModel {
  final String id;
  final String? code;
  final String name;
  final String? subName;
  final String description;
  final String section;
  final String? injectionMolding;
  final int? size;
  final int stock;
  final int price;
  final String? state;
  final String? note;
  final List<dynamic>? imagePath;
  final DateTime? date;

  const ProductModel({
    required this.id,
    this.code,
    required this.name,
    this.subName,
    required this.description,
    required this.section,
    this.injectionMolding,
    required this.size,
    required this.stock,
    required this.price,
    this.state,
    this.note,
    this.imagePath,
    this.date,
  });

  /// From API / Firebase
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      subName: json['subName'],
      description: json['description'],
      section: json['section'],
      injectionMolding: json['injectionMolding'] ?? false,
      size: json['size'],
      stock: json['stock'] ?? 0,
      price: (json['price'] as num).toInt(),
      state: json['state'],
      note: json['note'],
      imagePath: json['imagePath'],
      date: DateTime.parse(json['date']),
    );
  }

  /// To API / Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'subName': subName,
      'description': description,
      'section': section,
      'injectionMolding': injectionMolding,
      'size': size,
      'stock': stock,
      'price': price,
      'state': state,
      'note': note,
      'imagePath': imagePath,
      if (date != null) 'date': date!.toIso8601String(),
    };
  }
}
