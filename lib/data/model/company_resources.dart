sealed class CompanyResource {}

class LocationResource extends CompanyResource {
  LocationResource({
    required this.id,
    required this.name,
    required this.children,
  });

  final String id;
  final String name;
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
    required this.id,
    required this.name,
    required this.children,
  });

  final String id;
  final String name;
  final List<CompanyResource> children;

  factory AssetResource.fromJson(Map<String, dynamic> json) => AssetResource(
        id: json['id'],
        name: json['name'],
        children: [],
      );
}

class ComponentResource extends CompanyResource {
  ComponentResource({
    required this.id,
    required this.name,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
  });

  final String id;
  final String name;
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
