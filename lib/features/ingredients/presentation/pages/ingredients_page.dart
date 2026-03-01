import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/router/app_router.dart';
import 'package:nomnom_mobile/utils/date_utils.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/shimmer.dart';
import 'package:nomnom_mobile/widgets/state_message.dart';

@RoutePage()
class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

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
            return const _IngredientsShimmer();
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
                  child: _IngredientsHeader(
                    title: l10n.ingredients,
                    filterActive: state.showExpiringSoon,
                    onToggle: () {
                      if (state.showExpiringSoon) {
                        context.read<IngredientBloc>().add(const LoadIngredients());
                      } else {
                        context.read<IngredientBloc>().add(const LoadExpiringSoon());
                      }
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) => _IngredientCard(item: state.items[index]),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
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

class _IngredientsHeader extends StatelessWidget {
  final String title;
  final bool filterActive;
  final VoidCallback onToggle;

  const _IngredientsHeader({
    required this.title,
    required this.filterActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 88, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withOpacity(0.18),
              colorScheme.secondary.withOpacity(0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: colorScheme.primary.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.kitchen, color: colorScheme.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            FilterChip(
              selected: filterActive,
              onSelected: (_) => onToggle(),
              label: Text(l10n.expiringSoon),
            ),
          ],
        ),
      ),
    );
  }
}

class _IngredientCard extends StatelessWidget {
  final Ingredient item;
  const _IngredientCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final soon = isExpiringSoon(item.expirationDate);
    final days = daysUntil(item.expirationDate);
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.router.push(IngredientFormRoute(ingredientId: item.id)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: soon ? Colors.orange[100] : Colors.green[100],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(soon ? Icons.timer : Icons.check_circle, color: soon ? Colors.orange : Colors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text('${item.quantity} ${item.unit}', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: soon ? Colors.orange.withOpacity(0.12) : Colors.green.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        l10n.expiresInDays(days),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: soon ? Colors.orange[800] : Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    context.router.push(IngredientFormRoute(ingredientId: item.id));
                  } else if (value == 'delete') {
                    context.read<IngredientBloc>().add(DeleteIngredientRequested(item.id));
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit', child: Text(l10n.edit)),
                  PopupMenuItem(value: 'delete', child: Text(l10n.delete)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _IngredientsShimmer extends StatelessWidget {
  const _IngredientsShimmer();

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 88, 16, 24),
        itemBuilder: (context, index) => const _IngredientShimmerCard(),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 6,
      ),
    );
  }
}

class _IngredientShimmerCard extends StatelessWidget {
  const _IngredientShimmerCard();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const ShimmerBox(height: 50, width: 50, radius: 14),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(height: 16, width: double.infinity, radius: 8),
                  SizedBox(height: 8),
                  ShimmerBox(height: 12, width: 140, radius: 8),
                  SizedBox(height: 10),
                  ShimmerBox(height: 12, width: 120, radius: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
