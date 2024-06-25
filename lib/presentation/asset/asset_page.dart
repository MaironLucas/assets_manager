import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:assets_manager/generated/l10n.dart';
import 'package:assets_manager/presentation/asset/asset_bloc.dart';
import 'package:assets_manager/presentation/asset/widgets/resource_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({
    required this.companyId,
    super.key,
  });

  final String companyId;

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).assetsPageTitle),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: BlocProvider(
          create: (_) => AssetBloc(
            repository: GetIt.instance.get<MyRepository>(),
            companyId: widget.companyId,
          )..add(
              GetResources(),
            ),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<AssetBloc, AssetState>(
                  builder: (context, state) => switch (state) {
                    Loading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    Success() => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: state.resources.map(
                            (resource) => ResourceItem(
                                resource: resource,
                                expandedResources: state.expandedResources,
                                onExpandPressed: (String id, bool isExpanded) {
                                  context.read<AssetBloc>().add(
                                          ToggleExpand(
                                            id,
                                            !isExpanded,
                                          ),
                                        );
                                },
                              ),
                          ).toList(),
                        ),
                      ),
                    Error() => Center(
                        child: InkWell(
                          onTap: () => context.read<AssetBloc>().add(
                                GetResources(),
                              ),
                          child: Text(
                            S.of(context).errorTryAgainButton,
                          ),
                        ),
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
