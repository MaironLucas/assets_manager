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

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc({
    required MyRepository repository,
    required String companyId,
  })  : _repository = repository,
        _companyId = companyId,
        super(Loading()) {
    on<GetResources>(_onGetResources);
    on<ToggleExpand>(_onToggleExpand);
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
      _filteredResources = List.of(resources);
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
}
