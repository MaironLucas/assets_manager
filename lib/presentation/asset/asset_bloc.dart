import 'package:assets_manager/data/model/company_resources.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FilterType { energy, critical, none }

sealed class AssetState {}

class Loading extends AssetState {}

class Success extends AssetState {
  Success(this.resources, this.expandedResources, this.currentFilter);

  final List<CompanyResource> resources;
  final List<String> expandedResources;
  final FilterType? currentFilter;
}

class Error extends AssetState {}

sealed class AssetEvent {}

class GetResources extends AssetEvent {}

class ToggleExpand extends AssetEvent {
  ToggleExpand(this.resourceId, this.isExpanded);

  final String resourceId;
  final bool isExpanded;
}

class Filter extends AssetEvent {
  Filter({
    required this.searchTerm,
    this.newFilter,
  });

  final String searchTerm;
  final FilterType? newFilter;
}

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc({
    required MyRepository repository,
    required String companyId,
  })  : _repository = repository,
        _companyId = companyId,
        super(Loading()) {
    on<GetResources>(_onGetResources);
    on<ToggleExpand>(_onToggleExpand);
    on<Filter>(_filter);
  }

  final MyRepository _repository;
  final String _companyId;
  List<CompanyResource> _allResources = [];
  List<CompanyResource> _filteredResources = [];
  final List<String> _expandedResources = [];
  FilterType? _currentFilter;

  Future<void> _onGetResources(
    GetResources event,
    Emitter<AssetState> emit,
  ) async {
    emit(Loading());
    try {
      final resources = await _repository.getAssetsTree(_companyId);
      _allResources = resources;
      _filteredResources = List.from(resources);
      emit(Success(_filteredResources, _expandedResources, _currentFilter));
    } catch (_) {
      emit(Error());
    }
  }

  Future<void> _onToggleExpand(
    ToggleExpand event,
    Emitter<AssetState> emit,
  ) async {
    if (event.isExpanded) {
      _expandedResources.add(event.resourceId);
    } else {
      _expandedResources.remove(event.resourceId);
    }
    emit(Success(_filteredResources, _expandedResources, _currentFilter));
  }

  Future<void> _filter(
    Filter event,
    Emitter<AssetState> emit,
  ) async {
    final searchTerm = event.searchTerm.toLowerCase();
    _filteredResources = List.from(_allResources);
    _currentFilter = event.newFilter == FilterType.none
        ? null
        : event.newFilter ?? _currentFilter;
    emit(Loading());
    if (event.searchTerm.isNotEmpty || _currentFilter != null) {
      final resourcesToRemove = <String>[];
      // Iterate over the resources to check if they match the search term or
      // the current filter. If they don't, we add them to the resourcesToRemove
      for (final resource in _filteredResources) {
        // If the resource is a ComponentResource on root, we check if it
        // matches the search term and the current filter.
        if (resource is ComponentResource) {
          final matchFilter = switch (_currentFilter) {
            FilterType.energy => resource.isEnergySensor,
            FilterType.critical => resource.hasCriticalStatus,
            _ => true,
          };
          if (((resource.name.toLowerCase().contains(searchTerm) &&
                      searchTerm.isNotEmpty) ||
                  searchTerm.isEmpty) &&
              matchFilter) {
            continue;
          } else {
            resourcesToRemove.add(resource.id);
          }
        } else {
          final multiChildResource = resource as MultiChildResource;
          // If the resource is a MultiChildResource on root, we iterate over
          // his children to check if they match the search term or the current
          // filter. If they don't, we add the resource to the resourcesToRemove.
          if (multiChildResource.name.toLowerCase().contains(searchTerm) &&
              searchTerm.isNotEmpty &&
              _currentFilter == null) {
            continue;
          } else {
            final childrenToRemove = <String>[];
            for (final child in multiChildResource.children) {
              final shouldKeepChild = iterateOnTree(searchTerm, child);
              if (!shouldKeepChild) {
                childrenToRemove.add(child.id);
              }
            }
            if (childrenToRemove.length == multiChildResource.children.length) {
              resourcesToRemove.add(multiChildResource.id);
            } else {
              multiChildResource.children.removeWhere(
                (child) => childrenToRemove.contains(child.id),
              );
            }
          }
        }
      }
      _filteredResources.removeWhere(
        (resource) => resourcesToRemove.contains(resource.id),
      );
    }
    emit(Success(_filteredResources, _expandedResources, _currentFilter));
  }

  bool iterateOnTree(String searchTerm, CompanyResource currentNode) {
    if (currentNode is ComponentResource) {
      final matchFilter = switch (_currentFilter) {
        FilterType.energy => currentNode.isEnergySensor,
        FilterType.critical => currentNode.hasCriticalStatus,
        _ => true,
      };
      if (((currentNode.name.toLowerCase().contains(searchTerm) &&
          searchTerm.isNotEmpty) ||
          searchTerm.isEmpty) &&
          matchFilter) {
        return true;
      } else {
        return false;
      }
    }
    final multiChildResource = currentNode as MultiChildResource;
    if (multiChildResource.name.toLowerCase().contains(searchTerm) &&
        searchTerm.isNotEmpty &&
        _currentFilter == null) {
      return true;
    }
    // children that has not a child that matches the search term or current
    // filter will be removed by this list.
    final childrenToRemove = <String>[];
    // Iterate over the children of the current node to check what child to
    // keep.
    for (final child in multiChildResource.children) {
      final shouldKeepChild = iterateOnTree(searchTerm, child);
      if (!shouldKeepChild) {
        childrenToRemove.add(child.id);
      }
    }
    if (childrenToRemove.length == multiChildResource.children.length) {
      return false;
    } else {
      multiChildResource.children.removeWhere(
        (child) => childrenToRemove.contains(child.id),
      );
      return true;
    }
  }
}
