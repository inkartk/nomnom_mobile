import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:nomnom_mobile/features/recipes/presentation/widgets/recipe_card.dart';
import 'package:nomnom_mobile/features/recipes/presentation/widgets/recipes_shimmer.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/animated_list_item.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/state_message.dart';

@RoutePage()
class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    context
        .read<RecipeBloc>()
        .add(SearchRecipesRequested(_searchController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(l10n.recipes),
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.status == RecipeStatus.loading) {
            return const RecipesShimmer();
          }
          if (state.status == RecipeStatus.error) {
            return AppGradientBackground(
              child: StateMessage(
                icon: Icons.cloud_off_rounded,
                title: l10n.error,
                subtitle: '',
              ),
            );
          }
          if (state.items.isEmpty) {
            return AppGradientBackground(
              child: StateMessage(
                icon: Icons.menu_book_rounded,
                title: l10n.noData,
                subtitle: l10n.searchRecipes,
              ),
            );
          }
          return AppGradientBackground(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: AppSpacing.listPadding,
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) => AnimatedListItem(
                      index: index,
                      child: RecipeCard(recipe: state.items[index]),
                    ),
                    separatorBuilder: (_, __) => AppSpacing.vMd,
                    itemCount: state.items.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
