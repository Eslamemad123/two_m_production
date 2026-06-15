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
  final List<String>? imagePath;
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      code: json['code'],
      name: json['name'] ?? '',
      subName: json['subName'],
      description: json['description'] ?? '',
      section: json['section'] ?? '',
      injectionMolding: json['injectionMolding'],
      size: json['size'],
      stock: json['stock'] ?? 0,
      price: (json['price'] as num?)?.toInt() ?? 0,
      state: json['state'],
      note: json['note'],
      imagePath: (json['imagePath'] as List?)
          ?.map((e) => e.toString())
          .toList(),
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
    List<String>? imagePath,
    String? date,
  }) {
    return ProductModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      subName: subName ?? this.subName,
      description: description ?? this.description,
      section: section ?? this.section,
      injectionMolding: injectionMolding ?? this.injectionMolding,
      size: size ?? this.size,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      state: state ?? this.state,
      note: note ?? this.note,
      imagePath: imagePath ?? this.imagePath,
      date: date ?? this.date,
    );
  }

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
    };
  }
}
