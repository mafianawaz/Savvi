import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('es')
  ];

  /// App name
  ///
  /// In en, this message translates to:
  /// **'Savvi'**
  String get appName;

  /// No description provided for @relToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get relToday;

  /// No description provided for @relYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get relYesterday;

  /// No description provided for @relTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get relTomorrow;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionRetry;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @actionGoToProfile.
  ///
  /// In en, this message translates to:
  /// **'Go to Profile'**
  String get actionGoToProfile;

  /// No description provided for @stateLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get stateLoading;

  /// No description provided for @stateEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get stateEmptyTitle;

  /// No description provided for @stateErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get stateErrorTitle;

  /// No description provided for @stateSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get stateSuccessTitle;

  /// No description provided for @errNetwork.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your internet and try again.'**
  String get errNetwork;

  /// No description provided for @errTimeout.
  ///
  /// In en, this message translates to:
  /// **'That took too long. Please try again.'**
  String get errTimeout;

  /// No description provided for @errUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Your session ended. Please sign in again.'**
  String get errUnauthorized;

  /// No description provided for @errServer.
  ///
  /// In en, this message translates to:
  /// **'We hit a snag on our end. Please try again shortly.'**
  String get errServer;

  /// No description provided for @errUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errUnknown;

  /// No description provided for @valRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get valRequired;

  /// No description provided for @valEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get valEmail;

  /// No description provided for @valPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to continue.'**
  String get valPhoneRequired;

  /// No description provided for @valPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number.'**
  String get valPhoneInvalid;

  /// No description provided for @valZip.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid ZIP code.'**
  String get valZip;

  /// No description provided for @phoneHelp.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required so the nonprofit partner can safely coordinate pickup, delivery, or support for your food request. Savvi does not use SMS notifications for MVP.'**
  String get phoneHelp;

  /// No description provided for @unitLbs.
  ///
  /// In en, this message translates to:
  /// **'lbs'**
  String get unitLbs;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitMi.
  ///
  /// In en, this message translates to:
  /// **'mi'**
  String get unitMi;

  /// No description provided for @unitMin.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get unitMin;

  /// No description provided for @stSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get stSubmitted;

  /// No description provided for @stNeedsUpdate.
  ///
  /// In en, this message translates to:
  /// **'Needs update'**
  String get stNeedsUpdate;

  /// No description provided for @stApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get stApproved;

  /// No description provided for @stScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get stScheduled;

  /// No description provided for @stPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get stPreparing;

  /// No description provided for @stReadyPickup.
  ///
  /// In en, this message translates to:
  /// **'Ready for pickup'**
  String get stReadyPickup;

  /// No description provided for @stPickupConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Pickup confirmed'**
  String get stPickupConfirmed;

  /// No description provided for @stOutForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for delivery'**
  String get stOutForDelivery;

  /// No description provided for @stNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get stNearby;

  /// No description provided for @stDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get stDelivered;

  /// No description provided for @stDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get stDelayed;

  /// No description provided for @stUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get stUnavailable;

  /// No description provided for @stCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get stCompleted;

  /// No description provided for @stMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get stMissed;

  /// No description provided for @stDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get stDeclined;

  /// No description provided for @stCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get stCancelled;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get actionSignIn;

  /// No description provided for @actionSignInShort.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get actionSignInShort;

  /// No description provided for @signInTagline.
  ///
  /// In en, this message translates to:
  /// **'The Savvi way to request food for families.'**
  String get signInTagline;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Members sign in below. New members need a nonprofit access link.'**
  String get signInSubtitle;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get fieldEmail;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @hintEmail.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get hintEmail;

  /// No description provided for @hintPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get hintPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @newMemberPrompt.
  ///
  /// In en, this message translates to:
  /// **'New member?'**
  String get newMemberPrompt;

  /// No description provided for @createWithAccessLink.
  ///
  /// In en, this message translates to:
  /// **'Create account with access link'**
  String get createWithAccessLink;

  /// No description provided for @accessTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your access'**
  String get accessTitle;

  /// No description provided for @accessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paste the link sent by your nonprofit, or scan the QR code at a Savvi enrollment location.'**
  String get accessSubtitle;

  /// No description provided for @accessInviteNote.
  ///
  /// In en, this message translates to:
  /// **'Savvi is invite-only. Access links are sent by nonprofit staff and expire after 48 hours.'**
  String get accessInviteNote;

  /// No description provided for @accessPasteLabel.
  ///
  /// In en, this message translates to:
  /// **'Paste access link or code'**
  String get accessPasteLabel;

  /// No description provided for @accessPasteHint.
  ///
  /// In en, this message translates to:
  /// **'Paste your link or code'**
  String get accessPasteHint;

  /// No description provided for @accessVerifyBtn.
  ///
  /// In en, this message translates to:
  /// **'Verify Access Link'**
  String get accessVerifyBtn;

  /// No description provided for @orDivider.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orDivider;

  /// No description provided for @accessScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Nonprofit QR Code'**
  String get accessScanTitle;

  /// No description provided for @accessScanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For standard enrollment or trusted onsite auto-approval events'**
  String get accessScanSubtitle;

  /// No description provided for @accessVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Access verified.'**
  String get accessVerifiedTitle;

  /// No description provided for @accessVerifiedBody.
  ///
  /// In en, this message translates to:
  /// **'Complete your account profile to submit for approval.'**
  String get accessVerifiedBody;

  /// No description provided for @accessOnsiteTitle.
  ///
  /// In en, this message translates to:
  /// **'Trusted onsite enrollment detected.'**
  String get accessOnsiteTitle;

  /// No description provided for @accessOnsiteBody.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile to receive instant approval from the nonprofit staff on site.'**
  String get accessOnsiteBody;

  /// No description provided for @accessContinueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue to Create Account'**
  String get accessContinueBtn;

  /// No description provided for @accessContinueHint.
  ///
  /// In en, this message translates to:
  /// **'Verify your access link or scan a QR code to continue.'**
  String get accessContinueHint;

  /// No description provided for @accessErrEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please paste your access link or code first.'**
  String get accessErrEmpty;

  /// No description provided for @accessErrExpired.
  ///
  /// In en, this message translates to:
  /// **'This access link has expired. Ask your nonprofit for a new one.'**
  String get accessErrExpired;

  /// No description provided for @accessErrUsed.
  ///
  /// In en, this message translates to:
  /// **'This access link has already been used.'**
  String get accessErrUsed;

  /// No description provided for @accessErrInvalid.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t verify that link or code. Check it and try again.'**
  String get accessErrInvalid;

  /// No description provided for @qrTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR access'**
  String get qrTitle;

  /// No description provided for @qrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at the nonprofit QR code, or enter the code below.'**
  String get qrSubtitle;

  /// No description provided for @qrScanBtn.
  ///
  /// In en, this message translates to:
  /// **'Open camera to scan'**
  String get qrScanBtn;

  /// No description provided for @qrEnterLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter code manually'**
  String get qrEnterLabel;

  /// No description provided for @qrCameraStaged.
  ///
  /// In en, this message translates to:
  /// **'Camera scanning is enabled during device setup. For now, enter the code from your nonprofit below.'**
  String get qrCameraStaged;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile to request nonprofit approval.'**
  String get signUpSubtitle;

  /// No description provided for @signUpAccessRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Access link required'**
  String get signUpAccessRequiredTitle;

  /// No description provided for @signUpAccessRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'You need a nonprofit access link or QR code to create a Savvi account.'**
  String get signUpAccessRequiredBody;

  /// No description provided for @signUpAccessVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Access verified'**
  String get signUpAccessVerifiedTitle;

  /// No description provided for @signUpAccessVerifiedBody.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile and submit for approval.'**
  String get signUpAccessVerifiedBody;

  /// No description provided for @fieldFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get fieldFirstName;

  /// No description provided for @fieldLastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get fieldLastName;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get fieldPhone;

  /// No description provided for @hintPhone.
  ///
  /// In en, this message translates to:
  /// **'(713) 555-0000'**
  String get hintPhone;

  /// No description provided for @fieldStreet.
  ///
  /// In en, this message translates to:
  /// **'Street address'**
  String get fieldStreet;

  /// No description provided for @hintStreet.
  ///
  /// In en, this message translates to:
  /// **'1809 Elgin St'**
  String get hintStreet;

  /// No description provided for @fieldCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get fieldCity;

  /// No description provided for @hintCity.
  ///
  /// In en, this message translates to:
  /// **'Houston'**
  String get hintCity;

  /// No description provided for @fieldState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get fieldState;

  /// No description provided for @fieldZip.
  ///
  /// In en, this message translates to:
  /// **'ZIP'**
  String get fieldZip;

  /// No description provided for @hintZip.
  ///
  /// In en, this message translates to:
  /// **'77004'**
  String get hintZip;

  /// No description provided for @fieldHousehold.
  ///
  /// In en, this message translates to:
  /// **'Household size'**
  String get fieldHousehold;

  /// No description provided for @householdPerson.
  ///
  /// In en, this message translates to:
  /// **'{count} person'**
  String householdPerson(int count);

  /// No description provided for @householdPeople.
  ///
  /// In en, this message translates to:
  /// **'{count} people'**
  String householdPeople(int count);

  /// No description provided for @householdPeopleMax.
  ///
  /// In en, this message translates to:
  /// **'10+ people'**
  String get householdPeopleMax;

  /// No description provided for @pwdReqLength.
  ///
  /// In en, this message translates to:
  /// **'8+ characters'**
  String get pwdReqLength;

  /// No description provided for @pwdReqUpper.
  ///
  /// In en, this message translates to:
  /// **'Uppercase'**
  String get pwdReqUpper;

  /// No description provided for @pwdReqNumber.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get pwdReqNumber;

  /// No description provided for @pwdReqSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special character'**
  String get pwdReqSpecial;

  /// No description provided for @consentText.
  ///
  /// In en, this message translates to:
  /// **'I agree to Savvi\'s Privacy Policy and consent to my household data being shared with my nonprofit partner for food support purposes only.'**
  String get consentText;

  /// No description provided for @consentRequired.
  ///
  /// In en, this message translates to:
  /// **'Please agree to continue.'**
  String get consentRequired;

  /// No description provided for @signUpApprovalNote.
  ///
  /// In en, this message translates to:
  /// **'Your account must be approved by a nonprofit partner before you can submit food requests.'**
  String get signUpApprovalNote;

  /// No description provided for @signUpSubmitBtn.
  ///
  /// In en, this message translates to:
  /// **'Submit for Approval'**
  String get signUpSubmitBtn;

  /// No description provided for @haveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountPrompt;

  /// No description provided for @approvalHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re almost there.'**
  String get approvalHeroTitle;

  /// No description provided for @approvalHeroBody.
  ///
  /// In en, this message translates to:
  /// **'Your profile is with the nonprofit. Approval is just around the corner.'**
  String get approvalHeroBody;

  /// No description provided for @stepSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get stepSubmitted;

  /// No description provided for @stepReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get stepReview;

  /// No description provided for @stepApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get stepApproved;

  /// No description provided for @approvalStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get approvalStatusLabel;

  /// No description provided for @approvalPendingBadge.
  ///
  /// In en, this message translates to:
  /// **'Pending Review'**
  String get approvalPendingBadge;

  /// No description provided for @approvalRow1Title.
  ///
  /// In en, this message translates to:
  /// **'Profile submitted'**
  String get approvalRow1Title;

  /// No description provided for @approvalRow1Body.
  ///
  /// In en, this message translates to:
  /// **'Your account details were received today'**
  String get approvalRow1Body;

  /// No description provided for @approvalRow2Title.
  ///
  /// In en, this message translates to:
  /// **'Nonprofit review in progress'**
  String get approvalRow2Title;

  /// No description provided for @approvalRow2Body.
  ///
  /// In en, this message translates to:
  /// **'Your partner is reviewing your profile now'**
  String get approvalRow2Body;

  /// No description provided for @approvalRow3Title.
  ///
  /// In en, this message translates to:
  /// **'Approval decision'**
  String get approvalRow3Title;

  /// No description provided for @approvalRow3Body.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you by push and email'**
  String get approvalRow3Body;

  /// No description provided for @approvalMotivTitle.
  ///
  /// In en, this message translates to:
  /// **'Good things are coming.'**
  String get approvalMotivTitle;

  /// No description provided for @approvalMotivBody.
  ///
  /// In en, this message translates to:
  /// **'Most approvals are completed within 1–2 business days. You\'ll get a notification the moment your access is ready.'**
  String get approvalMotivBody;

  /// No description provided for @trackApprovalBtn.
  ///
  /// In en, this message translates to:
  /// **'Track Approval Status'**
  String get trackApprovalBtn;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @approvedTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re approved!'**
  String get approvedTitle;

  /// No description provided for @approvedBody.
  ///
  /// In en, this message translates to:
  /// **'Your nonprofit partner approved your account. You can now request food support.'**
  String get approvedBody;

  /// No description provided for @approvedCta.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get approvedCta;

  /// No description provided for @declinedTitle.
  ///
  /// In en, this message translates to:
  /// **'Approval not granted'**
  String get declinedTitle;

  /// No description provided for @declinedBody.
  ///
  /// In en, this message translates to:
  /// **'Your nonprofit partner wasn\'t able to approve this account. Please contact them for next steps.'**
  String get declinedBody;

  /// No description provided for @needsReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Additional review needed'**
  String get needsReviewTitle;

  /// No description provided for @needsReviewBody.
  ///
  /// In en, this message translates to:
  /// **'Your nonprofit partner needs a little more information before approving. They\'ll reach out by push and email.'**
  String get needsReviewBody;

  /// No description provided for @pwdNotMet.
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t meet all requirements yet.'**
  String get pwdNotMet;

  /// No description provided for @requestIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Request ID'**
  String get requestIdLabel;

  /// No description provided for @catProduce.
  ///
  /// In en, this message translates to:
  /// **'Produce'**
  String get catProduce;

  /// No description provided for @catDairy.
  ///
  /// In en, this message translates to:
  /// **'Dairy'**
  String get catDairy;

  /// No description provided for @catMeatProtein.
  ///
  /// In en, this message translates to:
  /// **'Meat / Protein'**
  String get catMeatProtein;

  /// No description provided for @catPreparedMeals.
  ///
  /// In en, this message translates to:
  /// **'Prepared Meals'**
  String get catPreparedMeals;

  /// No description provided for @catBakeryBread.
  ///
  /// In en, this message translates to:
  /// **'Bakery / Bread'**
  String get catBakeryBread;

  /// No description provided for @catPantry.
  ///
  /// In en, this message translates to:
  /// **'Pantry'**
  String get catPantry;

  /// No description provided for @catFrozen.
  ///
  /// In en, this message translates to:
  /// **'Frozen'**
  String get catFrozen;

  /// No description provided for @catSnacksBeverages.
  ///
  /// In en, this message translates to:
  /// **'Snacks & Beverages'**
  String get catSnacksBeverages;

  /// No description provided for @catBabyFood.
  ///
  /// In en, this message translates to:
  /// **'Baby Food'**
  String get catBabyFood;

  /// No description provided for @catInfantFormula.
  ///
  /// In en, this message translates to:
  /// **'Infant Formula'**
  String get catInfantFormula;

  /// No description provided for @catControlledNote.
  ///
  /// In en, this message translates to:
  /// **'Controlled item — extra review may apply'**
  String get catControlledNote;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get navAlerts;

  /// No description provided for @navRequest.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get navRequest;

  /// No description provided for @navActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navActivity;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @greetMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetMorning;

  /// No description provided for @greetAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetAfternoon;

  /// No description provided for @greetEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetEvening;

  /// No description provided for @homeCtaTitle.
  ///
  /// In en, this message translates to:
  /// **'Request food support'**
  String get homeCtaTitle;

  /// No description provided for @homeCtaBody.
  ///
  /// In en, this message translates to:
  /// **'No lines. Pickup or delivery.'**
  String get homeCtaBody;

  /// No description provided for @homeCtaBtn.
  ///
  /// In en, this message translates to:
  /// **'Request →'**
  String get homeCtaBtn;

  /// No description provided for @homeNoActive.
  ///
  /// In en, this message translates to:
  /// **'No active request'**
  String get homeNoActive;

  /// No description provided for @homeNoActiveBody.
  ///
  /// In en, this message translates to:
  /// **'When you request food support, you\'ll track it here.'**
  String get homeNoActiveBody;

  /// No description provided for @etaAway.
  ///
  /// In en, this message translates to:
  /// **'{eta} away'**
  String etaAway(String eta);

  /// No description provided for @milesAway.
  ///
  /// In en, this message translates to:
  /// **'{miles} away'**
  String milesAway(String miles);

  /// No description provided for @alertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Access'**
  String get alertsTitle;

  /// No description provided for @alertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hot meals, distributions, and delivery slots near you.'**
  String get alertsSubtitle;

  /// No description provided for @alertTypeHot.
  ///
  /// In en, this message translates to:
  /// **'Hot Meal Alert'**
  String get alertTypeHot;

  /// No description provided for @alertTypeDist.
  ///
  /// In en, this message translates to:
  /// **'Food Distribution Event'**
  String get alertTypeDist;

  /// No description provided for @alertSpotsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} remaining'**
  String alertSpotsLeft(int count);

  /// No description provided for @alertRsvpPrompt.
  ///
  /// In en, this message translates to:
  /// **'Select how many you are reserving for.'**
  String get alertRsvpPrompt;

  /// No description provided for @alertRsvpConfirm.
  ///
  /// In en, this message translates to:
  /// **'I\'m Coming'**
  String get alertRsvpConfirm;

  /// No description provided for @alertRsvpConfirmed.
  ///
  /// In en, this message translates to:
  /// **'RSVP confirmed for {count}'**
  String alertRsvpConfirmed(int count);

  /// No description provided for @alertRsvpChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get alertRsvpChange;

  /// No description provided for @alertRsvpCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel RSVP'**
  String get alertRsvpCancel;

  /// No description provided for @alertsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No alerts right now'**
  String get alertsEmpty;

  /// No description provided for @alertsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you when food is available nearby.'**
  String get alertsEmptyBody;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @savviMember.
  ///
  /// In en, this message translates to:
  /// **'Savvi member'**
  String get savviMember;

  /// No description provided for @homeSub.
  ///
  /// In en, this message translates to:
  /// **'Your food support, delivered with dignity.'**
  String get homeSub;

  /// No description provided for @householdOf.
  ///
  /// In en, this message translates to:
  /// **'Household of {count}'**
  String householdOf(String count);

  /// No description provided for @tileAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Food Access Alerts'**
  String get tileAlertsTitle;

  /// No description provided for @tileAlertsSub.
  ///
  /// In en, this message translates to:
  /// **'Hot meals & events near you'**
  String get tileAlertsSub;

  /// No description provided for @tileReqTitle.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get tileReqTitle;

  /// No description provided for @tileReqSub.
  ///
  /// In en, this message translates to:
  /// **'Status & pickup details'**
  String get tileReqSub;

  /// No description provided for @activeRequest.
  ///
  /// In en, this message translates to:
  /// **'Active request'**
  String get activeRequest;

  /// No description provided for @alertRsvpMax.
  ///
  /// In en, this message translates to:
  /// **'Max {count} · your household size'**
  String alertRsvpMax(int count);

  /// No description provided for @alertRsvpSeeYou.
  ///
  /// In en, this message translates to:
  /// **'We\'ll see you there. Thank you!'**
  String get alertRsvpSeeYou;

  /// No description provided for @alertRsvpCancelled.
  ///
  /// In en, this message translates to:
  /// **'Your RSVP was cancelled.'**
  String get alertRsvpCancelled;

  /// No description provided for @alertRsvpSelectFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select at least 1 before confirming.'**
  String get alertRsvpSelectFirst;

  /// No description provided for @reqTitle.
  ///
  /// In en, this message translates to:
  /// **'Request support'**
  String get reqTitle;

  /// No description provided for @reqStep.
  ///
  /// In en, this message translates to:
  /// **'Step {n} of {t}'**
  String reqStep(int n, int t);

  /// No description provided for @s1Title.
  ///
  /// In en, this message translates to:
  /// **'What would help most?'**
  String get s1Title;

  /// No description provided for @s1Sub.
  ///
  /// In en, this message translates to:
  /// **'Select one or more categories.'**
  String get s1Sub;

  /// No description provided for @s2Title.
  ///
  /// In en, this message translates to:
  /// **'Pickup or delivery?'**
  String get s2Title;

  /// No description provided for @s2Sub.
  ///
  /// In en, this message translates to:
  /// **'Choose how you\'d like to receive your support.'**
  String get s2Sub;

  /// No description provided for @s3Title.
  ///
  /// In en, this message translates to:
  /// **'Household & contact'**
  String get s3Title;

  /// No description provided for @s3Sub.
  ///
  /// In en, this message translates to:
  /// **'These come from your profile. Update them there if anything has changed.'**
  String get s3Sub;

  /// No description provided for @s4Title.
  ///
  /// In en, this message translates to:
  /// **'Dietary & allergens'**
  String get s4Title;

  /// No description provided for @s4Sub.
  ///
  /// In en, this message translates to:
  /// **'Sent to the nonprofit for packing only.'**
  String get s4Sub;

  /// No description provided for @s5Title.
  ///
  /// In en, this message translates to:
  /// **'Review your request'**
  String get s5Title;

  /// No description provided for @s5Sub.
  ///
  /// In en, this message translates to:
  /// **'Check everything before you submit.'**
  String get s5Sub;

  /// No description provided for @stepNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get stepNext;

  /// No description provided for @stepBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get stepBack;

  /// No description provided for @methodPickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get methodPickup;

  /// No description provided for @methodDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get methodDelivery;

  /// No description provided for @pickupDesc.
  ///
  /// In en, this message translates to:
  /// **'Collect with your pickup code at the nonprofit location.'**
  String get pickupDesc;

  /// No description provided for @deliveryDesc.
  ///
  /// In en, this message translates to:
  /// **'Delivered to your address. Live tracking in the app.'**
  String get deliveryDesc;

  /// No description provided for @controlledItem.
  ///
  /// In en, this message translates to:
  /// **'Controlled item'**
  String get controlledItem;

  /// No description provided for @formulaNote.
  ///
  /// In en, this message translates to:
  /// **'Infant Formula availability depends on nonprofit approval, sealed packaging, expiration date, and program eligibility.'**
  String get formulaNote;

  /// No description provided for @formulaAck.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get formulaAck;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes for the nonprofit'**
  String get notesLabel;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Anything helpful for the nonprofit to know?'**
  String get notesHint;

  /// No description provided for @fromProfile.
  ///
  /// In en, this message translates to:
  /// **'From your profile'**
  String get fromProfile;

  /// No description provided for @editInProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit in profile'**
  String get editInProfile;

  /// No description provided for @dietTitle.
  ///
  /// In en, this message translates to:
  /// **'Dietary preferences'**
  String get dietTitle;

  /// No description provided for @allergensTitle.
  ///
  /// In en, this message translates to:
  /// **'Allergens'**
  String get allergensTitle;

  /// No description provided for @dSenior.
  ///
  /// In en, this message translates to:
  /// **'Senior-friendly foods'**
  String get dSenior;

  /// No description provided for @dLowSodium.
  ///
  /// In en, this message translates to:
  /// **'Low sodium'**
  String get dLowSodium;

  /// No description provided for @dDiabetic.
  ///
  /// In en, this message translates to:
  /// **'Diabetic-friendly'**
  String get dDiabetic;

  /// No description provided for @dVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get dVegetarian;

  /// No description provided for @dVegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get dVegan;

  /// No description provided for @dHalal.
  ///
  /// In en, this message translates to:
  /// **'Halal-friendly'**
  String get dHalal;

  /// No description provided for @dNoPork.
  ///
  /// In en, this message translates to:
  /// **'No pork'**
  String get dNoPork;

  /// No description provided for @dGlutenFree.
  ///
  /// In en, this message translates to:
  /// **'Gluten-free'**
  String get dGlutenFree;

  /// No description provided for @gPeanuts.
  ///
  /// In en, this message translates to:
  /// **'Peanuts'**
  String get gPeanuts;

  /// No description provided for @gTreeNuts.
  ///
  /// In en, this message translates to:
  /// **'Tree nuts'**
  String get gTreeNuts;

  /// No description provided for @gMilk.
  ///
  /// In en, this message translates to:
  /// **'Milk / Dairy'**
  String get gMilk;

  /// No description provided for @gEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get gEggs;

  /// No description provided for @gSoy.
  ///
  /// In en, this message translates to:
  /// **'Soy'**
  String get gSoy;

  /// No description provided for @gWheat.
  ///
  /// In en, this message translates to:
  /// **'Wheat / Gluten'**
  String get gWheat;

  /// No description provided for @gFish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get gFish;

  /// No description provided for @gShellfish.
  ///
  /// In en, this message translates to:
  /// **'Shellfish'**
  String get gShellfish;

  /// No description provided for @gSesame.
  ///
  /// In en, this message translates to:
  /// **'Sesame'**
  String get gSesame;

  /// No description provided for @rvCats.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get rvCats;

  /// No description provided for @rvMethod.
  ///
  /// In en, this message translates to:
  /// **'Method'**
  String get rvMethod;

  /// No description provided for @rvHousehold.
  ///
  /// In en, this message translates to:
  /// **'Household'**
  String get rvHousehold;

  /// No description provided for @rvContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get rvContact;

  /// No description provided for @rvAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get rvAddress;

  /// No description provided for @rvDiet.
  ///
  /// In en, this message translates to:
  /// **'Dietary'**
  String get rvDiet;

  /// No description provided for @rvAlg.
  ///
  /// In en, this message translates to:
  /// **'Allergens'**
  String get rvAlg;

  /// No description provided for @rvNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get rvNotes;

  /// No description provided for @rvNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get rvNone;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @reqOkTitle.
  ///
  /// In en, this message translates to:
  /// **'Request submitted.'**
  String get reqOkTitle;

  /// No description provided for @reqOkBody.
  ///
  /// In en, this message translates to:
  /// **'{np} will review and confirm your request. You\'ll get a notification with the decision.'**
  String reqOkBody(String np);

  /// No description provided for @viewRequest.
  ///
  /// In en, this message translates to:
  /// **'View request'**
  String get viewRequest;

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backHome;

  /// No description provided for @errNoCat.
  ///
  /// In en, this message translates to:
  /// **'Select at least one food category.'**
  String get errNoCat;

  /// No description provided for @errNoMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose pickup or delivery.'**
  String get errNoMethod;

  /// No description provided for @deliveryUnavail.
  ///
  /// In en, this message translates to:
  /// **'Delivery is not available for this request right now. Pickup may still be available.'**
  String get deliveryUnavail;

  /// No description provided for @deliveryChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking delivery availability…'**
  String get deliveryChecking;

  /// No description provided for @deliveryAvailError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t check delivery availability. Try again.'**
  String get deliveryAvailError;

  /// No description provided for @actTitle.
  ///
  /// In en, this message translates to:
  /// **'My Requests'**
  String get actTitle;

  /// No description provided for @actSub.
  ///
  /// In en, this message translates to:
  /// **'Pickup codes, delivery status, and history.'**
  String get actSub;

  /// No description provided for @tabActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get tabActive;

  /// No description provided for @tabHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tabHistory;

  /// No description provided for @tabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tabAll;

  /// No description provided for @actEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No requests here'**
  String get actEmptyTitle;

  /// No description provided for @actEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Requests you submit will appear in this list.'**
  String get actEmptyBody;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLabel;

  /// No description provided for @pickupCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup code'**
  String get pickupCodeLabel;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @trackDelivery.
  ///
  /// In en, this message translates to:
  /// **'Track delivery'**
  String get trackDelivery;

  /// No description provided for @viewPickup.
  ///
  /// In en, this message translates to:
  /// **'View pickup details'**
  String get viewPickup;

  /// No description provided for @editRequest.
  ///
  /// In en, this message translates to:
  /// **'Edit request'**
  String get editRequest;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get cancelRequest;

  /// No description provided for @editLocked.
  ///
  /// In en, this message translates to:
  /// **'This request can no longer be edited.'**
  String get editLocked;

  /// No description provided for @cancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this request?'**
  String get cancelConfirmTitle;

  /// No description provided for @cancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone. Your nonprofit partner will be notified.'**
  String get cancelConfirmBody;

  /// No description provided for @keepRequest.
  ///
  /// In en, this message translates to:
  /// **'Keep request'**
  String get keepRequest;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled.'**
  String get requestCancelled;

  /// No description provided for @notFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Request not found'**
  String get notFoundTitle;

  /// No description provided for @trackTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery status'**
  String get trackTitle;

  /// No description provided for @trackSub.
  ///
  /// In en, this message translates to:
  /// **'Live updates while your delivery is active.'**
  String get trackSub;

  /// No description provided for @trackWay.
  ///
  /// In en, this message translates to:
  /// **'Your delivery is on the way'**
  String get trackWay;

  /// No description provided for @trackNear.
  ///
  /// In en, this message translates to:
  /// **'Your delivery is nearby'**
  String get trackNear;

  /// No description provided for @trackEtaLine.
  ///
  /// In en, this message translates to:
  /// **'Estimated arrival: 20–30 minutes'**
  String get trackEtaLine;

  /// No description provided for @trackEtaNear.
  ///
  /// In en, this message translates to:
  /// **'Estimated arrival: under 5 minutes'**
  String get trackEtaNear;

  /// No description provided for @trackEst.
  ///
  /// In en, this message translates to:
  /// **'Estimated'**
  String get trackEst;

  /// No description provided for @trackDist.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get trackDist;

  /// No description provided for @trackPrivacy.
  ///
  /// In en, this message translates to:
  /// **'For your privacy, driver details and exact routes are not shown. You\'ll be notified when your delivery arrives.'**
  String get trackPrivacy;

  /// No description provided for @trackDelayedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your delivery is delayed'**
  String get trackDelayedTitle;

  /// No description provided for @trackDelayedBody.
  ///
  /// In en, this message translates to:
  /// **'Your nonprofit partner is working on a new arrival time. You\'ll be notified as soon as it updates.'**
  String get trackDelayedBody;

  /// No description provided for @trackUnavailTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery unavailable'**
  String get trackUnavailTitle;

  /// No description provided for @trackUnavailBody.
  ///
  /// In en, this message translates to:
  /// **'Delivery could not be completed for this request. Pickup may be available instead — contact your nonprofit partner.'**
  String get trackUnavailBody;

  /// No description provided for @trackDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery completed'**
  String get trackDoneTitle;

  /// No description provided for @trackDoneBody.
  ///
  /// In en, this message translates to:
  /// **'Your delivery arrived. Thank you for using Savvi.'**
  String get trackDoneBody;

  /// No description provided for @switchPickup.
  ///
  /// In en, this message translates to:
  /// **'Ask about pickup instead'**
  String get switchPickup;

  /// No description provided for @pkTitle.
  ///
  /// In en, this message translates to:
  /// **'Pickup details'**
  String get pkTitle;

  /// No description provided for @pkSub.
  ///
  /// In en, this message translates to:
  /// **'Your code, window, and location.'**
  String get pkSub;

  /// No description provided for @pkWindow.
  ///
  /// In en, this message translates to:
  /// **'Pickup window'**
  String get pkWindow;

  /// No description provided for @pkLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get pkLocation;

  /// No description provided for @pkShowQr.
  ///
  /// In en, this message translates to:
  /// **'Show pickup QR'**
  String get pkShowQr;

  /// No description provided for @pkQrLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup QR'**
  String get pkQrLabel;

  /// No description provided for @pkCodeSub.
  ///
  /// In en, this message translates to:
  /// **'Show this at the nonprofit location'**
  String get pkCodeSub;

  /// No description provided for @pkWarn.
  ///
  /// In en, this message translates to:
  /// **'Your code is valid for this request only. Don\'t share it with others.'**
  String get pkWarn;

  /// No description provided for @pkReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your pickup is ready'**
  String get pkReadyTitle;

  /// No description provided for @pkReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Bring your code during the pickup window below.'**
  String get pkReadyBody;

  /// No description provided for @pkConfirmedTitle.
  ///
  /// In en, this message translates to:
  /// **'Pickup confirmed'**
  String get pkConfirmedTitle;

  /// No description provided for @pkConfirmedBody.
  ///
  /// In en, this message translates to:
  /// **'Staff scanned your code. Your request is complete.'**
  String get pkConfirmedBody;

  /// No description provided for @pkCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Pickup completed'**
  String get pkCompletedTitle;

  /// No description provided for @pkCompletedBody.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using Savvi.'**
  String get pkCompletedBody;

  /// No description provided for @pkMissedTitle.
  ///
  /// In en, this message translates to:
  /// **'Pickup window closed'**
  String get pkMissedTitle;

  /// No description provided for @pkMissedBody.
  ///
  /// In en, this message translates to:
  /// **'This pickup window has passed. Contact your nonprofit partner to reschedule.'**
  String get pkMissedBody;

  /// No description provided for @pkReschedule.
  ///
  /// In en, this message translates to:
  /// **'Request a new time'**
  String get pkReschedule;

  /// No description provided for @pkReschedSent.
  ///
  /// In en, this message translates to:
  /// **'Your nonprofit partner has been asked to reschedule.'**
  String get pkReschedSent;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Get directions'**
  String get directions;

  /// No description provided for @scanAtCounter.
  ///
  /// In en, this message translates to:
  /// **'Scan at the counter'**
  String get scanAtCounter;

  /// No description provided for @nonprofitLabel.
  ///
  /// In en, this message translates to:
  /// **'Nonprofit'**
  String get nonprofitLabel;

  /// No description provided for @naLabel.
  ///
  /// In en, this message translates to:
  /// **'Not provided'**
  String get naLabel;

  /// No description provided for @protoNote.
  ///
  /// In en, this message translates to:
  /// **'Prototype simulation — not connected to a live backend.'**
  String get protoNote;

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifTitle;

  /// No description provided for @notifSub.
  ///
  /// In en, this message translates to:
  /// **'Request updates and Food Access Alerts.'**
  String get notifSub;

  /// No description provided for @notifEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get notifEmptyTitle;

  /// No description provided for @notifEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any notifications right now.'**
  String get notifEmptyBody;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @clearAllNotifs.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAllNotifs;

  /// No description provided for @markedReadOk.
  ///
  /// In en, this message translates to:
  /// **'All notifications marked read.'**
  String get markedReadOk;

  /// No description provided for @clearedOk.
  ///
  /// In en, this message translates to:
  /// **'Notifications cleared.'**
  String get clearedOk;

  /// No description provided for @clearConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all notifications?'**
  String get clearConfirmTitle;

  /// No description provided for @clearConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This removes every notification from this list. You can\'t undo it.'**
  String get clearConfirmBody;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @prefsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification preferences'**
  String get prefsTitle;

  /// No description provided for @prefsSub.
  ///
  /// In en, this message translates to:
  /// **'Choose how you hear from Savvi.'**
  String get prefsSub;

  /// No description provided for @prefsChNote.
  ///
  /// In en, this message translates to:
  /// **'Savvi uses in-app, push, and email only.'**
  String get prefsChNote;

  /// No description provided for @prefsSaved.
  ///
  /// In en, this message translates to:
  /// **'Notification preference saved'**
  String get prefsSaved;

  /// No description provided for @chInApp.
  ///
  /// In en, this message translates to:
  /// **'In-app'**
  String get chInApp;

  /// No description provided for @chInAppDesc.
  ///
  /// In en, this message translates to:
  /// **'Always on. Shown in your notification center.'**
  String get chInAppDesc;

  /// No description provided for @chPush.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get chPush;

  /// No description provided for @chPushDesc.
  ///
  /// In en, this message translates to:
  /// **'Alerts on your phone when your request changes.'**
  String get chPushDesc;

  /// No description provided for @chEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get chEmail;

  /// No description provided for @chEmailDesc.
  ///
  /// In en, this message translates to:
  /// **'A copy of important updates sent to your email.'**
  String get chEmailDesc;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @contactDetails.
  ///
  /// In en, this message translates to:
  /// **'Contact details'**
  String get contactDetails;

  /// No description provided for @saveContact.
  ///
  /// In en, this message translates to:
  /// **'Save contact details'**
  String get saveContact;

  /// No description provided for @contactSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get contactSaved;

  /// No description provided for @usedInRequests.
  ///
  /// In en, this message translates to:
  /// **'Used in food requests'**
  String get usedInRequests;

  /// No description provided for @activeLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeLabel;

  /// No description provided for @zipNote.
  ///
  /// In en, this message translates to:
  /// **'ZIP code supports food access and service-area reporting.'**
  String get zipNote;

  /// No description provided for @phoneNote.
  ///
  /// In en, this message translates to:
  /// **'Your phone number helps the nonprofit partner coordinate pickup, delivery, or support. SMS notifications are not used for MVP.'**
  String get phoneNote;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Settings & Help'**
  String get settingsHelp;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @householdSize.
  ///
  /// In en, this message translates to:
  /// **'Household size'**
  String get householdSize;

  /// No description provided for @signedOut.
  ///
  /// In en, this message translates to:
  /// **'You have been signed out.'**
  String get signedOut;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign out of Savvi?'**
  String get signOutConfirm;

  /// No description provided for @profileDietSub.
  ///
  /// In en, this message translates to:
  /// **'Sent with food requests for nonprofit packing only.'**
  String get profileDietSub;

  /// No description provided for @profileAlgSub.
  ///
  /// In en, this message translates to:
  /// **'Included so nonprofit staff can pack safely.'**
  String get profileAlgSub;

  /// No description provided for @errFix.
  ///
  /// In en, this message translates to:
  /// **'Please fix the highlighted fields.'**
  String get errFix;

  /// No description provided for @savingLabel.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get savingLabel;

  /// No description provided for @returnToRequest.
  ///
  /// In en, this message translates to:
  /// **'Return to request'**
  String get returnToRequest;

  /// No description provided for @returnToRequestBody.
  ///
  /// In en, this message translates to:
  /// **'You were completing a food request.'**
  String get returnToRequestBody;

  /// No description provided for @householdConfirm.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your household size.'**
  String get householdConfirm;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSub.
  ///
  /// In en, this message translates to:
  /// **'Manage your account and get help.'**
  String get settingsSub;

  /// No description provided for @sPersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get sPersonal;

  /// No description provided for @sPersonalDesc.
  ///
  /// In en, this message translates to:
  /// **'Name, contact, address, household'**
  String get sPersonalDesc;

  /// No description provided for @sLang.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get sLang;

  /// No description provided for @sNotif.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get sNotif;

  /// No description provided for @sNotifDesc.
  ///
  /// In en, this message translates to:
  /// **'Channels and preferences'**
  String get sNotifDesc;

  /// No description provided for @sSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security & password'**
  String get sSecurity;

  /// No description provided for @sSecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'Update your password'**
  String get sSecurityDesc;

  /// No description provided for @sHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get sHelp;

  /// No description provided for @sHelpDesc.
  ///
  /// In en, this message translates to:
  /// **'Contact your nonprofit partner'**
  String get sHelpDesc;

  /// No description provided for @langHelp.
  ///
  /// In en, this message translates to:
  /// **'English and Spanish are available for the MVP. Additional languages are coming soon.'**
  String get langHelp;

  /// No description provided for @langSaved.
  ///
  /// In en, this message translates to:
  /// **'Language updated'**
  String get langSaved;

  /// No description provided for @langEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEnglish;

  /// No description provided for @langSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get langSpanish;

  /// No description provided for @closeAction.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeAction;

  /// No description provided for @signOutBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ll need to sign in again to use Savvi.'**
  String get signOutBody;

  /// No description provided for @securityHelper.
  ///
  /// In en, this message translates to:
  /// **'Use this to request a secure password reset link for your Savvi account.'**
  String get securityHelper;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send password reset link'**
  String get sendResetLink;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent. Check your email for next steps.'**
  String get resetLinkSent;

  /// No description provided for @resetLinkError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t send the reset link. Please try again.'**
  String get resetLinkError;

  /// No description provided for @resetEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset link will be sent to'**
  String get resetEmailLabel;

  /// No description provided for @helpContactPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Contact details will appear here when available.'**
  String get helpContactPlaceholder;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a reset link to your email.'**
  String get resetPasswordSubtitle;

  /// No description provided for @sendResetLinkBtn.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLinkBtn;

  /// No description provided for @checkYourInboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox.'**
  String get checkYourInboxTitle;

  /// No description provided for @resetLinkSentBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to {email}. The link expires in 15 minutes.'**
  String resetLinkSentBody(String email);

  /// No description provided for @iHaveTheLink.
  ///
  /// In en, this message translates to:
  /// **'I have the link →'**
  String get iHaveTheLink;

  /// No description provided for @resendLinkBtn.
  ///
  /// In en, this message translates to:
  /// **'Resend link'**
  String get resendLinkBtn;

  /// No description provided for @resendInSeconds.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String resendInSeconds(int seconds);

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters with uppercase, number, and special character.'**
  String get newPasswordSubtitle;

  /// No description provided for @fieldNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get fieldNewPassword;

  /// No description provided for @hintCreatePassword.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get hintCreatePassword;

  /// No description provided for @fieldConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get fieldConfirmPassword;

  /// No description provided for @hintReenterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter new password'**
  String get hintReenterPassword;

  /// No description provided for @updatePasswordBtn.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePasswordBtn;

  /// No description provided for @passwordMustMeetAllFour.
  ///
  /// In en, this message translates to:
  /// **'Password must meet all four requirements.'**
  String get passwordMustMeetAllFour;

  /// No description provided for @valPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get valPasswordMismatch;

  /// No description provided for @passwordUpdatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get passwordUpdatedTitle;

  /// No description provided for @passwordUpdatedBody.
  ///
  /// In en, this message translates to:
  /// **'Your Savvi password has been changed. Sign in with your new password.'**
  String get passwordUpdatedBody;

  /// No description provided for @goToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Go to sign in'**
  String get goToSignIn;

  /// No description provided for @checkInboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox.'**
  String get checkInboxTitle;

  /// No description provided for @checkInboxBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to {email}. The link expires in 15 minutes.'**
  String checkInboxBody(String email);

  /// No description provided for @resendLink.
  ///
  /// In en, this message translates to:
  /// **'Resend link'**
  String get resendLink;

  /// No description provided for @confirmPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match.'**
  String get confirmPasswordMismatch;
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
