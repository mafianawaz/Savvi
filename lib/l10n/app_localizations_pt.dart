// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'Today';

  @override
  String get relYesterday => 'Yesterday';

  @override
  String get relTomorrow => 'Tomorrow';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionSave => 'Save';

  @override
  String get actionRetry => 'Try again';

  @override
  String get actionClose => 'Close';

  @override
  String get actionGoToProfile => 'Go to Profile';

  @override
  String get stateLoading => 'Loading…';

  @override
  String get stateEmptyTitle => 'Nothing here yet';

  @override
  String get stateErrorTitle => 'Something went wrong';

  @override
  String get stateSuccessTitle => 'Done';

  @override
  String get errNetwork => 'No connection. Check your internet and try again.';

  @override
  String get errTimeout => 'That took too long. Please try again.';

  @override
  String get errUnauthorized => 'Your session ended. Please sign in again.';

  @override
  String get errServer => 'We hit a snag on our end. Please try again shortly.';

  @override
  String get errUnknown => 'Something went wrong. Please try again.';

  @override
  String get valRequired => 'This field is required.';

  @override
  String get valEmail => 'Enter a valid email address.';

  @override
  String get valPhoneRequired => 'Enter your phone number to continue.';

  @override
  String get valPhoneInvalid => 'Enter a valid phone number.';

  @override
  String get valZip => 'Enter a valid ZIP code.';

  @override
  String get phoneHelp =>
      'Phone number is required so the nonprofit partner can safely coordinate pickup, delivery, or support for your food request. Savvi does not use SMS notifications for MVP.';

  @override
  String get unitLbs => 'lbs';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMin => 'min';

  @override
  String get stSubmitted => 'Submitted';

  @override
  String get stNeedsUpdate => 'Needs update';

  @override
  String get stApproved => 'Approved';

  @override
  String get stScheduled => 'Scheduled';

  @override
  String get stPreparing => 'Preparing';

  @override
  String get stReadyPickup => 'Ready for pickup';

  @override
  String get stPickupConfirmed => 'Pickup confirmed';

  @override
  String get stOutForDelivery => 'Out for delivery';

  @override
  String get stNearby => 'Nearby';

  @override
  String get stDelivered => 'Delivered';

  @override
  String get stDelayed => 'Delayed';

  @override
  String get stUnavailable => 'Unavailable';

  @override
  String get stCompleted => 'Completed';

  @override
  String get stMissed => 'Missed';

  @override
  String get stDeclined => 'Declined';

  @override
  String get stCancelled => 'Cancelled';

  @override
  String get actionBack => 'Back';

  @override
  String get actionSignIn => 'Sign In';

  @override
  String get actionSignInShort => 'Sign in';

  @override
  String get signInTagline => 'The Savvi way to request food for families.';

  @override
  String get signInSubtitle =>
      'Members sign in below. New members need a nonprofit access link.';

  @override
  String get fieldEmail => 'Email address';

  @override
  String get fieldPassword => 'Password';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => 'Your password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get newMemberPrompt => 'New member?';

  @override
  String get createWithAccessLink => 'Create account with access link';

  @override
  String get accessTitle => 'Verify your access';

  @override
  String get accessSubtitle =>
      'Paste the link sent by your nonprofit, or scan the QR code at a Savvi enrollment location.';

  @override
  String get accessInviteNote =>
      'Savvi is invite-only. Access links are sent by nonprofit staff and expire after 48 hours.';

  @override
  String get accessPasteLabel => 'Paste access link or code';

  @override
  String get accessPasteHint => 'Paste your link or code';

  @override
  String get accessVerifyBtn => 'Verify Access Link';

  @override
  String get orDivider => 'or';

  @override
  String get accessScanTitle => 'Scan Nonprofit QR Code';

  @override
  String get accessScanSubtitle =>
      'For standard enrollment or trusted onsite auto-approval events';

  @override
  String get accessVerifiedTitle => 'Access verified.';

  @override
  String get accessVerifiedBody =>
      'Complete your account profile to submit for approval.';

  @override
  String get accessOnsiteTitle => 'Trusted onsite enrollment detected.';

  @override
  String get accessOnsiteBody =>
      'Complete your profile to receive instant approval from the nonprofit staff on site.';

  @override
  String get accessContinueBtn => 'Continue to Create Account';

  @override
  String get accessContinueHint =>
      'Verify your access link or scan a QR code to continue.';

  @override
  String get accessErrEmpty => 'Please paste your access link or code first.';

  @override
  String get accessErrExpired =>
      'This access link has expired. Ask your nonprofit for a new one.';

  @override
  String get accessErrUsed => 'This access link has already been used.';

  @override
  String get accessErrInvalid =>
      'We couldn\'t verify that link or code. Check it and try again.';

  @override
  String get qrTitle => 'Scan QR access';

  @override
  String get qrSubtitle =>
      'Point your camera at the nonprofit QR code, or enter the code below.';

  @override
  String get qrScanBtn => 'Open camera to scan';

  @override
  String get qrEnterLabel => 'Enter code manually';

  @override
  String get qrCameraStaged =>
      'Camera scanning is enabled during device setup. For now, enter the code from your nonprofit below.';

  @override
  String get signUpTitle => 'Create your account';

  @override
  String get signUpSubtitle =>
      'Complete your profile to request nonprofit approval.';

  @override
  String get signUpAccessRequiredTitle => 'Access link required';

  @override
  String get signUpAccessRequiredBody =>
      'You need a nonprofit access link or QR code to create a Savvi account.';

  @override
  String get signUpAccessVerifiedTitle => 'Access verified';

  @override
  String get signUpAccessVerifiedBody =>
      'Complete your profile and submit for approval.';

  @override
  String get fieldFirstName => 'First name';

  @override
  String get fieldLastName => 'Last name';

  @override
  String get fieldPhone => 'Phone number';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'Street address';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'City';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'State';

  @override
  String get fieldZip => 'ZIP';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'Household size';

  @override
  String householdPerson(int count) {
    return '$count person';
  }

  @override
  String householdPeople(int count) {
    return '$count people';
  }

  @override
  String get householdPeopleMax => '10+ people';

  @override
  String get pwdReqLength => '8+ characters';

  @override
  String get pwdReqUpper => 'Uppercase';

  @override
  String get pwdReqNumber => 'Number';

  @override
  String get pwdReqSpecial => 'Special character';

  @override
  String get consentText =>
      'I agree to Savvi\'s Privacy Policy and consent to my household data being shared with my nonprofit partner for food support purposes only.';

  @override
  String get consentRequired => 'Please agree to continue.';

  @override
  String get signUpApprovalNote =>
      'Your account must be approved by a nonprofit partner before you can submit food requests.';

  @override
  String get signUpSubmitBtn => 'Submit for Approval';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String get approvalHeroTitle => 'You\'re almost there.';

  @override
  String get approvalHeroBody =>
      'Your profile is with the nonprofit. Approval is just around the corner.';

  @override
  String get stepSubmitted => 'Submitted';

  @override
  String get stepReview => 'Review';

  @override
  String get stepApproved => 'Approved';

  @override
  String get approvalStatusLabel => 'Status';

  @override
  String get approvalPendingBadge => 'Pending Review';

  @override
  String get approvalRow1Title => 'Profile submitted';

  @override
  String get approvalRow1Body => 'Your account details were received today';

  @override
  String get approvalRow2Title => 'Nonprofit review in progress';

  @override
  String get approvalRow2Body => 'Your partner is reviewing your profile now';

  @override
  String get approvalRow3Title => 'Approval decision';

  @override
  String get approvalRow3Body => 'We\'ll notify you by push and email';

  @override
  String get approvalMotivTitle => 'Good things are coming.';

  @override
  String get approvalMotivBody =>
      'Most approvals are completed within 1–2 business days. You\'ll get a notification the moment your access is ready.';

  @override
  String get trackApprovalBtn => 'Track Approval Status';

  @override
  String get backToSignIn => 'Back to Sign In';

  @override
  String get approvedTitle => 'You\'re approved!';

  @override
  String get approvedBody =>
      'Your nonprofit partner approved your account. You can now request food support.';

  @override
  String get approvedCta => 'Go to Home';

  @override
  String get declinedTitle => 'Approval not granted';

  @override
  String get declinedBody =>
      'Your nonprofit partner wasn\'t able to approve this account. Please contact them for next steps.';

  @override
  String get needsReviewTitle => 'Additional review needed';

  @override
  String get needsReviewBody =>
      'Your nonprofit partner needs a little more information before approving. They\'ll reach out by push and email.';

  @override
  String get pwdNotMet => 'Password doesn\'t meet all requirements yet.';

  @override
  String get requestIdLabel => 'Request ID';

  @override
  String get catProduce => 'Produce';

  @override
  String get catDairy => 'Dairy';

  @override
  String get catMeatProtein => 'Meat / Protein';

  @override
  String get catPreparedMeals => 'Prepared Meals';

  @override
  String get catBakeryBread => 'Bakery / Bread';

  @override
  String get catPantry => 'Pantry';

  @override
  String get catFrozen => 'Frozen';

  @override
  String get catSnacksBeverages => 'Snacks & Beverages';

  @override
  String get catBabyFood => 'Baby Food';

  @override
  String get catInfantFormula => 'Infant Formula';

  @override
  String get catControlledNote => 'Controlled item — extra review may apply';

  @override
  String get navHome => 'Home';

  @override
  String get navAlerts => 'Alerts';

  @override
  String get navEvents => 'Events';

  @override
  String get navRequest => 'Request';

  @override
  String get navActivity => 'Activity';

  @override
  String get navProfile => 'Profile';

  @override
  String get navSettings => 'Settings';

  @override
  String get greetMorning => 'Good morning';

  @override
  String get greetAfternoon => 'Good afternoon';

  @override
  String get greetEvening => 'Good evening';

  @override
  String get homeCtaTitle => 'Request food support';

  @override
  String get homeCtaBody => 'No lines. Pickup or delivery.';

  @override
  String get homeCtaBtn => 'Request →';

  @override
  String get homeNoActive => 'No active request';

  @override
  String get homeNoActiveBody =>
      'When you request food support, you\'ll track it here.';

  @override
  String etaAway(String eta) {
    return '$eta away';
  }

  @override
  String milesAway(String miles) {
    return '$miles away';
  }

  @override
  String get alertsTitle => 'Events';

  @override
  String get alertsSubtitle =>
      'Food events from your nonprofit partner near you.';

  @override
  String get alertTypeHot => 'Hot Meal Alert';

  @override
  String get alertTypeDist => 'Food Distribution Event';

  @override
  String alertSpotsLeft(int count) {
    return '$count remaining';
  }

  @override
  String get alertRsvpPrompt => 'Select how many you are reserving for.';

  @override
  String get alertRsvpConfirm => 'I\'m Coming';

  @override
  String alertRsvpConfirmed(int count) {
    return 'RSVP confirmed for $count';
  }

  @override
  String get alertRsvpChange => 'Change';

  @override
  String get alertRsvpCancel => 'Cancel RSVP';

  @override
  String get alertsEmpty => 'No alerts right now';

  @override
  String get alertsEmptyBody =>
      'We\'ll notify you when food is available nearby.';

  @override
  String get tryAgain => 'Try again';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get savviMember => 'Savvi member';

  @override
  String get homeSub => 'Your food support, delivered with dignity.';

  @override
  String householdOf(String count) {
    return 'Household of $count';
  }

  @override
  String get tileAlertsTitle => 'Events';

  @override
  String get tileAlertsSub => 'Food events near you';

  @override
  String get tileReqTitle => 'My Requests';

  @override
  String get tileReqSub => 'Status & pickup details';

  @override
  String get activeRequest => 'Active request';

  @override
  String alertRsvpMax(int count) {
    return 'Max $count · your household size';
  }

  @override
  String get alertRsvpSeeYou => 'We\'ll see you there. Thank you!';

  @override
  String get alertRsvpCancelled => 'Your RSVP was cancelled.';

  @override
  String get alertRsvpSelectFirst =>
      'Please select at least 1 before confirming.';

  @override
  String get reqTitle => 'Request support';

  @override
  String reqStep(int n, int t) {
    return 'Step $n of $t';
  }

  @override
  String get s1Title => 'What would help most?';

  @override
  String get s1Sub => 'Select one or more categories.';

  @override
  String get s2Title => 'Pickup or delivery?';

  @override
  String get s2Sub => 'Choose how you\'d like to receive your support.';

  @override
  String get s3Title => 'Household & Contact';

  @override
  String get s3Sub =>
      'These come from your profile. Update them there if anything has changed.';

  @override
  String get s4Title => 'Review your request';

  @override
  String get s4Sub => 'Check everything before you submit.';

  @override
  String get s5Title => 'Review your request';

  @override
  String get s5Sub => 'Check everything before you submit.';

  @override
  String get stepNext => 'Next';

  @override
  String get stepBack => 'Back';

  @override
  String get methodPickup => 'Pickup';

  @override
  String get methodDelivery => 'Delivery';

  @override
  String get pickupDesc =>
      'Collect with your pickup code at the nonprofit location.';

  @override
  String get deliveryDesc =>
      'Delivered to your address. Live tracking in the app.';

  @override
  String get controlledItem => 'Controlled item';

  @override
  String get formulaNote =>
      'Infant Formula availability depends on nonprofit approval, sealed packaging, expiration date, and program eligibility.';

  @override
  String get formulaAck => 'I understand';

  @override
  String get notesLabel => 'Notes for the nonprofit';

  @override
  String get notesHint => 'Anything helpful for the nonprofit to know?';

  @override
  String get fromProfile => 'From your profile';

  @override
  String get editInProfile => 'Edit in Settings';

  @override
  String get editInSettings => 'Edit in Settings';

  @override
  String get rvDietNote =>
      'Dietary preferences and allergens come from your profile. To update them, go to Settings.';

  @override
  String get householdSizeNote =>
      'To update household size, go to Settings. Defaults to your profile. You can change it for this request only.';

  @override
  String get dietTitle => 'Diet Preferences';

  @override
  String get allergensTitle => 'Allergens';

  @override
  String get dSenior => 'Senior-friendly foods';

  @override
  String get dLowSodium => 'Low sodium';

  @override
  String get dDiabetic => 'Diabetic-friendly';

  @override
  String get dVegetarian => 'Vegetarian';

  @override
  String get dVegan => 'Vegan';

  @override
  String get dHalal => 'Halal-friendly';

  @override
  String get dNoPork => 'No pork';

  @override
  String get dGlutenFree => 'Gluten-free';

  @override
  String get gPeanuts => 'Peanuts';

  @override
  String get gTreeNuts => 'Tree nuts';

  @override
  String get gMilk => 'Milk / Dairy';

  @override
  String get gEggs => 'Eggs';

  @override
  String get gSoy => 'Soy';

  @override
  String get gWheat => 'Wheat / Gluten';

  @override
  String get gFish => 'Fish';

  @override
  String get gShellfish => 'Shellfish';

  @override
  String get gSesame => 'Sesame';

  @override
  String get rvCats => 'Categories';

  @override
  String get rvMethod => 'Method';

  @override
  String get rvHousehold => 'Household';

  @override
  String get rvContact => 'Contact';

  @override
  String get rvAddress => 'Address';

  @override
  String get rvDiet => 'Dietary';

  @override
  String get rvAlg => 'Allergens';

  @override
  String get rvNotes => 'Notes';

  @override
  String get rvNone => 'None';

  @override
  String get submitRequest => 'Submit Request';

  @override
  String get reqOkTitle => 'Request submitted.';

  @override
  String reqOkBody(String np) {
    return '$np will review and confirm your request. You\'ll get a notification with the decision.';
  }

  @override
  String get viewRequest => 'View request';

  @override
  String get backHome => 'Back to home';

  @override
  String get errNoCat => 'Select at least one food category.';

  @override
  String get errNoMethod => 'Choose pickup or delivery.';

  @override
  String get deliveryUnavail =>
      'Delivery is not available for this request right now. Pickup may still be available.';

  @override
  String get deliveryChecking => 'Checking delivery availability…';

  @override
  String get deliveryAvailError =>
      'Couldn\'t check delivery availability. Try again.';

  @override
  String get actTitle => 'My Requests';

  @override
  String get actSub => 'Pickup codes, delivery status, and history.';

  @override
  String get tabActive => 'Active';

  @override
  String get tabHistory => 'History';

  @override
  String get tabAll => 'All';

  @override
  String get actEmptyTitle => 'No requests here';

  @override
  String get actEmptyBody => 'Requests you submit will appear in this list.';

  @override
  String get statusLabel => 'Status';

  @override
  String get weightLabel => 'Weight';

  @override
  String get pickupCodeLabel => 'Pickup code';

  @override
  String get viewDetails => 'View details';

  @override
  String get trackDelivery => 'Track delivery';

  @override
  String get viewPickup => 'View pickup details';

  @override
  String get editRequest => 'Edit request';

  @override
  String get cancelRequest => 'Cancel request';

  @override
  String get editLocked => 'This request can no longer be edited.';

  @override
  String get cancelConfirmTitle => 'Cancel this request?';

  @override
  String get cancelConfirmBody =>
      'This can\'t be undone. Your nonprofit partner will be notified.';

  @override
  String get keepRequest => 'Keep request';

  @override
  String get requestCancelled => 'Request cancelled.';

  @override
  String get notFoundTitle => 'Request not found';

  @override
  String get trackTitle => 'Delivery status';

  @override
  String get trackSub => 'Live updates while your delivery is active.';

  @override
  String get trackWay => 'Your delivery is on the way';

  @override
  String get trackNear => 'Your delivery is nearby';

  @override
  String get trackEtaLine => 'Estimated arrival: 20–30 minutes';

  @override
  String get trackEtaNear => 'Estimated arrival: under 5 minutes';

  @override
  String get trackEst => 'Estimated';

  @override
  String get trackDist => 'Distance';

  @override
  String get trackPrivacy =>
      'For your privacy, driver details and exact routes are not shown. You\'ll be notified when your delivery arrives.';

  @override
  String get trackDelayedTitle => 'Your delivery is delayed';

  @override
  String get trackDelayedBody =>
      'Your nonprofit partner is working on a new arrival time. You\'ll be notified as soon as it updates.';

  @override
  String get trackUnavailTitle => 'Delivery unavailable';

  @override
  String get trackUnavailBody =>
      'Delivery could not be completed for this request. Pickup may be available instead — contact your nonprofit partner.';

  @override
  String get trackDoneTitle => 'Delivery completed';

  @override
  String get trackDoneBody =>
      'Your delivery arrived. Thank you for using Savvi.';

  @override
  String get switchPickup => 'Ask about pickup instead';

  @override
  String get pkTitle => 'Pickup details';

  @override
  String get pkSub => 'Your code, window, and location.';

  @override
  String get pkWindow => 'Pickup window';

  @override
  String get pkLocation => 'Pickup location';

  @override
  String get pkShowQr => 'Show pickup QR';

  @override
  String get pkQrLabel => 'Pickup QR';

  @override
  String get pkCodeSub => 'Show this at the nonprofit location';

  @override
  String get pkWarn =>
      'Your code is valid for this request only. Don\'t share it with others.';

  @override
  String get pkReadyTitle => 'Your pickup is ready';

  @override
  String get pkReadyBody => 'Bring your code during the pickup window below.';

  @override
  String get pkConfirmedTitle => 'Pickup confirmed';

  @override
  String get pkConfirmedBody =>
      'Staff scanned your code. Your request is complete.';

  @override
  String get pkCompletedTitle => 'Pickup completed';

  @override
  String get pkCompletedBody => 'Thank you for using Savvi.';

  @override
  String get pkMissedTitle => 'Pickup window closed';

  @override
  String get pkMissedBody =>
      'This pickup window has passed. Contact your nonprofit partner to reschedule.';

  @override
  String get pkReschedule => 'Request a new time';

  @override
  String get pkReschedSent =>
      'Your nonprofit partner has been asked to reschedule.';

  @override
  String get directions => 'Get Directions';

  @override
  String get scanAtCounter => 'Scan at the counter';

  @override
  String get nonprofitLabel => 'Nonprofit';

  @override
  String get naLabel => 'Not provided';

  @override
  String get protoNote =>
      'Prototype simulation — not connected to a live backend.';

  @override
  String get notifTitle => 'Notifications';

  @override
  String get notifSub => 'Request updates and Food Access Alerts.';

  @override
  String get notifEmptyTitle => 'You\'re all caught up';

  @override
  String get notifEmptyBody => 'You don\'t have any notifications right now.';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get clearAllNotifs => 'Clear all';

  @override
  String get markedReadOk => 'All notifications marked read.';

  @override
  String get clearedOk => 'Notifications cleared.';

  @override
  String get clearConfirmTitle => 'Clear all notifications?';

  @override
  String get clearConfirmBody =>
      'This removes every notification from this list. You can\'t undo it.';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get prefsTitle => 'Notification preferences';

  @override
  String get prefsSub => 'Choose how you hear from Savvi.';

  @override
  String get prefsChNote => 'Savvi uses in-app, push, and email only.';

  @override
  String get prefsSaved => 'Notification preference saved';

  @override
  String get chInApp => 'In-app';

  @override
  String get chInAppDesc => 'Always on. Shown in your notification center.';

  @override
  String get chPush => 'Push notifications';

  @override
  String get chPushDesc => 'Alerts on your phone when your request changes.';

  @override
  String get chEmail => 'Email';

  @override
  String get chEmailDesc => 'A copy of important updates sent to your email.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get personalInformation => 'Personal information';

  @override
  String get contactDetails => 'Contact details';

  @override
  String get saveContact => 'Save contact details';

  @override
  String get contactSaved => 'Profile updated';

  @override
  String get usedInRequests => 'Used in food requests';

  @override
  String get activeLabel => 'Active';

  @override
  String get zipNote =>
      'ZIP code supports food access and service-area reporting.';

  @override
  String get phoneNote =>
      'Your phone number helps the nonprofit partner coordinate pickup, delivery, or support. SMS notifications are not used for MVP.';

  @override
  String get settingsHelp => 'Settings & Help';

  @override
  String get openSettings => 'Open settings';

  @override
  String get householdSize => 'Household size';

  @override
  String get signedOut => 'You have been signed out.';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutConfirm => 'Sign out of Savvi?';

  @override
  String get profileDietSub =>
      'Sent with food requests for nonprofit packing only.';

  @override
  String get profileAlgSub => 'Included so nonprofit staff can pack safely.';

  @override
  String get errFix => 'Please fix the highlighted fields.';

  @override
  String get savingLabel => 'Saving…';

  @override
  String get returnToRequest => 'Return to request';

  @override
  String get returnToRequestBody => 'You were completing a food request.';

  @override
  String get householdConfirm => 'Please confirm your household size.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSub => 'Manage your account and get help.';

  @override
  String get sPersonal => 'Profile';

  @override
  String get sPersonalDesc => 'Name, contact, address, household';

  @override
  String get sLang => 'Language';

  @override
  String get sNotif => 'Notifications';

  @override
  String get sNotifDesc => 'Channels and preferences';

  @override
  String get sSecurity => 'Security & Password';

  @override
  String get sSecurityDesc => 'Update your password';

  @override
  String get sHelp => 'Help & Support';

  @override
  String get sHelpDesc => 'Contact your nonprofit partner';

  @override
  String get langHelp =>
      'English and Spanish are available for the MVP. Additional languages are coming soon.';

  @override
  String get langSaved => 'Language updated';

  @override
  String get langEnglish => 'English';

  @override
  String get langSpanish => 'Español';

  @override
  String get closeAction => 'Close';

  @override
  String get signOutBody => 'You\'ll need to sign in again to use Savvi.';

  @override
  String get securityHelper =>
      'Use this to request a secure password reset link for your Savvi account.';

  @override
  String get sendResetLink => 'Send password reset link';

  @override
  String get resetLinkSent =>
      'Password reset link sent. Check your email for next steps.';

  @override
  String get resetLinkError =>
      'We couldn\'t send the reset link. Please try again.';

  @override
  String get resetEmailLabel => 'Reset link will be sent to';

  @override
  String get helpContactPlaceholder =>
      'Contact details will appear here when available.';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get resetPasswordSubtitle =>
      'We\'ll send a 6-digit code to your email.';

  @override
  String get sendResetLinkBtn => 'Send OTP';

  @override
  String get checkYourInboxTitle => 'Check your inbox.';

  @override
  String resetLinkSentBody(String email) {
    return 'We sent a reset link to $email. The link expires in 15 minutes.';
  }

  @override
  String get iHaveTheLink => 'I have the link →';

  @override
  String get resendLinkBtn => 'Resend link';

  @override
  String resendInSeconds(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get newPasswordTitle => 'New password';

  @override
  String get newPasswordSubtitle =>
      'At least 8 characters with uppercase, number, and special character.';

  @override
  String get fieldNewPassword => 'New password';

  @override
  String get hintCreatePassword => 'Create a password';

  @override
  String get fieldConfirmPassword => 'Confirm password';

  @override
  String get hintReenterPassword => 'Re-enter new password';

  @override
  String get updatePasswordBtn => 'Update Password';

  @override
  String get passwordMustMeetAllFour =>
      'Password must meet all four requirements.';

  @override
  String get valPasswordMismatch => 'Passwords do not match.';

  @override
  String get passwordUpdatedTitle => 'Password updated.';

  @override
  String get passwordUpdatedBody =>
      'Your Savvi password has been changed. Sign in with your new password.';

  @override
  String get goToSignIn => 'Go to sign in';

  @override
  String get checkInboxTitle => 'Enter verification code';

  @override
  String checkInboxBody(String email) {
    return 'We sent a 6-digit code to $email. Enter it below to continue.';
  }

  @override
  String get resendLink => 'Resend code';

  @override
  String get otpVerifyBtn => 'Verify code';

  @override
  String get otpIncomplete => 'Enter the 6-digit code.';

  @override
  String get otpInvalid => 'That code is invalid or expired. Please try again.';

  @override
  String get otpSendFailed => 'We couldn\'t send the code. Please try again.';

  @override
  String get otpResent => 'A new code has been sent.';

  @override
  String get confirmPasswordMismatch => 'Passwords don\'t match.';

  @override
  String get edit => 'Edit';

  @override
  String get editHouseholdNote =>
      'Household size is managed from your profile for now.';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'Hoje';

  @override
  String get relYesterday => 'Ontem';

  @override
  String get relTomorrow => 'Amanhã';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionSave => 'Salvar';

  @override
  String get actionRetry => 'Tentar novamente';

  @override
  String get actionClose => 'Fechar';

  @override
  String get actionGoToProfile => 'Ir para o perfil';

  @override
  String get stateLoading => 'Carregando…';

  @override
  String get stateEmptyTitle => 'Ainda não há nada aqui';

  @override
  String get stateErrorTitle => 'Algo deu errado';

  @override
  String get stateSuccessTitle => 'Concluído';

  @override
  String get errNetwork =>
      'Sem conexão. Verifique sua internet e tente novamente.';

  @override
  String get errTimeout => 'Isso demorou demais. Tente novamente.';

  @override
  String get errUnauthorized => 'Sua sessão terminou. Entre novamente.';

  @override
  String get errServer => 'Tivemos um problema. Tente novamente em instantes.';

  @override
  String get errUnknown => 'Algo deu errado. Tente novamente.';

  @override
  String get valRequired => 'Este campo é obrigatório.';

  @override
  String get valEmail => 'Digite um endereço de e-mail válido.';

  @override
  String get valPhoneRequired => 'Digite seu telefone para continuar.';

  @override
  String get valPhoneInvalid => 'Digite um telefone válido.';

  @override
  String get valZip => 'Digite um CEP válido.';

  @override
  String get phoneHelp =>
      'O número de telefone é necessário para que a organização sem fins lucrativos possa coordenar com segurança a retirada, a entrega ou o suporte para sua solicitação de alimentos. O Savvi não usa notificações por SMS no MVP.';

  @override
  String get unitLbs => 'lbs';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMin => 'min';

  @override
  String get stSubmitted => 'Enviado';

  @override
  String get stNeedsUpdate => 'Precisa de atualização';

  @override
  String get stApproved => 'Aprovado';

  @override
  String get stScheduled => 'Agendado';

  @override
  String get stPreparing => 'Em preparação';

  @override
  String get stReadyPickup => 'Pronto para retirada';

  @override
  String get stPickupConfirmed => 'Retirada confirmada';

  @override
  String get stOutForDelivery => 'Saiu para entrega';

  @override
  String get stNearby => 'Perto';

  @override
  String get stDelivered => 'Entregue';

  @override
  String get stDelayed => 'Atrasado';

  @override
  String get stUnavailable => 'Indisponível';

  @override
  String get stCompleted => 'Concluído';

  @override
  String get stMissed => 'Não compareceu';

  @override
  String get stDeclined => 'Recusado';

  @override
  String get stCancelled => 'Cancelado';

  @override
  String get actionBack => 'Voltar';

  @override
  String get actionSignIn => 'Entrar';

  @override
  String get actionSignInShort => 'Entrar';

  @override
  String get signInTagline =>
      'O jeito Savvi de solicitar apoio alimentar para famílias.';

  @override
  String get signInSubtitle =>
      'Membros entram abaixo. Novos membros precisam de um link de acesso de uma organização parceira.';

  @override
  String get fieldEmail => 'Endereço de e-mail';

  @override
  String get fieldPassword => 'Senha';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => 'Sua senha';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get newMemberPrompt => 'Novo membro?';

  @override
  String get createWithAccessLink => 'Criar conta com link de acesso';

  @override
  String get accessTitle => 'Verifique seu acesso';

  @override
  String get accessSubtitle =>
      'Cole o link enviado pela organização sem fins lucrativos ou leia o código QR em um local de inscrição do Savvi.';

  @override
  String get accessInviteNote =>
      'O Savvi funciona apenas por convite. Os links de acesso são enviados pela equipe da organização e expiram após 48 horas.';

  @override
  String get accessPasteLabel => 'Cole o link ou código de acesso';

  @override
  String get accessPasteHint => 'Cole seu link ou código';

  @override
  String get accessVerifyBtn => 'Verificar link de acesso';

  @override
  String get orDivider => 'ou';

  @override
  String get accessScanTitle => 'Leia o código QR da organização';

  @override
  String get accessScanSubtitle =>
      'Para inscrições padrão ou eventos confiáveis de aprovação automática no local';

  @override
  String get accessVerifiedTitle => 'Acesso verificado.';

  @override
  String get accessVerifiedBody =>
      'Complete o perfil da sua conta para enviá-lo para aprovação.';

  @override
  String get accessOnsiteTitle => 'Inscrição confiável no local detectada.';

  @override
  String get accessOnsiteBody =>
      'Complete seu perfil para receber aprovação imediata da equipe da organização no local.';

  @override
  String get accessContinueBtn => 'Continuar para criar conta';

  @override
  String get accessContinueHint =>
      'Verifique seu link de acesso ou leia um código QR para continuar.';

  @override
  String get accessErrEmpty => 'Cole primeiro seu link ou código de acesso.';

  @override
  String get accessErrExpired =>
      'Este link de acesso expirou. Peça outro à organização.';

  @override
  String get accessErrUsed => 'Este link de acesso já foi usado.';

  @override
  String get accessErrInvalid =>
      'Não foi possível verificar esse link ou código. Confira e tente novamente.';

  @override
  String get qrTitle => 'Ler QR de acesso';

  @override
  String get qrSubtitle =>
      'Aponte a câmera para o código QR da organização ou digite o código abaixo.';

  @override
  String get qrScanBtn => 'Abrir câmera para ler';

  @override
  String get qrEnterLabel => 'Digitar código manualmente';

  @override
  String get qrCameraStaged =>
      'A leitura pela câmera será ativada durante a configuração do dispositivo. Por enquanto, digite abaixo o código fornecido pela organização.';

  @override
  String get signUpTitle => 'Crie sua conta';

  @override
  String get signUpSubtitle =>
      'Complete seu perfil para solicitar aprovação da organização.';

  @override
  String get signUpAccessRequiredTitle => 'Link de acesso necessário';

  @override
  String get signUpAccessRequiredBody =>
      'Você precisa de um link de acesso ou código QR da organização para criar uma conta Savvi.';

  @override
  String get signUpAccessVerifiedTitle => 'Acesso verificado';

  @override
  String get signUpAccessVerifiedBody =>
      'Complete seu perfil e envie-o para aprovação.';

  @override
  String get fieldFirstName => 'Nome';

  @override
  String get fieldLastName => 'Sobrenome';

  @override
  String get fieldPhone => 'Telefone';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'Endereço';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'Cidade';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'Estado';

  @override
  String get fieldZip => 'CEP';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'Tamanho da família';

  @override
  String householdPerson(int count) {
    return '$count pessoa';
  }

  @override
  String householdPeople(int count) {
    return '$count pessoas';
  }

  @override
  String get householdPeopleMax => '10 pessoas ou mais';

  @override
  String get pwdReqLength => '8 ou mais caracteres';

  @override
  String get pwdReqUpper => 'Letra maiúscula';

  @override
  String get pwdReqNumber => 'Número';

  @override
  String get pwdReqSpecial => 'Caractere especial';

  @override
  String get consentText =>
      'Concordo com a Política de Privacidade do Savvi e autorizo o compartilhamento dos dados da minha família com a organização parceira exclusivamente para fins de apoio alimentar.';

  @override
  String get consentRequired => 'Concorde para continuar.';

  @override
  String get signUpApprovalNote =>
      'Sua conta precisa ser aprovada por uma organização sem fins lucrativos antes que você possa enviar solicitações de alimentos.';

  @override
  String get signUpSubmitBtn => 'Enviar para aprovação';

  @override
  String get haveAccountPrompt => 'Já tem uma conta?';

  @override
  String get approvalHeroTitle => 'Você está quase lá.';

  @override
  String get approvalHeroBody =>
      'Seu perfil está com a organização. A aprovação está próxima.';

  @override
  String get stepSubmitted => 'Enviado';

  @override
  String get stepReview => 'Análise';

  @override
  String get stepApproved => 'Aprovado';

  @override
  String get approvalStatusLabel => 'Situação';

  @override
  String get approvalPendingBadge => 'Aguardando análise';

  @override
  String get approvalRow1Title => 'Perfil enviado';

  @override
  String get approvalRow1Body => 'Os dados da sua conta foram recebidos hoje';

  @override
  String get approvalRow2Title => 'Análise da organização em andamento';

  @override
  String get approvalRow2Body =>
      'Sua organização parceira está analisando seu perfil agora';

  @override
  String get approvalRow3Title => 'Decisão de aprovação';

  @override
  String get approvalRow3Body => 'Enviaremos uma notificação por push e e-mail';

  @override
  String get approvalMotivTitle => 'Boas notícias estão a caminho.';

  @override
  String get approvalMotivBody =>
      'A maioria das aprovações é concluída em 1 a 2 dias úteis. Você receberá uma notificação assim que seu acesso estiver liberado.';

  @override
  String get trackApprovalBtn => 'Acompanhar status da aprovação';

  @override
  String get backToSignIn => 'Voltar para entrar';

  @override
  String get approvedTitle => 'Você foi aprovado!';

  @override
  String get approvedBody =>
      'A organização parceira aprovou sua conta. Agora você pode solicitar apoio alimentar.';

  @override
  String get approvedCta => 'Ir para o início';

  @override
  String get declinedTitle => 'Aprovação não concedida';

  @override
  String get declinedBody =>
      'A organização parceira não pôde aprovar esta conta. Entre em contato com ela para saber os próximos passos.';

  @override
  String get needsReviewTitle => 'É necessária uma análise adicional';

  @override
  String get needsReviewBody =>
      'A organização parceira precisa de mais algumas informações antes de aprovar. Ela entrará em contato por notificação push e e-mail.';

  @override
  String get pwdNotMet => 'A senha ainda não atende a todos os requisitos.';

  @override
  String get requestIdLabel => 'ID da solicitação';

  @override
  String get catProduce => 'Hortifrúti';

  @override
  String get catDairy => 'Laticínios';

  @override
  String get catMeatProtein => 'Carne / Proteína';

  @override
  String get catPreparedMeals => 'Refeições prontas';

  @override
  String get catBakeryBread => 'Padaria / Pães';

  @override
  String get catPantry => 'Alimentos básicos';

  @override
  String get catFrozen => 'Congelados';

  @override
  String get catSnacksBeverages => 'Lanches e bebidas';

  @override
  String get catBabyFood => 'Comida para bebês';

  @override
  String get catInfantFormula => 'Fórmula infantil';

  @override
  String get catControlledNote =>
      'Item controlado — pode exigir análise adicional';

  @override
  String get navHome => 'Início';

  @override
  String get navAlerts => 'Alertas';

  @override
  String get navEvents => 'Eventos';

  @override
  String get navRequest => 'Solicitação';

  @override
  String get navActivity => 'Atividade';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navSettings => 'Configurações';

  @override
  String get greetMorning => 'Bom dia';

  @override
  String get greetAfternoon => 'Boa tarde';

  @override
  String get greetEvening => 'Boa noite';

  @override
  String get homeCtaTitle => 'Solicitar apoio alimentar';

  @override
  String get homeCtaBody => 'Sem filas. Retirada ou entrega.';

  @override
  String get homeCtaBtn => 'Solicitar →';

  @override
  String get homeNoActive => 'Nenhuma solicitação ativa';

  @override
  String get homeNoActiveBody =>
      'Quando você solicitar apoio alimentar, poderá acompanhar tudo aqui.';

  @override
  String etaAway(String eta) {
    return 'a $eta de distância';
  }

  @override
  String milesAway(String miles) {
    return 'a $miles milhas';
  }

  @override
  String get alertsTitle => 'Eventos';

  @override
  String get alertsSubtitle =>
      'Eventos de alimentos da organização parceira perto de você.';

  @override
  String get alertTypeHot => 'Alerta de refeição quente';

  @override
  String get alertTypeDist => 'Evento de distribuição de alimentos';

  @override
  String alertSpotsLeft(int count) {
    return '$count restantes';
  }

  @override
  String get alertRsvpPrompt =>
      'Selecione para quantas pessoas você está reservando.';

  @override
  String get alertRsvpConfirm => 'Vou participar';

  @override
  String alertRsvpConfirmed(int count) {
    return 'Presença confirmada para $count';
  }

  @override
  String get alertRsvpChange => 'Alterar';

  @override
  String get alertRsvpCancel => 'Cancelar presença';

  @override
  String get alertsEmpty => 'Nenhum alerta no momento';

  @override
  String get alertsEmptyBody =>
      'Avisaremos quando houver alimentos disponíveis nas proximidades.';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get savviMember => 'Membro Savvi';

  @override
  String get homeSub => 'Apoio alimentar oferecido com dignidade.';

  @override
  String householdOf(String count) {
    return 'Família de $count pessoas';
  }

  @override
  String get tileAlertsTitle => 'Eventos';

  @override
  String get tileAlertsSub => 'Eventos de alimentos perto de você';

  @override
  String get tileReqTitle => 'Minhas solicitações';

  @override
  String get tileReqSub => 'Status e detalhes da retirada';

  @override
  String get activeRequest => 'Solicitação ativa';

  @override
  String alertRsvpMax(int count) {
    return 'Máximo de $count · tamanho da sua família';
  }

  @override
  String get alertRsvpSeeYou => 'Esperamos você lá. Obrigado!';

  @override
  String get alertRsvpCancelled => 'Sua presença foi cancelada.';

  @override
  String get alertRsvpSelectFirst =>
      'Selecione pelo menos 1 pessoa antes de confirmar.';

  @override
  String get reqTitle => 'Solicitar apoio alimentar';

  @override
  String reqStep(int n, int t) {
    return 'Etapa $n de $t';
  }

  @override
  String get s1Title => 'O que ajudaria mais?';

  @override
  String get s1Sub => 'Selecione uma ou mais categorias.';

  @override
  String get s2Title => 'Retirada ou entrega?';

  @override
  String get s2Sub => 'Escolha como deseja receber seu apoio.';

  @override
  String get s3Title => 'Família e contato';

  @override
  String get s3Sub =>
      'Estas informações vêm do seu perfil. Atualize-as lá se algo tiver mudado.';

  @override
  String get s4Title => 'Revise sua solicitação';

  @override
  String get s4Sub => 'Confira tudo antes de enviar.';

  @override
  String get s5Title => 'Revise sua solicitação';

  @override
  String get s5Sub => 'Confira tudo antes de enviar.';

  @override
  String get stepNext => 'Próximo';

  @override
  String get stepBack => 'Voltar';

  @override
  String get methodPickup => 'Retirada';

  @override
  String get methodDelivery => 'Entrega';

  @override
  String get pickupDesc => 'Retire usando seu código no local da organização.';

  @override
  String get deliveryDesc =>
      'Entrega no seu endereço. Acompanhe em tempo real pelo aplicativo.';

  @override
  String get controlledItem => 'Item controlado';

  @override
  String get formulaNote =>
      'A disponibilidade de fórmula infantil depende da aprovação da organização, da embalagem lacrada, da data de validade e dos critérios de elegibilidade do programa.';

  @override
  String get formulaAck => 'Entendi';

  @override
  String get notesLabel => 'Observações para a organização';

  @override
  String get notesHint => 'Há algo útil que a organização deva saber?';

  @override
  String get fromProfile => 'Do seu perfil';

  @override
  String get editInProfile => 'Editar em Configurações';

  @override
  String get editInSettings => 'Editar em Configurações';

  @override
  String get rvDietNote =>
      'As preferências alimentares e os alérgenos vêm do seu perfil. Para atualizá-los, acesse Configurações.';

  @override
  String get householdSizeNote =>
      'Para atualizar o tamanho da família, acesse Configurações. O valor padrão vem do seu perfil. Você pode alterá-lo apenas para esta solicitação.';

  @override
  String get dietTitle => 'Preferências alimentares';

  @override
  String get allergensTitle => 'Alérgenos';

  @override
  String get dSenior => 'Alimentos adequados para idosos';

  @override
  String get dLowSodium => 'Baixo teor de sódio';

  @override
  String get dDiabetic => 'Adequado para pessoas com diabetes';

  @override
  String get dVegetarian => 'Vegetariano';

  @override
  String get dVegan => 'Vegano';

  @override
  String get dHalal => 'Adequado halal';

  @override
  String get dNoPork => 'Sem carne de porco';

  @override
  String get dGlutenFree => 'Sem glúten';

  @override
  String get gPeanuts => 'Amendoim';

  @override
  String get gTreeNuts => 'Castanhas e nozes';

  @override
  String get gMilk => 'Leite / Laticínios';

  @override
  String get gEggs => 'Ovos';

  @override
  String get gSoy => 'Soja';

  @override
  String get gWheat => 'Trigo / Glúten';

  @override
  String get gFish => 'Peixe';

  @override
  String get gShellfish => 'Frutos do mar com concha';

  @override
  String get gSesame => 'Gergelim';

  @override
  String get rvCats => 'Categorias';

  @override
  String get rvMethod => 'Método';

  @override
  String get rvHousehold => 'Família';

  @override
  String get rvContact => 'Contato';

  @override
  String get rvAddress => 'Endereço';

  @override
  String get rvDiet => 'Alimentação';

  @override
  String get rvAlg => 'Alérgenos';

  @override
  String get rvNotes => 'Observações';

  @override
  String get rvNone => 'Nenhum';

  @override
  String get submitRequest => 'Enviar solicitação';

  @override
  String get reqOkTitle => 'Solicitação enviada.';

  @override
  String reqOkBody(String np) {
    return '$np analisará e confirmará sua solicitação. Você receberá uma notificação com a decisão.';
  }

  @override
  String get viewRequest => 'Ver solicitação';

  @override
  String get backHome => 'Voltar ao início';

  @override
  String get errNoCat => 'Selecione pelo menos uma categoria de alimentos.';

  @override
  String get errNoMethod => 'Escolha retirada ou entrega.';

  @override
  String get deliveryUnavail =>
      'A entrega não está disponível para esta solicitação no momento. A retirada ainda pode estar disponível.';

  @override
  String get deliveryChecking => 'Verificando disponibilidade de entrega…';

  @override
  String get deliveryAvailError =>
      'Não foi possível verificar a disponibilidade da entrega. Tente novamente.';

  @override
  String get actTitle => 'Minhas solicitações';

  @override
  String get actSub => 'Códigos de retirada, status da entrega e histórico.';

  @override
  String get tabActive => 'Ativas';

  @override
  String get tabHistory => 'Histórico';

  @override
  String get tabAll => 'Todas';

  @override
  String get actEmptyTitle => 'Nenhuma solicitação aqui';

  @override
  String get actEmptyBody => 'As solicitações enviadas aparecerão nesta lista.';

  @override
  String get statusLabel => 'Situação';

  @override
  String get weightLabel => 'Peso';

  @override
  String get pickupCodeLabel => 'Código de retirada';

  @override
  String get viewDetails => 'Ver detalhes';

  @override
  String get trackDelivery => 'Acompanhar entrega';

  @override
  String get viewPickup => 'Ver detalhes da retirada';

  @override
  String get editRequest => 'Editar solicitação';

  @override
  String get cancelRequest => 'Cancelar solicitação';

  @override
  String get editLocked => 'Esta solicitação não pode mais ser editada.';

  @override
  String get cancelConfirmTitle => 'Cancelar esta solicitação?';

  @override
  String get cancelConfirmBody =>
      'Esta ação não pode ser desfeita. A organização parceira será notificada.';

  @override
  String get keepRequest => 'Manter solicitação';

  @override
  String get requestCancelled => 'Solicitação cancelada.';

  @override
  String get notFoundTitle => 'Solicitação não encontrada';

  @override
  String get trackTitle => 'Status da entrega';

  @override
  String get trackSub =>
      'Atualizações em tempo real enquanto sua entrega estiver ativa.';

  @override
  String get trackWay => 'Sua entrega está a caminho';

  @override
  String get trackNear => 'Sua entrega está próxima';

  @override
  String get trackEtaLine => 'Previsão de chegada: 20–30 minutos';

  @override
  String get trackEtaNear => 'Previsão de chegada: menos de 5 minutos';

  @override
  String get trackEst => 'Estimativa';

  @override
  String get trackDist => 'Distância';

  @override
  String get trackPrivacy =>
      'Para sua privacidade, os dados do motorista e as rotas exatas não são exibidos. Você receberá uma notificação quando a entrega chegar.';

  @override
  String get trackDelayedTitle => 'Sua entrega está atrasada';

  @override
  String get trackDelayedBody =>
      'A organização parceira está trabalhando em um novo horário de chegada. Você será notificado assim que houver atualização.';

  @override
  String get trackUnavailTitle => 'Entrega indisponível';

  @override
  String get trackUnavailBody =>
      'Não foi possível concluir a entrega desta solicitação. A retirada pode ser uma alternativa — entre em contato com a organização parceira.';

  @override
  String get trackDoneTitle => 'Entrega concluída';

  @override
  String get trackDoneBody => 'Sua entrega chegou. Obrigado por usar o Savvi.';

  @override
  String get switchPickup => 'Perguntar sobre retirada';

  @override
  String get pkTitle => 'Detalhes da retirada';

  @override
  String get pkSub => 'Seu código, horário e local.';

  @override
  String get pkWindow => 'Horário de retirada';

  @override
  String get pkLocation => 'Local de retirada';

  @override
  String get pkShowQr => 'Mostrar QR de retirada';

  @override
  String get pkQrLabel => 'QR de retirada';

  @override
  String get pkCodeSub => 'Mostre este código no local da organização';

  @override
  String get pkWarn =>
      'Seu código é válido apenas para esta solicitação. Não o compartilhe com outras pessoas.';

  @override
  String get pkReadyTitle => 'Sua retirada está pronta';

  @override
  String get pkReadyBody =>
      'Apresente seu código durante o horário de retirada abaixo.';

  @override
  String get pkConfirmedTitle => 'Retirada confirmada';

  @override
  String get pkConfirmedBody =>
      'A equipe leu seu código. Sua solicitação foi concluída.';

  @override
  String get pkCompletedTitle => 'Retirada concluída';

  @override
  String get pkCompletedBody => 'Obrigado por usar o Savvi.';

  @override
  String get pkMissedTitle => 'O horário de retirada terminou';

  @override
  String get pkMissedBody =>
      'O horário de retirada já passou. Entre em contato com a organização parceira para reagendar.';

  @override
  String get pkReschedule => 'Solicitar novo horário';

  @override
  String get pkReschedSent =>
      'Foi solicitado à organização parceira que reagende.';

  @override
  String get directions => 'Como chegar';

  @override
  String get scanAtCounter => 'Leia no balcão';

  @override
  String get nonprofitLabel => 'Organização sem fins lucrativos';

  @override
  String get naLabel => 'Não informado';

  @override
  String get protoNote =>
      'Simulação de protótipo — não conectado a um sistema ativo.';

  @override
  String get notifTitle => 'Notificações';

  @override
  String get notifSub =>
      'Atualizações de solicitações e alertas de acesso a alimentos.';

  @override
  String get notifEmptyTitle => 'Você está em dia';

  @override
  String get notifEmptyBody => 'Você não tem notificações no momento.';

  @override
  String get markAllRead => 'Marcar tudo como lido';

  @override
  String get clearAllNotifs => 'Limpar tudo';

  @override
  String get markedReadOk => 'Todas as notificações foram marcadas como lidas.';

  @override
  String get clearedOk => 'Notificações apagadas.';

  @override
  String get clearConfirmTitle => 'Limpar todas as notificações?';

  @override
  String get clearConfirmBody =>
      'Isso remove todas as notificações desta lista. Não é possível desfazer.';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get prefsTitle => 'Preferências de notificação';

  @override
  String get prefsSub => 'Escolha como receber notícias do Savvi.';

  @override
  String get prefsChNote =>
      'O Savvi usa apenas notificações no app, push e e-mail.';

  @override
  String get prefsSaved => 'Preferências de notificação salvas';

  @override
  String get chInApp => 'No aplicativo';

  @override
  String get chInAppDesc =>
      'Sempre ativadas. Exibidas na central de notificações.';

  @override
  String get chPush => 'Notificações push';

  @override
  String get chPushDesc => 'Alertas no celular quando sua solicitação mudar.';

  @override
  String get chEmail => 'E-mail';

  @override
  String get chEmailDesc =>
      'Uma cópia das atualizações importantes enviada ao seu e-mail.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get personalInformation => 'Informações pessoais';

  @override
  String get contactDetails => 'Dados de contato';

  @override
  String get saveContact => 'Salvar dados de contato';

  @override
  String get contactSaved => 'Perfil atualizado';

  @override
  String get usedInRequests => 'Usado em solicitações de alimentos';

  @override
  String get activeLabel => 'Ativo';

  @override
  String get zipNote =>
      'O CEP ajuda no acesso a alimentos e nos relatórios da área de atendimento.';

  @override
  String get phoneNote =>
      'Seu telefone ajuda a organização parceira a coordenar a retirada, a entrega ou o suporte. As notificações por SMS não são usadas no MVP.';

  @override
  String get settingsHelp => 'Configurações e ajuda';

  @override
  String get openSettings => 'Abrir configurações';

  @override
  String get householdSize => 'Tamanho da família';

  @override
  String get signedOut => 'Você saiu da sua conta.';

  @override
  String get signOut => 'Sair';

  @override
  String get signOutConfirm => 'Sair do Savvi?';

  @override
  String get profileDietSub =>
      'Enviado com solicitações de alimentos apenas para orientar a preparação pela organização.';

  @override
  String get profileAlgSub =>
      'Incluído para que a equipe da organização possa embalar os alimentos com segurança.';

  @override
  String get errFix => 'Corrija os campos destacados.';

  @override
  String get savingLabel => 'Salvando…';

  @override
  String get returnToRequest => 'Voltar à solicitação';

  @override
  String get returnToRequestBody =>
      'Você estava preenchendo uma solicitação de alimentos.';

  @override
  String get householdConfirm => 'Confirme o tamanho da sua família.';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsSub => 'Gerencie sua conta e obtenha ajuda.';

  @override
  String get sPersonal => 'Perfil';

  @override
  String get sPersonalDesc => 'Nome, contato, endereço e família';

  @override
  String get sLang => 'Idioma';

  @override
  String get sNotif => 'Notificações';

  @override
  String get sNotifDesc => 'Canais e preferências';

  @override
  String get sSecurity => 'Segurança e senha';

  @override
  String get sSecurityDesc => 'Atualize sua senha';

  @override
  String get sHelp => 'Ajuda e suporte';

  @override
  String get sHelpDesc => 'Entre em contato com a organização parceira';

  @override
  String get langHelp => 'Escolha o idioma de exibição do Savvi.';

  @override
  String get langSaved => 'Idioma atualizado';

  @override
  String get langEnglish => 'Inglês';

  @override
  String get langSpanish => 'Espanhol';

  @override
  String get closeAction => 'Fechar';

  @override
  String get signOutBody =>
      'Você precisará entrar novamente para usar o Savvi.';

  @override
  String get securityHelper =>
      'Use esta opção para solicitar um link seguro de redefinição de senha da sua conta Savvi.';

  @override
  String get sendResetLink => 'Enviar link para redefinir a senha';

  @override
  String get resetLinkSent =>
      'Link de redefinição de senha enviado. Confira seu e-mail para ver as próximas etapas.';

  @override
  String get resetLinkError =>
      'Não foi possível enviar o link. Tente novamente.';

  @override
  String get resetEmailLabel => 'O link será enviado para';

  @override
  String get helpContactPlaceholder =>
      'Os dados de contato aparecerão aqui quando estiverem disponíveis.';

  @override
  String get resetPasswordTitle => 'Redefinir senha';

  @override
  String get resetPasswordSubtitle =>
      'Enviaremos um código de 6 dígitos para seu e-mail.';

  @override
  String get sendResetLinkBtn => 'Enviar código';

  @override
  String get checkYourInboxTitle => 'Confira sua caixa de entrada.';

  @override
  String resetLinkSentBody(String email) {
    return 'Enviamos um link de redefinição para $email. O link expira em 15 minutos.';
  }

  @override
  String get iHaveTheLink => 'Tenho o link →';

  @override
  String get resendLinkBtn => 'Reenviar link';

  @override
  String resendInSeconds(int seconds) {
    return 'Reenviar em ${seconds}s';
  }

  @override
  String get newPasswordTitle => 'Nova senha';

  @override
  String get newPasswordSubtitle =>
      'Pelo menos 8 caracteres, com letra maiúscula, número e caractere especial.';

  @override
  String get fieldNewPassword => 'Nova senha';

  @override
  String get hintCreatePassword => 'Crie uma senha';

  @override
  String get fieldConfirmPassword => 'Confirmar senha';

  @override
  String get hintReenterPassword => 'Digite novamente a nova senha';

  @override
  String get updatePasswordBtn => 'Atualizar senha';

  @override
  String get passwordMustMeetAllFour =>
      'A senha precisa atender aos quatro requisitos.';

  @override
  String get valPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get passwordUpdatedTitle => 'Senha atualizada.';

  @override
  String get passwordUpdatedBody =>
      'Sua senha do Savvi foi alterada. Entre com sua nova senha.';

  @override
  String get goToSignIn => 'Ir para entrar';

  @override
  String get checkInboxTitle => 'Digite o código de verificação';

  @override
  String checkInboxBody(String email) {
    return 'Enviamos um código de 6 dígitos para $email. Digite-o abaixo para continuar.';
  }

  @override
  String get resendLink => 'Reenviar código';

  @override
  String get otpVerifyBtn => 'Verificar código';

  @override
  String get otpIncomplete => 'Digite o código de 6 dígitos.';

  @override
  String get otpInvalid =>
      'Esse código é inválido ou expirou. Tente novamente.';

  @override
  String get otpSendFailed =>
      'Não foi possível enviar o código. Tente novamente.';

  @override
  String get otpResent => 'Um novo código foi enviado.';

  @override
  String get confirmPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get edit => 'Editar';

  @override
  String get editHouseholdNote =>
      'Por enquanto, o tamanho da família é gerenciado pelo seu perfil.';
}
