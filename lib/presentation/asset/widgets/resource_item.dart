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
                if (resource is MultiChildResource &&
                    (resource as MultiChildResource).children.isNotEmpty)
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 8,
                  )
                else
                  const SizedBox(width: 8),
                const SizedBox(
                  width: 4,
                ),
                Image.asset(
                  switch (resource) {
                    MultiChildResource() =>
                      (resource as MultiChildResource).type ==
                              MultiChildResourceType.location
                          ? 'assets/location.png'
                          : 'assets/asset.png',
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
            if (resource is MultiChildResource)
              ...(resource as MultiChildResource).children.map(
                    (child) => ResourceItem(
                      layerPadding: layerPadding + _defaultLayerPadding,
                      resource: child,
                    ),
                  ),
          ],
        ),
      );
}
