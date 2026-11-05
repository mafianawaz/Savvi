// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

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

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => '今天';

  @override
  String get relYesterday => '昨天';

  @override
  String get relTomorrow => '明天';

  @override
  String get actionContinue => '继续';

  @override
  String get actionCancel => '取消';

  @override
  String get actionSave => '保存';

  @override
  String get actionRetry => '重试';

  @override
  String get actionClose => '关闭';

  @override
  String get actionGoToProfile => '前往个人资料';

  @override
  String get stateLoading => '正在加载…';

  @override
  String get stateEmptyTitle => '目前没有内容';

  @override
  String get stateErrorTitle => '出了点问题';

  @override
  String get stateSuccessTitle => '完成';

  @override
  String get errNetwork => '没有网络连接。请检查网络后重试。';

  @override
  String get errTimeout => '等待时间过长，请重试。';

  @override
  String get errUnauthorized => '登录已过期，请重新登录。';

  @override
  String get errServer => '服务器遇到了一点问题，请稍后重试。';

  @override
  String get errUnknown => '出了点问题，请重试。';

  @override
  String get valRequired => '此字段为必填项。';

  @override
  String get valEmail => '请输入有效的电子邮件地址。';

  @override
  String get valPhoneRequired => '请输入电话号码以继续。';

  @override
  String get valPhoneInvalid => '请输入有效的电话号码。';

  @override
  String get valZip => '请输入有效的邮政编码。';

  @override
  String get phoneHelp =>
      '需要提供电话号码，以便非营利合作机构安全地协调您的食品申请取货、配送或支持服务。Savvi 的 MVP 版本不使用短信通知。';

  @override
  String get unitLbs => 'lbs';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMin => 'min';

  @override
  String get stSubmitted => '已提交';

  @override
  String get stNeedsUpdate => '需要更新';

  @override
  String get stApproved => '已批准';

  @override
  String get stScheduled => '已安排';

  @override
  String get stPreparing => '准备中';

  @override
  String get stReadyPickup => '可取货';

  @override
  String get stPickupConfirmed => '已确认取货';

  @override
  String get stOutForDelivery => '配送中';

  @override
  String get stNearby => '即将到达';

  @override
  String get stDelivered => '已送达';

  @override
  String get stDelayed => '已延迟';

  @override
  String get stUnavailable => '不可用';

  @override
  String get stCompleted => '已完成';

  @override
  String get stMissed => '未领取';

  @override
  String get stDeclined => '未获批准';

  @override
  String get stCancelled => '已取消';

  @override
  String get actionBack => '返回';

  @override
  String get actionSignIn => '登录';

  @override
  String get actionSignInShort => '登录';

  @override
  String get signInTagline => 'Savvi 帮助家庭申请食品援助。';

  @override
  String get signInSubtitle => '成员请在下方登录。新成员需要非营利合作机构提供的访问链接。';

  @override
  String get fieldEmail => '电子邮件地址';

  @override
  String get fieldPassword => '密码';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => '您的密码';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get newMemberPrompt => '新成员？';

  @override
  String get createWithAccessLink => '使用访问链接创建账户';

  @override
  String get accessTitle => '验证访问权限';

  @override
  String get accessSubtitle => '粘贴非营利合作机构发送的链接，或扫描 Savvi 登记地点的二维码。';

  @override
  String get accessInviteNote =>
      'Savvi 仅限受邀用户使用。访问链接由非营利机构工作人员发送，并会在 48 小时后过期。';

  @override
  String get accessPasteLabel => '粘贴访问链接或代码';

  @override
  String get accessPasteHint => '粘贴链接或代码';

  @override
  String get accessVerifyBtn => '验证访问链接';

  @override
  String get orDivider => '或';

  @override
  String get accessScanTitle => '扫描非营利机构二维码';

  @override
  String get accessScanSubtitle => '适用于常规登记或可信的现场自动批准活动';

  @override
  String get accessVerifiedTitle => '访问权限已验证。';

  @override
  String get accessVerifiedBody => '请完善账户资料并提交审批。';

  @override
  String get accessOnsiteTitle => '检测到可信的现场登记。';

  @override
  String get accessOnsiteBody => '请完善个人资料，以便获得现场非营利机构工作人员的即时批准。';

  @override
  String get accessContinueBtn => '继续创建账户';

  @override
  String get accessContinueHint => '验证访问链接或扫描二维码以继续。';

  @override
  String get accessErrEmpty => '请先粘贴访问链接或代码。';

  @override
  String get accessErrExpired => '此访问链接已过期。请向非营利机构索取新链接。';

  @override
  String get accessErrUsed => '此访问链接已使用。';

  @override
  String get accessErrInvalid => '无法验证该链接或代码。请检查后重试。';

  @override
  String get qrTitle => '扫描访问二维码';

  @override
  String get qrSubtitle => '将摄像头对准非营利机构的二维码，或在下方输入代码。';

  @override
  String get qrScanBtn => '打开摄像头扫描';

  @override
  String get qrEnterLabel => '手动输入代码';

  @override
  String get qrCameraStaged => '摄像头扫描功能将在设备设置期间启用。目前请在下方输入非营利机构提供的代码。';

  @override
  String get signUpTitle => '创建账户';

  @override
  String get signUpSubtitle => '完善个人资料以申请非营利机构批准。';

  @override
  String get signUpAccessRequiredTitle => '需要访问链接';

  @override
  String get signUpAccessRequiredBody => '您需要非营利机构提供的访问链接或二维码才能创建 Savvi 账户。';

  @override
  String get signUpAccessVerifiedTitle => '访问权限已验证';

  @override
  String get signUpAccessVerifiedBody => '请完善个人资料并提交审批。';

  @override
  String get fieldFirstName => '名字';

  @override
  String get fieldLastName => '姓氏';

  @override
  String get fieldPhone => '电话号码';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => '街道地址';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => '城市';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => '州';

  @override
  String get fieldZip => '邮政编码';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => '家庭人数';

  @override
  String householdPerson(int count) {
    return '$count 人';
  }

  @override
  String householdPeople(int count) {
    return '$count 人';
  }

  @override
  String get householdPeopleMax => '10 人以上';

  @override
  String get pwdReqLength => '至少 8 个字符';

  @override
  String get pwdReqUpper => '大写字母';

  @override
  String get pwdReqNumber => '数字';

  @override
  String get pwdReqSpecial => '特殊字符';

  @override
  String get consentText => '我同意 Savvi 的隐私政策，并同意仅为食品援助目的将我家庭的数据分享给非营利合作机构。';

  @override
  String get consentRequired => '请同意后继续。';

  @override
  String get signUpApprovalNote => '您的账户必须先获得非营利合作机构批准，才能提交食品申请。';

  @override
  String get signUpSubmitBtn => '提交审批';

  @override
  String get haveAccountPrompt => '已有账户？';

  @override
  String get approvalHeroTitle => '马上就好了。';

  @override
  String get approvalHeroBody => '您的资料已提交给非营利机构，审批即将完成。';

  @override
  String get stepSubmitted => '已提交';

  @override
  String get stepReview => '审核中';

  @override
  String get stepApproved => '已批准';

  @override
  String get approvalStatusLabel => '状态';

  @override
  String get approvalPendingBadge => '等待审核';

  @override
  String get approvalRow1Title => '已提交个人资料';

  @override
  String get approvalRow1Body => '我们今天已收到您的账户资料';

  @override
  String get approvalRow2Title => '非营利机构正在审核';

  @override
  String get approvalRow2Body => '您的合作机构正在审核您的个人资料';

  @override
  String get approvalRow3Title => '审批决定';

  @override
  String get approvalRow3Body => '我们会通过推送通知和电子邮件告知您';

  @override
  String get approvalMotivTitle => '好消息即将到来。';

  @override
  String get approvalMotivBody => '大多数审批会在 1–2 个工作日内完成。访问权限准备就绪后，您会立即收到通知。';

  @override
  String get trackApprovalBtn => '查看审批状态';

  @override
  String get backToSignIn => '返回登录';

  @override
  String get approvedTitle => '您已获批准！';

  @override
  String get approvedBody => '非营利合作机构已批准您的账户。现在您可以申请食品援助。';

  @override
  String get approvedCta => '返回首页';

  @override
  String get declinedTitle => '未获批准';

  @override
  String get declinedBody => '非营利合作机构暂时无法批准此账户。请联系该机构了解后续步骤。';

  @override
  String get needsReviewTitle => '需要进一步审核';

  @override
  String get needsReviewBody => '非营利合作机构需要更多信息才能批准您的账户。他们会通过推送通知和电子邮件联系您。';

  @override
  String get pwdNotMet => '密码尚未满足所有要求。';

  @override
  String get requestIdLabel => '申请编号';

  @override
  String get catProduce => '新鲜蔬果';

  @override
  String get catDairy => '乳制品';

  @override
  String get catMeatProtein => '肉类 / 蛋白质';

  @override
  String get catPreparedMeals => '即食餐食';

  @override
  String get catBakeryBread => '烘焙食品 / 面包';

  @override
  String get catPantry => '储备食品';

  @override
  String get catFrozen => '冷冻食品';

  @override
  String get catSnacksBeverages => '零食和饮料';

  @override
  String get catBabyFood => '婴儿食品';

  @override
  String get catInfantFormula => '婴儿配方奶粉';

  @override
  String get catControlledNote => '受管制物品 — 可能需要额外审核';

  @override
  String get navHome => '首页';

  @override
  String get navAlerts => '提醒';

  @override
  String get navEvents => '活动';

  @override
  String get navRequest => '申请';

  @override
  String get navActivity => '动态';

  @override
  String get navProfile => '个人资料';

  @override
  String get navSettings => '设置';

  @override
  String get greetMorning => '早上好';

  @override
  String get greetAfternoon => '下午好';

  @override
  String get greetEvening => '晚上好';

  @override
  String get homeCtaTitle => '申请食品援助';

  @override
  String get homeCtaBody => '无需排队。可选择取货或配送。';

  @override
  String get homeCtaBtn => '申请 →';

  @override
  String get homeNoActive => '没有进行中的申请';

  @override
  String get homeNoActiveBody => '提交食品援助申请后，您可以在这里查看进度。';

  @override
  String etaAway(String eta) {
    return '距离 $eta';
  }

  @override
  String milesAway(String miles) {
    return '距离 $miles 英里';
  }

  @override
  String get alertsTitle => '活动';

  @override
  String get alertsSubtitle => '查看附近非营利合作机构的食品活动。';

  @override
  String get alertTypeHot => '热餐提醒';

  @override
  String get alertTypeDist => '食品发放活动';

  @override
  String alertSpotsLeft(int count) {
    return '剩余 $count 个名额';
  }

  @override
  String get alertRsvpPrompt => '请选择您要预留的人数。';

  @override
  String get alertRsvpConfirm => '我会参加';

  @override
  String alertRsvpConfirmed(int count) {
    return '已为 $count 人确认报名';
  }

  @override
  String get alertRsvpChange => '更改';

  @override
  String get alertRsvpCancel => '取消报名';

  @override
  String get alertsEmpty => '目前没有提醒';

  @override
  String get alertsEmptyBody => '附近有食品可领取时，我们会通知您。';

  @override
  String get tryAgain => '重试';

  @override
  String get notificationsTitle => '通知';

  @override
  String get savviMember => 'Savvi 会员';

  @override
  String get homeSub => '以尊严提供食品援助。';

  @override
  String householdOf(String count) {
    return '$count 人家庭';
  }

  @override
  String get tileAlertsTitle => '活动';

  @override
  String get tileAlertsSub => '您附近的食品活动';

  @override
  String get tileReqTitle => '我的申请';

  @override
  String get tileReqSub => '状态和取货详情';

  @override
  String get activeRequest => '进行中的申请';

  @override
  String alertRsvpMax(int count) {
    return '最多 $count 人 · 您的家庭人数';
  }

  @override
  String get alertRsvpSeeYou => '活动现场见，谢谢！';

  @override
  String get alertRsvpCancelled => '您的报名已取消。';

  @override
  String get alertRsvpSelectFirst => '请至少选择 1 人再确认。';

  @override
  String get reqTitle => '申请食品援助';

  @override
  String reqStep(int n, int t) {
    return '第 $n 步，共 $t 步';
  }

  @override
  String get s1Title => '什么最能帮助您？';

  @override
  String get s1Sub => '选择一个或多个类别。';

  @override
  String get s2Title => '自取还是配送？';

  @override
  String get s2Sub => '选择您接收援助的方式。';

  @override
  String get s3Title => '家庭与联系方式';

  @override
  String get s3Sub => '这些信息来自您的个人资料。如有变更，请在个人资料中更新。';

  @override
  String get s4Title => '检查申请信息';

  @override
  String get s4Sub => '提交前请检查所有信息。';

  @override
  String get s5Title => '检查您的申请';

  @override
  String get s5Sub => '提交前请检查所有信息。';

  @override
  String get stepNext => '下一步';

  @override
  String get stepBack => '返回';

  @override
  String get methodPickup => '自取';

  @override
  String get methodDelivery => '配送';

  @override
  String get pickupDesc => '在非营利机构地点出示取货代码领取物品。';

  @override
  String get deliveryDesc => '配送至您的地址。您可以在应用中实时跟踪。';

  @override
  String get controlledItem => '受管制物品';

  @override
  String get formulaNote => '婴儿配方奶粉是否可领取取决于非营利机构的批准、包装是否密封、有效期以及项目资格要求。';

  @override
  String get formulaAck => '我明白了';

  @override
  String get notesLabel => '给非营利机构的备注';

  @override
  String get notesHint => '有什么信息需要告知非营利机构吗？';

  @override
  String get fromProfile => '来自您的个人资料';

  @override
  String get editInProfile => '在设置中编辑';

  @override
  String get editInSettings => '在设置中编辑';

  @override
  String get rvDietNote => '饮食偏好和过敏原来自您的个人资料。如需更新，请前往“设置”。';

  @override
  String get householdSizeNote => '如需更新家庭人数，请前往“设置”。默认值来自您的个人资料，您也可以仅为本次申请更改。';

  @override
  String get dietTitle => '饮食偏好';

  @override
  String get allergensTitle => '过敏原';

  @override
  String get dSenior => '适合老年人的食品';

  @override
  String get dLowSodium => '低钠';

  @override
  String get dDiabetic => '适合糖尿病患者';

  @override
  String get dVegetarian => '素食';

  @override
  String get dVegan => '纯素';

  @override
  String get dHalal => '符合清真要求';

  @override
  String get dNoPork => '不含猪肉';

  @override
  String get dGlutenFree => '无麸质';

  @override
  String get gPeanuts => '花生';

  @override
  String get gTreeNuts => '树坚果';

  @override
  String get gMilk => '牛奶 / 乳制品';

  @override
  String get gEggs => '鸡蛋';

  @override
  String get gSoy => '大豆';

  @override
  String get gWheat => '小麦 / 麸质';

  @override
  String get gFish => '鱼类';

  @override
  String get gShellfish => '贝类海鲜';

  @override
  String get gSesame => '芝麻';

  @override
  String get rvCats => '类别';

  @override
  String get rvMethod => '方式';

  @override
  String get rvHousehold => '家庭';

  @override
  String get rvContact => '联系方式';

  @override
  String get rvAddress => '地址';

  @override
  String get rvDiet => '饮食要求';

  @override
  String get rvAlg => '过敏原';

  @override
  String get rvNotes => '备注';

  @override
  String get rvNone => '无';

  @override
  String get submitRequest => '提交申请';

  @override
  String get reqOkTitle => '申请已提交。';

  @override
  String reqOkBody(String np) {
    return '$np 将审核并确认您的申请。您会收到包含处理结果的通知。';
  }

  @override
  String get viewRequest => '查看申请';

  @override
  String get backHome => '返回首页';

  @override
  String get errNoCat => '请至少选择一个食品类别。';

  @override
  String get errNoMethod => '请选择取货或配送。';

  @override
  String get deliveryUnavail => '此申请目前无法配送，但可能仍可选择取货。';

  @override
  String get deliveryChecking => '正在检查配送是否可用…';

  @override
  String get deliveryAvailError => '无法检查配送可用性，请重试。';

  @override
  String get actTitle => '我的申请';

  @override
  String get actSub => '取货代码、配送状态和历史记录。';

  @override
  String get tabActive => '进行中';

  @override
  String get tabHistory => '历史记录';

  @override
  String get tabAll => '全部';

  @override
  String get actEmptyTitle => '这里没有申请';

  @override
  String get actEmptyBody => '您提交的申请会显示在此列表中。';

  @override
  String get statusLabel => '状态';

  @override
  String get weightLabel => '重量';

  @override
  String get pickupCodeLabel => '自取码';

  @override
  String get viewDetails => '查看详情';

  @override
  String get trackDelivery => '追踪配送';

  @override
  String get viewPickup => '查看自取详情';

  @override
  String get editRequest => '编辑申请';

  @override
  String get cancelRequest => '取消申请';

  @override
  String get editLocked => '此申请已无法编辑。';

  @override
  String get cancelConfirmTitle => '取消此申请？';

  @override
  String get cancelConfirmBody => '此操作无法撤销。非营利合作机构将收到通知。';

  @override
  String get keepRequest => '保留申请';

  @override
  String get requestCancelled => '申请已取消。';

  @override
  String get notFoundTitle => '未找到申请';

  @override
  String get trackTitle => '配送状态';

  @override
  String get trackSub => '配送进行期间的实时更新。';

  @override
  String get trackWay => '您的配送正在途中';

  @override
  String get trackNear => '配送即将到达';

  @override
  String get trackEtaLine => '预计到达时间：20–30 分钟';

  @override
  String get trackEtaNear => '预计到达时间：不到 5 分钟';

  @override
  String get trackEst => '预计';

  @override
  String get trackDist => '距离';

  @override
  String get trackPrivacy => '为保护您的隐私，我们不会显示司机信息和精确路线。配送到达时会通知您。';

  @override
  String get trackDelayedTitle => '您的配送已延迟';

  @override
  String get trackDelayedBody => '非营利合作机构正在确认新的到达时间。更新后会立即通知您。';

  @override
  String get trackUnavailTitle => '配送不可用';

  @override
  String get trackUnavailBody => '此申请的配送无法完成。您可能可以改为取货，请联系非营利合作机构。';

  @override
  String get trackDoneTitle => '配送已完成';

  @override
  String get trackDoneBody => '您的食品已送达。感谢您使用 Savvi。';

  @override
  String get switchPickup => '改为咨询取货';

  @override
  String get pkTitle => '自取详情';

  @override
  String get pkSub => '您的代码、时间段和地点。';

  @override
  String get pkWindow => '自取时间段';

  @override
  String get pkLocation => '自取地点';

  @override
  String get pkShowQr => '显示自取二维码';

  @override
  String get pkQrLabel => '取货二维码';

  @override
  String get pkCodeSub => '请在非营利机构地点出示此代码';

  @override
  String get pkWarn => '此代码仅对本次申请有效。请勿与他人分享。';

  @override
  String get pkReadyTitle => '您的物品已可领取';

  @override
  String get pkReadyBody => '请在下方取货时间段内出示您的代码。';

  @override
  String get pkConfirmedTitle => '取货已确认';

  @override
  String get pkConfirmedBody => '工作人员已扫描您的代码。申请已完成。';

  @override
  String get pkCompletedTitle => '取货已完成';

  @override
  String get pkCompletedBody => '感谢您使用 Savvi。';

  @override
  String get pkMissedTitle => '取货时间已结束';

  @override
  String get pkMissedBody => '取货时间已过。请联系非营利合作机构重新安排时间。';

  @override
  String get pkReschedule => '申请新的时间';

  @override
  String get pkReschedSent => '已请求非营利合作机构重新安排时间。';

  @override
  String get directions => '路线指引';

  @override
  String get scanAtCounter => '在柜台扫描';

  @override
  String get nonprofitLabel => '非营利机构';

  @override
  String get naLabel => '未提供';

  @override
  String get protoNote => '原型模拟 — 尚未连接实时后端。';

  @override
  String get notifTitle => '通知';

  @override
  String get notifSub => '申请更新和食品援助提醒。';

  @override
  String get notifEmptyTitle => '您已查看所有通知';

  @override
  String get notifEmptyBody => '您目前没有通知。';

  @override
  String get markAllRead => '全部标为已读';

  @override
  String get clearAllNotifs => '全部清除';

  @override
  String get markedReadOk => '所有通知均已标记为已读。';

  @override
  String get clearedOk => '通知已清除。';

  @override
  String get clearConfirmTitle => '清除所有通知？';

  @override
  String get clearConfirmBody => '这会从列表中删除所有通知，且无法撤销。';

  @override
  String get cancelAction => '取消';

  @override
  String get prefsTitle => '通知偏好';

  @override
  String get prefsSub => '选择接收 Savvi 消息的方式。';

  @override
  String get prefsChNote => 'Savvi 仅使用应用内通知、推送通知和电子邮件。';

  @override
  String get prefsSaved => '通知偏好已保存';

  @override
  String get chInApp => '应用内';

  @override
  String get chInAppDesc => '始终开启。显示在通知中心。';

  @override
  String get chPush => '推送通知';

  @override
  String get chPushDesc => '申请状态发生变化时在手机上提醒您。';

  @override
  String get chEmail => '电子邮件';

  @override
  String get chEmailDesc => '将重要更新副本发送到您的电子邮箱。';

  @override
  String get profileTitle => '个人资料';

  @override
  String get personalInformation => '个人信息';

  @override
  String get contactDetails => '联系方式';

  @override
  String get saveContact => '保存联系方式';

  @override
  String get contactSaved => '个人资料已更新';

  @override
  String get usedInRequests => '用于食品申请';

  @override
  String get activeLabel => '启用';

  @override
  String get zipNote => '邮政编码用于食品援助服务和服务区域报告。';

  @override
  String get phoneNote => '您的电话号码可帮助非营利合作机构协调取货、配送或支持服务。MVP 版本不使用短信通知。';

  @override
  String get settingsHelp => '设置与帮助';

  @override
  String get openSettings => '打开设置';

  @override
  String get householdSize => '家庭人数';

  @override
  String get signedOut => '您已退出登录。';

  @override
  String get signOut => '退出登录';

  @override
  String get signOutConfirm => '要退出 Savvi 吗？';

  @override
  String get profileDietSub => '仅随食品申请发送，用于协助非营利机构准备食品。';

  @override
  String get profileAlgSub => '提供这些信息可帮助工作人员安全地包装食品。';

  @override
  String get errFix => '请修正突出显示的字段。';

  @override
  String get savingLabel => '正在保存…';

  @override
  String get returnToRequest => '返回申请';

  @override
  String get returnToRequestBody => '您正在填写食品申请。';

  @override
  String get householdConfirm => '请确认您的家庭人数。';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsSub => '管理账户并获取帮助。';

  @override
  String get sPersonal => '个人资料';

  @override
  String get sPersonalDesc => '姓名、联系方式、地址和家庭信息';

  @override
  String get sLang => '语言';

  @override
  String get sNotif => '通知';

  @override
  String get sNotifDesc => '通知渠道和偏好';

  @override
  String get sSecurity => '安全与密码';

  @override
  String get sSecurityDesc => '更新密码';

  @override
  String get sHelp => '帮助与支持';

  @override
  String get sHelpDesc => '联系非营利合作机构';

  @override
  String get langHelp => '选择 Savvi 应用的显示语言。';

  @override
  String get langSaved => '语言已更新';

  @override
  String get langEnglish => '英语';

  @override
  String get langSpanish => '西班牙语';

  @override
  String get closeAction => '关闭';

  @override
  String get signOutBody => '您需要重新登录才能使用 Savvi。';

  @override
  String get securityHelper => '使用此选项请求 Savvi 账户的安全密码重置链接。';

  @override
  String get sendResetLink => '发送密码重置链接';

  @override
  String get resetLinkSent => '密码重置链接已发送。请查看电子邮件以了解后续步骤。';

  @override
  String get resetLinkError => '无法发送重置链接，请重试。';

  @override
  String get resetEmailLabel => '重置链接将发送至';

  @override
  String get helpContactPlaceholder => '有可用的联系方式时，会显示在这里。';

  @override
  String get resetPasswordTitle => '重置密码';

  @override
  String get resetPasswordSubtitle => '我们会向您的电子邮件发送 6 位验证码。';

  @override
  String get sendResetLinkBtn => '发送验证码';

  @override
  String get checkYourInboxTitle => '查看收件箱。';

  @override
  String resetLinkSentBody(String email) {
    return '我们已向 $email 发送重置链接。链接将在 15 分钟后过期。';
  }

  @override
  String get iHaveTheLink => '我有链接 →';

  @override
  String get resendLinkBtn => '重新发送链接';

  @override
  String resendInSeconds(int seconds) {
    return '$seconds 秒后重新发送';
  }

  @override
  String get newPasswordTitle => '新密码';

  @override
  String get newPasswordSubtitle => '至少 8 个字符，并包含大写字母、数字和特殊字符。';

  @override
  String get fieldNewPassword => '新密码';

  @override
  String get hintCreatePassword => '创建密码';

  @override
  String get fieldConfirmPassword => '确认密码';

  @override
  String get hintReenterPassword => '重新输入新密码';

  @override
  String get updatePasswordBtn => '更新密码';

  @override
  String get passwordMustMeetAllFour => '密码必须满足全部四项要求。';

  @override
  String get valPasswordMismatch => '两次输入的密码不一致。';

  @override
  String get passwordUpdatedTitle => '密码已更新。';

  @override
  String get passwordUpdatedBody => '您的 Savvi 密码已更改。请使用新密码登录。';

  @override
  String get goToSignIn => '前往登录';

  @override
  String get checkInboxTitle => '输入验证码';

  @override
  String checkInboxBody(String email) {
    return '我们已向 $email 发送 6 位验证码。请在下方输入以继续。';
  }

  @override
  String get resendLink => '重新发送验证码';

  @override
  String get otpVerifyBtn => '验证代码';

  @override
  String get otpIncomplete => '请输入 6 位验证码。';

  @override
  String get otpInvalid => '验证码无效或已过期，请重试。';

  @override
  String get otpSendFailed => '无法发送验证码，请重试。';

  @override
  String get otpResent => '新的验证码已发送。';

  @override
  String get confirmPasswordMismatch => '两次输入的密码不一致。';

  @override
  String get edit => '编辑';

  @override
  String get editHouseholdNote => '目前，家庭人数由您的个人资料管理。';
}
