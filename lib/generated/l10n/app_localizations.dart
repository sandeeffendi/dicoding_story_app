import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @likedTitle.
  ///
  /// In en, this message translates to:
  /// **'Liked By '**
  String get likedTitle;

  /// No description provided for @languagePreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languagePreferencesTitle;

  /// No description provided for @postsTitle.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get postsTitle;

  /// No description provided for @followerTitle.
  ///
  /// In en, this message translates to:
  /// **'Follower'**
  String get followerTitle;

  /// No description provided for @followingTitle.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get followingTitle;

  /// No description provided for @andTitle.
  ///
  /// In en, this message translates to:
  /// **'And'**
  String get andTitle;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @archiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get archiveTitle;

  /// No description provided for @newPostTitle.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get newPostTitle;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTitle;

  /// No description provided for @addLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get addLocationTitle;

  /// No description provided for @writeCaptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Write a caption...'**
  String get writeCaptionTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Dicoding Gram'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue to your account'**
  String get welcomeSubtitle;

  /// No description provided for @rememberMeTitle.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMeTitle;

  /// No description provided for @continueTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueTitle;

  /// No description provided for @dontHaveAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccountTitle;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpTitle;

  /// No description provided for @registerAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Regsiter Account'**
  String get registerAccountTitle;

  /// No description provided for @registerAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your details'**
  String get registerAccountSubtitle;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @logOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOutTitle;

  /// No description provided for @othersTitle.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get othersTitle;

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationTitle;

  /// No description provided for @removeLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Location'**
  String get removeLocationTitle;

  /// No description provided for @postCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Post Created'**
  String get postCreatedTitle;

  /// No description provided for @fullNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameTitle;

  /// No description provided for @emailTitle.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTitle;

  /// No description provided for @passwordTitle.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTitle;

  /// No description provided for @confirmPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordTitle;

  /// No description provided for @agreeDescription.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get agreeDescription;

  /// No description provided for @termsDescription.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsDescription;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyDescription;

  /// No description provided for @createAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountTitle;

  /// No description provided for @termsConfirmDescription.
  ///
  /// In en, this message translates to:
  /// **'By continuing you confirm that you agree with out Term and Condition'**
  String get termsConfirmDescription;

  /// No description provided for @enterYourTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your'**
  String get enterYourTitle;

  /// No description provided for @kEmailNullError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your email'**
  String get kEmailNullError;

  /// No description provided for @kInvalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Email'**
  String get kInvalidEmailError;

  /// No description provided for @kPassNullError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your password'**
  String get kPassNullError;

  /// No description provided for @kShortPassError.
  ///
  /// In en, this message translates to:
  /// **'Password is too short'**
  String get kShortPassError;

  /// No description provided for @kMatchPassError.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get kMatchPassError;

  /// No description provided for @kNamelNullError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your name'**
  String get kNamelNullError;

  /// No description provided for @kInvalidNameError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your name'**
  String get kInvalidNameError;

  /// No description provided for @kPhoneNumberNullError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your phone number'**
  String get kPhoneNumberNullError;

  /// No description provided for @kAddressNullError.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your address'**
  String get kAddressNullError;

  /// No description provided for @checkUserNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your username or password and try again.'**
  String get checkUserNameTitle;

  /// No description provided for @loginFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailedTitle;

  /// No description provided for @tryAgainTitle.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgainTitle;

  /// No description provided for @agreeTermError.
  ///
  /// In en, this message translates to:
  /// **'Please agree to Terms and Conditions'**
  String get agreeTermError;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryTitle;

  /// No description provided for @cameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraTitle;

  /// No description provided for @accountCreatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Created!'**
  String get accountCreatedTitle;

  /// No description provided for @accountCreatedSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully.'**
  String get accountCreatedSubTitle;

  /// No description provided for @getStartedTitle.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStartedTitle;

  /// No description provided for @unableCreateAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to create account. Please try again.'**
  String get unableCreateAccountTitle;

  /// No description provided for @registerFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get registerFailedTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
