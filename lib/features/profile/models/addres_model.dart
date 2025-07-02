class AddressModel {
  final String id;
  final String home;
  final String details;
  final String phone;
  final String city;

  AddressModel({
    required this.id,
    required this.home,
    required this.details,
    required this.phone,
    required this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      home: json['home'],
      details: json['details'],
      phone: json['phone'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'home': home,
      'details': details,
      'phone': phone,
      'city': city,
    };
  }
}
