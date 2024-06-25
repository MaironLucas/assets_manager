import 'package:assets_manager/data/model/company_resources.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AssetState {}

class Loading extends AssetState {}

class Success extends AssetState {
  Success(this.resources, this.expandedResources);

  final List<CompanyResource> resources;
  final List<String> expandedResources;
}

class Error extends AssetState {}

sealed class AssetEvent {}

class GetResources extends AssetEvent {}

class ToggleExpand extends AssetEvent {
  ToggleExpand(this.resourceId, this.isExpanded);

  final String resourceId;
  final bool isExpanded;
}

class Search extends AssetEvent {
  Search(this.searchTerm);

  final String searchTerm;
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
    on<Search>(_search);
  }

  final MyRepository _repository;
  final String _companyId;
  List<CompanyResource> _allResources = [];
  List<CompanyResource> _filteredResources = [];
  final List<String> _expandedResources = [];

  Future<void> _onGetResources(
    GetResources event,
    Emitter<AssetState> emit,
  ) async {
    emit(Loading());
    try {
      final resources = await _repository.getAssetsTree(_companyId);
      _allResources = resources;
      _filteredResources = List.from(resources);
      emit(Success(_filteredResources, _expandedResources));
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
    emit(Success(_filteredResources, _expandedResources));
  }

  Future<void> _search(
    Search event,
    Emitter<AssetState> emit,
  ) async {
    final searchTerm = event.searchTerm.toLowerCase();
    _filteredResources = List.from(_allResources);
    emit(Loading());
    if (event.searchTerm.isNotEmpty) {
      final resourcesToRemove = <String>[];
      for (final resource in _filteredResources) {
        if (resource is ComponentResource) {
          if (!resource.name.toLowerCase().contains(searchTerm)) {
            resourcesToRemove.add(resource.id);
          }
        } else {
          final multiChildResource = resource as MultiChildResource;
          if (!multiChildResource.name.toLowerCase().contains(searchTerm)) {
            var shouldKeepResource = false;
            final childrenToRemove = <String>[];
            for (final child in multiChildResource.children) {
              if (!child.name.toLowerCase().contains(searchTerm)) {
                final shouldKeep = iterateOnTree(searchTerm, child);
                if (!shouldKeep) {
                  childrenToRemove.add(child.id);
                } else {
                  shouldKeepResource = true;
                }
              } else {
                shouldKeepResource = true;
              }
            }
            if (!shouldKeepResource) {
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
    emit(Success(_filteredResources, _expandedResources));
  }

  bool iterateOnTree(String searchTerm, CompanyResource currentNode) {
    if (currentNode is ComponentResource) {
      return false;
    }
    final multiChildResource = currentNode as MultiChildResource;
    var hasANodeToKeep = false;
    final childrenToRemove = <String>[];
    for (final child in multiChildResource.children) {
      if (child.name.toLowerCase().contains(searchTerm)) {
        hasANodeToKeep = true;
      } else {
        final shouldKeep = iterateOnTree(searchTerm, child);
        if (!shouldKeep) {
          childrenToRemove.add(child.id);
        } else {
          hasANodeToKeep = true;
        }
      }
    }
    multiChildResource.children.removeWhere(
      (child) => childrenToRemove.contains(child.id),
    );
    return hasANodeToKeep;
  }
}
