abstract class CompanyResource {
  CompanyResource({
    required this.name,
    required this.id,
  });

  final String id;
  final String name;
}

enum MultiChildResourceType {
  location,
  asset,
}

class MultiChildResource extends CompanyResource {
  MultiChildResource({
    required super.id,
    required super.name,
    required this.type,
    required this.children,
  });

  List<CompanyResource> children;
  final MultiChildResourceType type;

  factory MultiChildResource.fromJson(Map<String, dynamic> json, MultiChildResourceType type) =>
      MultiChildResource(
        id: json['id'],
        name: json['name'],
        children: [],
        type: type,
      );
}

class ComponentResource extends CompanyResource {
  ComponentResource({
    required super.id,
    required super.name,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
  });

  final String sensorId;
  final String sensorType;
  final String status;
  final String gatewayId;

  factory ComponentResource.fromJson(Map<String, dynamic> json) =>
      ComponentResource(
        id: json['id'],
        name: json['name'],
        sensorId: json['sensorId'],
        sensorType: json['sensorType'],
        status: json['status'],
        gatewayId: json['gatewayId'],
      );
}
