import 'package:assets_manager/common/routing/route_paths.dart';
import 'package:assets_manager/common/util.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:assets_manager/generated/l10n.dart';
import 'package:assets_manager/presentation/common/error_page.dart';
import 'package:assets_manager/presentation/common/my_app_bar.dart';
import 'package:assets_manager/presentation/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(
          title: S.of(context).appName,
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
                          child: InkWell(
                            onTap: () => GoRouter.of(context).go(
                              '${RoutePaths.assetPath}?${RoutePaths.companyIdParam}=${company.id}',
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.colorScheme.primary,
                                boxShadow: kElevationToShadow[1],
                              ),
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                company.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: context.colorScheme.onPrimary,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              Error() => ErrorPage(
                  exception: state.exception,
                  onRetry: () => context.read<HomeBloc>().add(
                        GetCompanies(),
                      ),
                ),
            },
          ),
        ),
      );
}
