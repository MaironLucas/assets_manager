class Company {
  Company({required this.name, required this.id,});

  final String name;
  final String id;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      id: json['id'],
    );
  }
}