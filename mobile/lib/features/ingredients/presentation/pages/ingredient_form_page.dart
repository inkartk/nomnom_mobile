import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomnom_mobile/features/ingredients/domain/entities/ingredient.dart';
import 'package:nomnom_mobile/features/ingredients/presentation/bloc/ingredient_bloc.dart';
import 'package:nomnom_mobile/utils/date_utils.dart';
import 'package:nomnom_mobile/utils/l10n.dart';
import 'package:nomnom_mobile/widgets/app_background.dart';

@RoutePage()
class IngredientFormPage extends StatefulWidget {
  final String? ingredientId;
  const IngredientFormPage({super.key, this.ingredientId});

  @override
  State<IngredientFormPage> createState() => _IngredientFormPageState();
}

class _IngredientFormPageState extends State<IngredientFormPage> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  DateTime? _expiration;

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
    final bloc = context.read<IngredientBloc>();
    final ingredient = Ingredient(
      id: widget.ingredientId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      quantity: double.tryParse(_quantityController.text.trim()) ?? 0,
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
    final selected = await showDatePicker(
      context: context,
      initialDate: _expiration ?? now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (selected != null) {
      setState(() => _expiration = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addIngredient)),
      body: AppGradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: l10n.name),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _quantityController,
                        decoration: InputDecoration(labelText: l10n.quantity),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _unitController,
                        decoration: InputDecoration(labelText: l10n.unit),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.expirationDate),
                        subtitle: Text(_expiration != null ? formatDate(_expiration!) : '-'),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: _pickDate,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
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
