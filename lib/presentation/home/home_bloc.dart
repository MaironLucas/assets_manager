import 'package:assets_manager/data/exceptions.dart';
import 'package:assets_manager/data/model/company.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:bloc/bloc.dart';

sealed class HomeState {}

class Loading extends HomeState {}

class Success extends HomeState {
  Success(this.companies);

  final List<Company> companies;
}

class Error extends HomeState {
  Error(this.exception);

  final MyException exception;
}

sealed class HomeEvent {}

class GetCompanies extends HomeEvent {}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required MyRepository repository,
  })  : _repository = repository,
        super(Loading()) {
    on<GetCompanies>(_onGetCompanies);
  }

  final MyRepository _repository;

  Future<void> _onGetCompanies(
      GetCompanies event, Emitter<HomeState> emit) async {
    emit(Loading());
    try {
      final companies = await _repository.getCompanies();
      emit(Success(companies));
    } catch (exception) {
      emit(Error(exception is MyException ? exception : GenericException()));
    }
  }
}
