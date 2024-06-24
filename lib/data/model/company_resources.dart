abstract class CompanyResource {
  CompanyResource({
    required this.name,
    required this.id,
  });

  final String id;
  final String name;
}

class LocationResource extends CompanyResource {
  LocationResource({
    required super.id,
    required super.name,
    required this.children,
  });

  List<CompanyResource> children;

  factory LocationResource.fromJson(Map<String, dynamic> json) =>
      LocationResource(
        id: json['id'],
        name: json['name'],
        children: [],
      );
}

class AssetResource extends CompanyResource {
  AssetResource({
    required super.id,
    required super.name,
    required this.children,
  });

  final List<CompanyResource> children;

  factory AssetResource.fromJson(Map<String, dynamic> json) => AssetResource(
        id: json['id'],
        name: json['name'],
        children: [],
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
