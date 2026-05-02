import 'package:nomnom_mobile/localization/app_localizations.dart';

class Validators {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? email(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.validationRequired;
    if (!_emailRegex.hasMatch(v)) return l10n.validationEmailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final v = value ?? '';
    if (v.isEmpty) return l10n.validationRequired;
    if (v.length < 6) return l10n.validationPasswordTooShort;
    return null;
  }

  static String? name(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.validationRequired;
    if (v.length < 2) return l10n.validationNameTooShort;
    return null;
  }

  static String? required(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.validationRequired;
    return null;
  }

  static String? quantity(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.validationRequired;
    final parsed = double.tryParse(v.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) return l10n.validationQuantityInvalid;
    return null;
  }

  static String? unit(String? value, AppLocalizations l10n) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return l10n.validationRequired;
    if (!RegExp(r'^[a-zA-Zа-яА-ЯёЁ]+$').hasMatch(v)) {
      return l10n.validationUnitInvalid;
    }
    return null;
  }
}
