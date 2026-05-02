// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'NomNom';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get recipes => 'Recipes';

  @override
  String get favorites => 'Favorites';

  @override
  String get profile => 'Profile';

  @override
  String get addIngredient => 'Add ingredient';

  @override
  String get expiringSoon => 'Expiring soon';

  @override
  String get searchRecipes => 'Search recipes';

  @override
  String get logout => 'Logout';

  @override
  String get quantity => 'Quantity';

  @override
  String get unit => 'Unit';

  @override
  String get expirationDate => 'Expiration date';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get details => 'Details';

  @override
  String get addToFavorites => 'Add to favorites';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get loading => 'Loading';

  @override
  String get error => 'Something went wrong';

  @override
  String get noData => 'No data';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get steps => 'Steps';

  @override
  String expiresInDays(Object days) {
    return 'Expires in $days days';
  }

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get createYourAccount => 'Create your account';

  @override
  String get haveAccountLogin => 'Already have an account? Login';

  @override
  String get validationRequired => 'Required field';

  @override
  String get validationEmailInvalid => 'Enter a valid email';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 6 characters';

  @override
  String get validationNameTooShort => 'Name must be at least 2 characters';

  @override
  String get validationQuantityInvalid => 'Enter a valid number';

  @override
  String get validationUnitInvalid => 'Letters only (e.g. kg, g, ml)';

  @override
  String get emailNotVerified =>
      'Email is not verified. Please check your inbox.';

  @override
  String get resend => 'Resend';
}
