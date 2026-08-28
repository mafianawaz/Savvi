// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get s4Title => 'Diet & Allergens';

  @override
  String get s4Sub => 'Sent to the nonprofit for packing only.';

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
  String get editInProfile => 'Edit in profile';

  @override
  String get editInSettings => 'Edit in Settings';

  @override
  String get householdSizeNote =>
      'To update household size, go to Settings. Defaults to your profile. You can change it for this request only.';

  @override
  String get dietTitle => 'Dietary preferences';

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
  String get resetPasswordSubtitle => 'We\'ll send a reset link to your email.';

  @override
  String get sendResetLinkBtn => 'Send Reset Link';

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
  String get checkInboxTitle => 'Check your inbox.';

  @override
  String checkInboxBody(String email) {
    return 'We sent a reset link to $email. The link expires in 15 minutes.';
  }

  @override
  String get resendLink => 'Resend link';

  @override
  String get confirmPasswordMismatch => 'Passwords don\'t match.';

  @override
  String get edit => 'Edit';
}
