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

  Future<List<CompanyResource>> getLocations(String companyId) =>
      _myRDS.getLocations(companyId).then(
        (locations) {
          final locationsMap = locations
              .map((location) => location as Map<String, dynamic>)
              .toList();
          final locationsTree = <CompanyResource>[];

          while (locationsMap.isNotEmpty) {
            final insertedLocations = <String>[];
            for (var location in locationsMap) {
              if (location['parentId'] == null) {
                locationsTree.add(
                  MultiChildResource.fromJson(
                      location, MultiChildResourceType.location),
                );
                insertedLocations.add(location['id'] as String);
              } else {
                var currentIndex = 0;
                var hasInserted = false;
                while (currentIndex < locationsTree.length && !hasInserted) {
                  hasInserted = addToLocationTree(
                    location,
                    locationsTree[currentIndex] as MultiChildResource,
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

          return locationsTree;
        },
      );

  bool addToLocationTree(
    Map<String, dynamic> locationToAdd,
    MultiChildResource currentLocationNode,
  ) {
    if (currentLocationNode.id == locationToAdd['parentId']) {
      currentLocationNode.children.add(
        MultiChildResource.fromJson(
            locationToAdd, MultiChildResourceType.location),
      );
      return true;
    } else {
      for (var child in currentLocationNode.children) {
        if (addToLocationTree(locationToAdd, child as MultiChildResource)) {
          return true;
        }
      }
      return false;
    }
  }

  Future<List<CompanyResource>> getAssetsTree(String companyId) =>
      getLocations(companyId).then(
        (locationsTree) => _myRDS.getAssets(companyId).then(
          (assets) {
            final assetsMap = assets
                .map((location) => location as Map<String, dynamic>)
                .toList();

            while (assetsMap.isNotEmpty) {
              final insertedAssets = <String>[];
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
                  insertedAssets.add(asset['id'] as String);
                } else {
                  var currentIndex = 0;
                  var hasInserted = false;
                  while (currentIndex < locationsTree.length && !hasInserted) {
                    hasInserted = addAssetToTree(
                      asset,
                      locationsTree[currentIndex],
                    );
                    currentIndex++;
                  }
                  if (hasInserted) {
                    insertedAssets.add(asset['id'] as String);
                  }
                }
              }
              assetsMap.removeWhere(
                (location) => insertedAssets.contains(
                  location['id'],
                ),
              );
            }

            return locationsTree;
          },
        ),
      );

  bool addAssetToTree(
    Map<String, dynamic> assetToAdd,
    CompanyResource currentResourceNode,
  ) {
    if ((currentResourceNode.id == assetToAdd['parentId'] ||
            currentResourceNode.id == assetToAdd['locationId']) &&
        assetToAdd['sensorType'] != null) {
      (currentResourceNode as MultiChildResource).children.add(
            ComponentResource.fromJson(assetToAdd),
          );
      return true;
    }
    if ((assetToAdd['locationId'] == currentResourceNode.id ||
            assetToAdd['parentId'] == currentResourceNode.id) &&
        assetToAdd['sensorId'] == null) {
      (currentResourceNode as MultiChildResource).children.add(
            MultiChildResource.fromJson(
                assetToAdd, MultiChildResourceType.asset),
          );
      return true;
    }
    if (currentResourceNode is MultiChildResource) {
      for (var child in currentResourceNode.children) {
        if (addAssetToTree(assetToAdd, child)) {
          return true;
        }
      }
    }
    return false;
  }
}
