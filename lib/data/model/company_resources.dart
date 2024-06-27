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
    required this.isEnergySensor,
    required this.hasCriticalStatus,
  });

  final bool isEnergySensor;
  final bool hasCriticalStatus;

  factory ComponentResource.fromJson(Map<String, dynamic> json) =>
      ComponentResource(
        id: json['id'],
        name: json['name'],
        isEnergySensor: json['sensorType'] == 'energy',
        hasCriticalStatus: json['status'] == 'alert',
      );
}
