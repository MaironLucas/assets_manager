import 'package:assets_manager/data/model/company_resources.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AssetState {}

class Loading extends AssetState {}

class Success extends AssetState {
  Success(this.resources);

  final List<CompanyResource> resources;
}

class Error extends AssetState {}

sealed class AssetEvent {}

class GetResources extends AssetEvent {}

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  AssetBloc({
    required MyRepository repository,
    required String companyId,
  })  : _repository = repository,
        _companyId = companyId,
        super(Loading()) {
    on<GetResources>(_onGetResources);
  }

  final MyRepository _repository;
  final String _companyId;

  Future<void> _onGetResources(
    GetResources event,
    Emitter<AssetState> emit,
  ) async {
    emit(Loading());
    try {
      final resources = await _repository.getAssetsTree(_companyId);
      emit(Success(resources));
    } catch (_) {
      emit(Error());
    }
  }
}
