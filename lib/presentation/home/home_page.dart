import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:assets_manager/presentation/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Tractian'),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (_) => HomeBloc(
            repository: GetIt.instance.get<MyRepository>(),
          )..add(
              GetCompanies(),
            ),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => switch (state) {
              Loading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              Success() => Column(
                  children: state.companies
                      .map(
                        (company) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Container(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              company.name,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              Error() => Center(
                  child: InkWell(
                    onTap: () => context.read<HomeBloc>().add(
                          GetCompanies(),
                        ),
                    child: const Text(
                      'Try again',
                    ),
                  ),
                ),
            },
          ),
        ),
      );
}
