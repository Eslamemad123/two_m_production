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
  final String? date;

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
      date: json['date'],
    );
  }
  ProductModel copyWith({
    String? id,
    String? code,
    String? name,
    String? subName,
    String? description,
    String? section,
    String? injectionMolding,
    int? size,
    int? stock,
    int? price,
    String? state,
    String? note,
    List<dynamic>? imagePath,
    String? date,
  }) {
    return ProductModel(
      name: name ?? this.name,
      price: price ?? this.price,
      id: id ?? this.id,
      code: code ?? this.code,
      date: date ?? this.date,
      subName: subName ?? this.subName,
      description: description ?? this.description,
      section: section ?? this.section,
      injectionMolding: injectionMolding ?? this.injectionMolding,
      stock: stock ?? this.stock,
      size: size ?? this.size,
      state: state ?? this.state,
      note: note ?? this.note,
      imagePath: imagePath ?? this.imagePath,
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
      'date': date,
      // if (date != null) 'date': date!.toIso8601String(),
    };
  }
}
