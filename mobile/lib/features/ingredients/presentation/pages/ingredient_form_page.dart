import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/theme/app_colors.dart';
import 'package:nomnom_mobile/theme/app_spacing.dart';
import 'package:nomnom_mobile/utils/date_utils.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/utils/validators.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';
import 'package:nomnom_mobile/widgets/glass_card.dart';
import 'package:nomnom_mobile/widgets/gradient_button.dart';

@RoutePage()
class IngredientFormPage extends StatefulWidget {
  final String? ingredientId;
  const IngredientFormPage({super.key, this.ingredientId});

  @override
  State<IngredientFormPage> createState() => _IngredientFormPageState();
}

class _IngredientFormPageState extends State<IngredientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  DateTime? _expiration;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<IngredientBloc>();
    final item = bloc.state.items.firstWhere(
      (e) => e.id == widget.ingredientId,
      orElse: () => Ingredient(
        id: '',
        name: '',
        quantity: 0,
        unit: '',
        expirationDate: DateTime.now(),
      ),
    );
    if (widget.ingredientId != null && item.id.isNotEmpty) {
      _nameController.text = item.name;
      _quantityController.text = item.quantity.toString();
      _unitController.text = item.unit;
      _expiration = item.expirationDate;
    } else {
      _expiration = DateTime.now().add(const Duration(days: 5));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _save() {
    if (_autovalidateMode != AutovalidateMode.onUserInteraction) {
      setState(() => _autovalidateMode = AutovalidateMode.onUserInteraction);
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final bloc = context.read<IngredientBloc>();
    final ingredient = Ingredient(
      id: widget.ingredientId ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      quantity: double.tryParse(
              _quantityController.text.trim().replaceAll(',', '.')) ??
          0,
      unit: _unitController.text.trim(),
      expirationDate: _expiration ?? DateTime.now(),
    );

    if (widget.ingredientId == null) {
      bloc.add(AddIngredientRequested(ingredient));
    } else {
      bloc.add(UpdateIngredientRequested(ingredient));
    }
    context.router.maybePop();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final firstDate = now.subtract(const Duration(days: 1));
    final lastDate = now.add(const Duration(days: 365));
    var initialDate = _expiration ?? now;
    if (initialDate.isBefore(firstDate)) initialDate = firstDate;
    if (initialDate.isAfter(lastDate)) initialDate = lastDate;
    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selected != null) {
      setState(() => _expiration = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addIngredient)),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: AppSpacing.pagePadding,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: GlassCard(
                  padding: AppSpacing.cardPaddingLarge,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: l10n.name),
                        validator: (v) => Validators.required(v, l10n),
                      ),
                      AppSpacing.vMd,
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(labelText: l10n.quantity),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (v) => Validators.quantity(v, l10n),
                      ),
                      AppSpacing.vMd,
                      TextFormField(
                        controller: _unitController,
                        decoration: InputDecoration(labelText: l10n.unit),
                        validator: (v) => Validators.unit(v, l10n),
                      ),
                      AppSpacing.vMd,
                      GlassCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        borderRadius: 16,
                        blur: 8,
                        child: InkWell(
                          onTap: _pickDate,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      l10n.expirationDate,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    AppSpacing.vXs,
                                    Text(
                                      _expiration != null
                                          ? formatDate(_expiration!)
                                          : '-',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: AppColors.accent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
                ),
                AppSpacing.vLg,
                SizedBox(
                  width: double.infinity,
                  child: GradientButton(
                    onPressed: _save,
                    child: Text(l10n.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
