import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/widgets/ingredient_card.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/widgets/ingredients_header.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/widgets/ingredients_shimmer.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/animated_list_item.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/state_message.dart';

@RoutePage()
class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final auth = context.read<AuthBloc>().state;
      if (auth.status == AuthStatus.authenticated) {
        context.read<IngredientBloc>().add(const LoadIngredients());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.ingredients),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.router.push(IngredientFormRoute()),
        label: Text(l10n.addIngredient),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<IngredientBloc, IngredientState>(
        builder: (context, state) {
          if (state.status == IngredientStatus.loading) {
            return const IngredientsShimmer();
          }
          if (state.status == IngredientStatus.error) {
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
                icon: Icons.kitchen_outlined,
                title: l10n.noData,
                subtitle: l10n.addIngredient,
              ),
            );
          }
          return AppGradientBackground(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: IngredientsHeader(
                    title: l10n.ingredients,
                    filterActive: state.showExpiringSoon,
                    onToggle: () {
                      if (state.showExpiringSoon) {
                        context
                            .read<IngredientBloc>()
                            .add(const LoadIngredients());
                      } else {
                        context
                            .read<IngredientBloc>()
                            .add(const LoadExpiringSoon());
                      }
                    },
                  ),
                ),
                SliverPadding(
                  padding: AppSpacing.listPadding,
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) => AnimatedListItem(
                      index: index,
                      child: IngredientCard(item: state.items[index]),
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
