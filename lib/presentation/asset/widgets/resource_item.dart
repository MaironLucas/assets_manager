import 'package:assets_manager/data/model/company_resources.dart';
import 'package:flutter/material.dart';

class ResourceItem extends StatelessWidget {
  const ResourceItem({
    this.layerPadding = _defaultLayerPadding,
    required this.resource,
    super.key,
  });

  final double layerPadding;
  final CompanyResource resource;

  static const double _defaultLayerPadding = 6;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
          left: layerPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  switch (resource) {
                    LocationResource() => 'assets/location.png',
                    AssetResource() => 'assets/asset.png',
                    ComponentResource() => 'assets/component.png',
                    CompanyResource() => '',
                  },
                  height: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  resource.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (resource is LocationResource)
              ...(resource as LocationResource).children.map(
                    (child) => ResourceItem(
                      layerPadding: layerPadding + _defaultLayerPadding,
                      resource: child,
                    ),
                  ),
            if (resource is AssetResource)
              ...(resource as AssetResource).children.map(
                    (child) => ResourceItem(
                      layerPadding: layerPadding + _defaultLayerPadding,
                      resource: child,
                    ),
                  ),
          ],
        ),
      );
}
