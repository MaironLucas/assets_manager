import 'package:assets_manager/common/util.dart';
import 'package:assets_manager/data/repository/my_repository.dart';
import 'package:assets_manager/generated/l10n.dart';
import 'package:assets_manager/presentation/asset/asset_bloc.dart';
import 'package:assets_manager/presentation/asset/widgets/filter_button.dart';
import 'package:assets_manager/presentation/asset/widgets/my_text_field.dart';
import 'package:assets_manager/presentation/asset/widgets/resource_item.dart';
import 'package:assets_manager/presentation/common/my_app_bar.dart';
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
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(
          title: S.of(context).assetsPageTitle,
        ),
        body: BlocProvider(
          create: (_) => AssetBloc(
            repository: GetIt.instance.get<MyRepository>(),
            companyId: widget.companyId,
          )..add(
              GetResources(),
            ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Builder(builder: (context) {
                    return MyTextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onSubmitted: (searchTerm) =>
                          context.read<AssetBloc>().add(
                                Filter(
                                  searchTerm: searchTerm,
                                ),
                              ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 8,
                  ),
                  child: BlocBuilder<AssetBloc, AssetState>(
                    builder: (context, state) => state is Success
                        ? Row(
                            children: [
                              FilterButton(
                                isEnabled:
                                    state.currentFilter == FilterType.energy,
                                text: S.of(context).energyFilter,
                                icon: Icons.bolt,
                                onPressed: () {
                                  context.read<AssetBloc>().add(
                                        Filter(
                                          searchTerm: _controller.text,
                                          newFilter: state.currentFilter ==
                                                  FilterType.energy
                                              ? FilterType.none
                                              : FilterType.energy,
                                        ),
                                      );
                                },
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              FilterButton(
                                isEnabled:
                                    state.currentFilter == FilterType.critical,
                                text: S.of(context).criticalFilter,
                                icon: Icons.info,
                                onPressed: () {
                                  context.read<AssetBloc>().add(
                                        Filter(
                                          searchTerm: _controller.text,
                                          newFilter: state.currentFilter ==
                                                  FilterType.critical
                                              ? FilterType.none
                                              : FilterType.critical,
                                        ),
                                      );
                                },
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Divider(
                  color: context.colorScheme.tertiary,
                ),
                Expanded(
                  child: BlocBuilder<AssetBloc, AssetState>(
                    builder: (context, state) => switch (state) {
                      Loading() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      Success() => SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.resources
                                .map(
                                  (resource) => ResourceItem(
                                    resource: resource,
                                    expandedResources: state.expandedResources,
                                    onExpandPressed:
                                        (String id, bool isExpanded) {
                                      context.read<AssetBloc>().add(
                                            ToggleExpand(
                                              id,
                                              !isExpanded,
                                            ),
                                          );
                                    },
                                  ),
                                )
                                .toList(),
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
        ),
      );
}
