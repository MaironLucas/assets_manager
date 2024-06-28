import 'dart:collection';

import 'package:assets_manager/data/model/company.dart';
import 'package:assets_manager/data/model/company_resources.dart';
import 'package:assets_manager/data/remote/my_rds.dart';

class MyRepository {
  MyRepository({
    required MyRDS myRDS,
  }) : _myRDS = myRDS;

  final MyRDS _myRDS;

  Future<List<Company>> getCompanies() => _myRDS.getCompanies().then(
        (companiesList) => companiesList
            .map(
              (company) => Company.fromJson(company as Map<String, dynamic>),
            )
            .toList(),
      );

  Future<(List<CompanyResource>, SplayTreeMap<String, MultiChildResource>)>
      getLocations(
    String companyId,
  ) =>
          _myRDS.getLocations(companyId).then(
            (locations) {
              final locationsMap = locations
                  .map((location) => location as Map<String, dynamic>)
                  .toList();
              final locationsLookupMap =
                  SplayTreeMap<String, MultiChildResource>();
              final locationsTree = <CompanyResource>[];

              while (locationsMap.isNotEmpty) {
                final insertedLocations = <String>[];
                for (var location in locationsMap) {
                  if (location['parentId'] == null) {
                    final locationNode = MultiChildResource.fromJson(
                      location,
                      MultiChildResourceType.location,
                    );
                    locationsTree.add(
                      locationNode,
                    );
                    locationsLookupMap[locationNode.id] = locationNode;
                    insertedLocations.add(location['id'] as String);
                  } else {
                    var currentIndex = 0;
                    var hasInserted = false;
                    while (
                        currentIndex < locationsTree.length && !hasInserted) {
                      hasInserted = addToLocationTree(
                        location,
                        locationsTree[currentIndex] as MultiChildResource,
                        locationsLookupMap,
                      );
                      currentIndex++;
                    }
                    if (hasInserted) {
                      insertedLocations.add(location['id'] as String);
                    }
                  }
                }
                locationsMap.removeWhere(
                  (location) => insertedLocations.contains(
                    location['id'],
                  ),
                );
              }

              return (locationsTree, locationsLookupMap);
            },
          );

  bool addToLocationTree(
    Map<String, dynamic> locationToAdd,
    MultiChildResource currentLocationNode,
    SplayTreeMap<String, MultiChildResource> locationLookupMap,
  ) {
    if (currentLocationNode.id == locationToAdd['parentId']) {
      final locationNode = MultiChildResource.fromJson(
        locationToAdd,
        MultiChildResourceType.location,
      );
      currentLocationNode.children.add(
        locationNode,
      );
      locationLookupMap[locationNode.id] = locationNode;
      return true;
    } else {
      for (var child in currentLocationNode.children) {
        if (addToLocationTree(
            locationToAdd, child as MultiChildResource, locationLookupMap)) {
          return true;
        }
      }
      return false;
    }
  }

  Future<List<CompanyResource>> getAssetsTree(String companyId) =>
      getLocations(companyId).then(
        (record) => _myRDS.getAssets(companyId).then(
          (assets) {
            final (locationsTree, multiChildLookupMap) = record;
            final assetsMap = assets
                .map((location) => location as Map<String, dynamic>)
                .toList();

            assetsMap.sort((a, b) => a['sensorType'] == null ? -1 : 1);

            for (var asset in assetsMap) {
              if (asset['parentId'] == null && asset['locationId'] == null) {
                try {
                  locationsTree.add(
                    ComponentResource.fromJson(asset),
                  );
                } catch (_) {
                  // Empty catch cause in some cases the asset doesn't have a
                  // sensorType neither parentId or locationId.
                }
              } else if ((asset['parentId'] != null ||
                      asset['locationId'] != null) &&
                  asset['sensorType'] != null) {
                final parent = asset['parentId'] != null
                    ? multiChildLookupMap[asset['parentId']]
                    : multiChildLookupMap[asset['locationId']];
                if (parent != null) {
                  parent.children.add(
                    ComponentResource.fromJson(asset),
                  );
                }
              } else {
                final parent = asset['parentId'] != null
                    ? multiChildLookupMap[asset['parentId']]
                    : multiChildLookupMap[asset['locationId']];
                if (parent != null) {
                  final assetNode = MultiChildResource.fromJson(
                    asset,
                    MultiChildResourceType.asset,
                  );
                  parent.children.add(
                    assetNode,
                  );
                  multiChildLookupMap[assetNode.id] = assetNode;
                }
              }
            }
            return locationsTree;
          },
        ),
      );
}
