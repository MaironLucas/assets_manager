import 'package:assets_manager/data/model/company_resources.dart';
import 'package:flutter/material.dart';

class ResourceItem extends StatelessWidget {
  const ResourceItem({
    this.layerPadding = _defaultLayerPadding,
    required this.resource,
    required this.onExpandPressed,
    required this.expandedResources,
    super.key,
  });

  final double layerPadding;
  final CompanyResource resource;
  final List<String> expandedResources;
  final void Function(String id, bool isExpanded) onExpandPressed;

  static const double _defaultLayerPadding = 6;

  @override
  Widget build(BuildContext context) {
    final isExpanded = expandedResources.contains(resource.id);
    return Container(
      padding: EdgeInsets.only(
        left: layerPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => onExpandPressed(resource.id, isExpanded),
            child: Row(
              children: [
                if (resource is MultiChildResource &&
                    (resource as MultiChildResource).children.isNotEmpty)
                  Transform.rotate(
                    angle: isExpanded ? 3.14 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 8,
                    ),
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
                const SizedBox(
                  width: 4,
                ),
                if (resource is ComponentResource &&
                    (resource as ComponentResource).isEnergySensor)
                  const Icon(
                    Icons.bolt,
                    color: Colors.green,
                    size: 12,
                  ),
                if (resource is ComponentResource &&
                    (resource as ComponentResource).hasCriticalStatus)
                  const Icon(
                    Icons.warning,
                    size: 12,
                    color: Colors.red,
                  )
              ],
            ),
          ),
          if (resource is MultiChildResource && isExpanded)
            ...(resource as MultiChildResource).children.map(
                  (child) => ResourceItem(
                    layerPadding: layerPadding + _defaultLayerPadding,
                    resource: child,
                    onExpandPressed: onExpandPressed,
                    expandedResources: expandedResources,
                  ),
                ),
        ],
      ),
    );
  }
}
