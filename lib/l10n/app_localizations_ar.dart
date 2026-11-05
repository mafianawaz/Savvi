// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'اليوم';

  @override
  String get relYesterday => 'أمس';

  @override
  String get relTomorrow => 'غدًا';

  @override
  String get actionContinue => 'متابعة';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get actionSave => 'حفظ';

  @override
  String get actionRetry => 'حاول مرة أخرى';

  @override
  String get actionClose => 'إغلاق';

  @override
  String get actionGoToProfile => 'الانتقال إلى الملف الشخصي';

  @override
  String get stateLoading => 'جارٍ التحميل…';

  @override
  String get stateEmptyTitle => 'لا يوجد شيء هنا بعد';

  @override
  String get stateErrorTitle => 'حدث خطأ ما';

  @override
  String get stateSuccessTitle => 'تم';

  @override
  String get errNetwork => 'لا يوجد اتصال. تحقق من الإنترنت وحاول مرة أخرى.';

  @override
  String get errTimeout => 'استغرق الأمر وقتًا طويلًا. حاول مرة أخرى.';

  @override
  String get errUnauthorized => 'انتهت جلستك. يرجى تسجيل الدخول مجددًا.';

  @override
  String get errServer =>
      'حدثت مشكلة من جانبنا. يُرجى المحاولة مرة أخرى بعد قليل.';

  @override
  String get errUnknown => 'حدث خطأ ما. يُرجى المحاولة مرة أخرى.';

  @override
  String get valRequired => 'هذا الحقل مطلوب.';

  @override
  String get valEmail => 'أدخل بريدًا إلكترونيًا صالحًا.';

  @override
  String get valPhoneRequired => 'أدخل رقم هاتفك للمتابعة.';

  @override
  String get valPhoneInvalid => 'أدخل رقم هاتف صالحًا.';

  @override
  String get valZip => 'أدخل رمز ZIP صالحًا.';

  @override
  String get phoneHelp =>
      'رقم الهاتف مطلوب حتى يتمكن شريك المؤسسة غير الربحية من تنسيق الاستلام أو التوصيل أو دعم طلب الطعام بأمان. لا تستخدم Savvi رسائل SMS في إصدار MVP.';

  @override
  String get unitLbs => 'رطل';

  @override
  String get unitKg => 'كغ';

  @override
  String get unitMi => 'ميل';

  @override
  String get unitMin => 'دقيقة';

  @override
  String get stSubmitted => 'تم الإرسال';

  @override
  String get stNeedsUpdate => 'يتطلب تحديثًا';

  @override
  String get stApproved => 'تمت الموافقة';

  @override
  String get stScheduled => 'تمت الجدولة';

  @override
  String get stPreparing => 'قيد التحضير';

  @override
  String get stReadyPickup => 'جاهز للاستلام';

  @override
  String get stPickupConfirmed => 'تم تأكيد الاستلام';

  @override
  String get stOutForDelivery => 'خرج للتوصيل';

  @override
  String get stNearby => 'بالقرب منك';

  @override
  String get stDelivered => 'تم التوصيل';

  @override
  String get stDelayed => 'متأخر';

  @override
  String get stUnavailable => 'غير متاح';

  @override
  String get stCompleted => 'مكتمل';

  @override
  String get stMissed => 'فات موعده';

  @override
  String get stDeclined => 'مرفوض';

  @override
  String get stCancelled => 'ملغى';

  @override
  String get actionBack => 'رجوع';

  @override
  String get actionSignIn => 'تسجيل الدخول';

  @override
  String get actionSignInShort => 'تسجيل الدخول';

  @override
  String get signInTagline => 'طريقة Savvi لطلب الدعم الغذائي للعائلات.';

  @override
  String get signInSubtitle =>
      'يمكن للأعضاء تسجيل الدخول أدناه. يحتاج الأعضاء الجدد إلى رابط وصول من مؤسسة غير ربحية.';

  @override
  String get fieldEmail => 'البريد الإلكتروني';

  @override
  String get fieldPassword => 'كلمة المرور';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => 'كلمة المرور';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get newMemberPrompt => 'عضو جديد؟';

  @override
  String get createWithAccessLink => 'إنشاء حساب باستخدام رابط الوصول';

  @override
  String get accessTitle => 'تحقق من صلاحية الوصول';

  @override
  String get accessSubtitle =>
      'الصق الرابط الذي أرسلته مؤسستك غير الربحية، أو امسح رمز QR في موقع التسجيل لدى Savvi.';

  @override
  String get accessInviteNote =>
      'يتطلب Savvi دعوة. يرسل موظفو المؤسسة غير الربحية روابط الوصول وتنتهي صلاحيتها بعد 48 ساعة.';

  @override
  String get accessPasteLabel => 'الصق رابط الوصول أو الرمز';

  @override
  String get accessPasteHint => 'الصق الرابط أو الرمز';

  @override
  String get accessVerifyBtn => 'التحقق من رابط الوصول';

  @override
  String get orDivider => 'أو';

  @override
  String get accessScanTitle => 'امسح رمز QR للمؤسسة غير الربحية';

  @override
  String get accessScanSubtitle =>
      'للتسجيل المعتاد أو فعاليات الموافقة الفورية الموثوقة في الموقع';

  @override
  String get accessVerifiedTitle => 'تم التحقق من الوصول.';

  @override
  String get accessVerifiedBody => 'أكمل ملف حسابك لإرساله للموافقة.';

  @override
  String get accessOnsiteTitle => 'تم اكتشاف تسجيل موثوق في الموقع.';

  @override
  String get accessOnsiteBody =>
      'أكمل ملفك للحصول على موافقة فورية من موظفي المؤسسة غير الربحية في الموقع.';

  @override
  String get accessContinueBtn => 'متابعة إنشاء الحساب';

  @override
  String get accessContinueHint =>
      'تحقق من رابط الوصول أو امسح رمز QR للمتابعة.';

  @override
  String get accessErrEmpty => 'يُرجى لصق رابط الوصول أو الرمز أولاً.';

  @override
  String get accessErrExpired =>
      'انتهت صلاحية رابط الوصول. اطلب رابطًا جديدًا من مؤسستك غير الربحية.';

  @override
  String get accessErrUsed => 'تم استخدام رابط الوصول هذا بالفعل.';

  @override
  String get accessErrInvalid =>
      'تعذر التحقق من الرابط أو الرمز. تحقق منه ثم حاول مرة أخرى.';

  @override
  String get qrTitle => 'امسح رمز QR للوصول';

  @override
  String get qrSubtitle =>
      'وجّه الكاميرا إلى رمز QR الخاص بالمؤسسة غير الربحية أو أدخل الرمز أدناه.';

  @override
  String get qrScanBtn => 'فتح الكاميرا للمسح';

  @override
  String get qrEnterLabel => 'أدخل الرمز يدويًا';

  @override
  String get qrCameraStaged =>
      'سيتم تفعيل المسح بالكاميرا أثناء إعداد الجهاز. حاليًا، أدخل الرمز الذي قدمته مؤسستك غير الربحية أدناه.';

  @override
  String get signUpTitle => 'إنشاء حسابك';

  @override
  String get signUpSubtitle =>
      'أكمل ملفك الشخصي لطلب موافقة المؤسسة غير الربحية.';

  @override
  String get signUpAccessRequiredTitle => 'رابط الوصول مطلوب';

  @override
  String get signUpAccessRequiredBody =>
      'تحتاج إلى رابط وصول أو رمز QR من مؤسسة غير ربحية لإنشاء حساب Savvi.';

  @override
  String get signUpAccessVerifiedTitle => 'تم التحقق من الوصول';

  @override
  String get signUpAccessVerifiedBody => 'أكمل ملفك الشخصي وأرسله للموافقة.';

  @override
  String get fieldFirstName => 'الاسم الأول';

  @override
  String get fieldLastName => 'اسم العائلة';

  @override
  String get fieldPhone => 'رقم الهاتف';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'عنوان الشارع';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'المدينة';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'الولاية';

  @override
  String get fieldZip => 'رمز ZIP';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'حجم الأسرة';

  @override
  String householdPerson(int count) {
    return 'شخص واحد ($count)';
  }

  @override
  String householdPeople(int count) {
    return '$count أشخاص';
  }

  @override
  String get householdPeopleMax => '10 أشخاص أو أكثر';

  @override
  String get pwdReqLength => '8 أحرف أو أكثر';

  @override
  String get pwdReqUpper => 'حرف كبير';

  @override
  String get pwdReqNumber => 'رقم';

  @override
  String get pwdReqSpecial => 'رمز خاص';

  @override
  String get consentText =>
      'أوافق على سياسة الخصوصية لدى Savvi وأوافق على مشاركة بيانات أسرتي مع المؤسسة غير الربحية الشريكة لأغراض دعم الغذاء فقط.';

  @override
  String get consentRequired => 'يُرجى الموافقة للمتابعة.';

  @override
  String get signUpApprovalNote =>
      'يجب أن توافق المؤسسة غير الربحية الشريكة على حسابك قبل أن تتمكن من إرسال طلبات الطعام.';

  @override
  String get signUpSubmitBtn => 'إرسال للموافقة';

  @override
  String get haveAccountPrompt => 'هل لديك حساب بالفعل؟';

  @override
  String get approvalHeroTitle => 'أوشكت على الانتهاء.';

  @override
  String get approvalHeroBody =>
      'ملفك الشخصي لدى المؤسسة غير الربحية للمراجعة. ستصدر الموافقة قريبًا.';

  @override
  String get stepSubmitted => 'تم الإرسال';

  @override
  String get stepReview => 'قيد المراجعة';

  @override
  String get stepApproved => 'تمت الموافقة';

  @override
  String get approvalStatusLabel => 'الحالة';

  @override
  String get approvalPendingBadge => 'بانتظار المراجعة';

  @override
  String get approvalRow1Title => 'تم إرسال الملف الشخصي';

  @override
  String get approvalRow1Body => 'تم استلام تفاصيل حسابك اليوم';

  @override
  String get approvalRow2Title => 'مراجعة المؤسسة غير الربحية جارية';

  @override
  String get approvalRow2Body => 'يراجع شريكك ملفك الشخصي الآن';

  @override
  String get approvalRow3Title => 'قرار الموافقة';

  @override
  String get approvalRow3Body => 'سنخطرك عبر إشعار فوري والبريد الإلكتروني';

  @override
  String get approvalMotivTitle => 'أمور جيدة قادمة.';

  @override
  String get approvalMotivBody =>
      'تُستكمل معظم الموافقات خلال يوم إلى يومي عمل. ستتلقى إشعارًا فور تفعيل إمكانية الوصول.';

  @override
  String get trackApprovalBtn => 'تتبّع حالة الموافقة';

  @override
  String get backToSignIn => 'العودة إلى تسجيل الدخول';

  @override
  String get approvedTitle => 'تمت الموافقة عليك!';

  @override
  String get approvedBody =>
      'وافقت المؤسسة غير الربحية الشريكة على حسابك. يمكنك الآن طلب دعم الطعام.';

  @override
  String get approvedCta => 'الانتقال إلى الصفحة الرئيسية';

  @override
  String get declinedTitle => 'لم تتم الموافقة';

  @override
  String get declinedBody =>
      'تعذّر على شريكك من المنظمات غير الربحية الموافقة على هذا الحساب. يُرجى التواصل معه لمعرفة الخطوات التالية.';

  @override
  String get needsReviewTitle => 'يلزم إجراء مراجعة إضافية';

  @override
  String get needsReviewBody =>
      'يحتاج شريكك من المنظمات غير الربحية إلى مزيد من المعلومات قبل الموافقة. سيتواصل معك عبر الإشعارات والبريد الإلكتروني.';

  @override
  String get pwdNotMet => 'كلمة المرور لا تستوفي جميع المتطلبات بعد.';

  @override
  String get requestIdLabel => 'رقم الطلب';

  @override
  String get catProduce => 'الخضروات والفواكه';

  @override
  String get catDairy => 'منتجات الألبان';

  @override
  String get catMeatProtein => 'اللحوم / البروتين';

  @override
  String get catPreparedMeals => 'وجبات جاهزة';

  @override
  String get catBakeryBread => 'المخبوزات / الخبز';

  @override
  String get catPantry => 'مواد غذائية أساسية';

  @override
  String get catFrozen => 'أطعمة مجمدة';

  @override
  String get catSnacksBeverages => 'وجبات خفيفة ومشروبات';

  @override
  String get catBabyFood => 'طعام الأطفال';

  @override
  String get catInfantFormula => 'حليب الأطفال الصناعي';

  @override
  String get catControlledNote => 'عنصر خاضع للرقابة — قد يتطلب مراجعة إضافية';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navAlerts => 'التنبيهات';

  @override
  String get navEvents => 'الفعاليات';

  @override
  String get navRequest => 'طلب';

  @override
  String get navActivity => 'النشاط';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get greetMorning => 'صباح الخير';

  @override
  String get greetAfternoon => 'مساء الخير';

  @override
  String get greetEvening => 'مساء الخير';

  @override
  String get homeCtaTitle => 'طلب دعم الطعام';

  @override
  String get homeCtaBody => 'دون طوابير. استلام أو توصيل.';

  @override
  String get homeCtaBtn => 'طلب ←';

  @override
  String get homeNoActive => 'لا توجد طلبات نشطة';

  @override
  String get homeNoActiveBody => 'عند طلب دعم الطعام، يمكنك تتبعه هنا.';

  @override
  String etaAway(String eta) {
    return 'يبعد $eta';
  }

  @override
  String milesAway(String miles) {
    return 'يبعد $miles';
  }

  @override
  String get alertsTitle => 'الفعاليات';

  @override
  String get alertsSubtitle => 'فعاليات الطعام من المؤسسة الشريكة بالقرب منك.';

  @override
  String get alertTypeHot => 'تنبيه وجبة ساخنة';

  @override
  String get alertTypeDist => 'فعالية توزيع الطعام';

  @override
  String alertSpotsLeft(int count) {
    return 'متبقٍ $count';
  }

  @override
  String get alertRsvpPrompt => 'حدد عدد الأشخاص الذين تريد تسجيلهم.';

  @override
  String get alertRsvpConfirm => 'سأحضر';

  @override
  String alertRsvpConfirmed(int count) {
    return 'تم تأكيد التسجيل لـ $count';
  }

  @override
  String get alertRsvpChange => 'تغيير';

  @override
  String get alertRsvpCancel => 'إلغاء التسجيل';

  @override
  String get alertsEmpty => 'لا توجد تنبيهات الآن';

  @override
  String get alertsEmptyBody => 'سنخطرك عند توفر الطعام بالقرب منك.';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get savviMember => 'عضو Savvi';

  @override
  String get homeSub => 'دعم غذائي يُقدَّم بكرامة.';

  @override
  String householdOf(String count) {
    return 'أسرة مكوّنة من $count أفراد';
  }

  @override
  String get tileAlertsTitle => 'الفعاليات';

  @override
  String get tileAlertsSub => 'فعاليات الطعام بالقرب منك';

  @override
  String get tileReqTitle => 'طلباتي';

  @override
  String get tileReqSub => 'الحالة وتفاصيل الاستلام';

  @override
  String get activeRequest => 'طلب نشط';

  @override
  String alertRsvpMax(int count) {
    return 'الحد الأقصى $count · حجم أسرتك';
  }

  @override
  String get alertRsvpSeeYou => 'سنراك هناك. شكرًا لك!';

  @override
  String get alertRsvpCancelled => 'تم إلغاء تسجيلك.';

  @override
  String get alertRsvpSelectFirst =>
      'يُرجى اختيار شخص واحد على الأقل قبل التأكيد.';

  @override
  String get reqTitle => 'طلب الدعم الغذائي';

  @override
  String reqStep(int n, int t) {
    return 'الخطوة $n من $t';
  }

  @override
  String get s1Title => 'ما الذي سيساعدك أكثر؟';

  @override
  String get s1Sub => 'اختر فئة واحدة أو أكثر.';

  @override
  String get s2Title => 'استلام أم توصيل؟';

  @override
  String get s2Sub => 'اختر الطريقة التي تفضلها للحصول على الدعم.';

  @override
  String get s3Title => 'الأسرة وبيانات الاتصال';

  @override
  String get s3Sub =>
      'هذه المعلومات مأخوذة من ملفك الشخصي. حدّثها هناك إذا طرأ أي تغيير.';

  @override
  String get s4Title => 'مراجعة طلبك';

  @override
  String get s4Sub => 'تحقق من جميع التفاصيل قبل الإرسال.';

  @override
  String get s5Title => 'مراجعة طلبك';

  @override
  String get s5Sub => 'تحقق من جميع التفاصيل قبل الإرسال.';

  @override
  String get stepNext => 'التالي';

  @override
  String get stepBack => 'رجوع';

  @override
  String get methodPickup => 'استلام';

  @override
  String get methodDelivery => 'توصيل';

  @override
  String get pickupDesc =>
      'استلم باستخدام رمز الاستلام في موقع المؤسسة غير الربحية.';

  @override
  String get deliveryDesc =>
      'سيتم التوصيل إلى عنوانك. تتبع مباشر داخل التطبيق.';

  @override
  String get controlledItem => 'عنصر خاضع للرقابة';

  @override
  String get formulaNote =>
      'يعتمد توفر حليب الأطفال الصناعي على موافقة المنظمة غير الربحية، وسلامة العبوة وإغلاقها، وتاريخ الصلاحية، واستيفاء شروط البرنامج.';

  @override
  String get formulaAck => 'أفهم';

  @override
  String get notesLabel => 'ملاحظات للمؤسسة غير الربحية';

  @override
  String get notesHint =>
      'هل هناك أي معلومات مفيدة ينبغي أن تعرفها المؤسسة غير الربحية؟';

  @override
  String get fromProfile => 'من ملفك الشخصي';

  @override
  String get editInProfile => 'تعديل في الإعدادات';

  @override
  String get editInSettings => 'تعديل في الإعدادات';

  @override
  String get rvDietNote =>
      'تأتي التفضيلات الغذائية ومسببات الحساسية من ملفك الشخصي. لتحديثها، انتقل إلى الإعدادات.';

  @override
  String get householdSizeNote =>
      'لتحديث حجم الأسرة، انتقل إلى الإعدادات. القيمة الافتراضية مأخوذة من ملفك الشخصي، ويمكنك تغييرها لهذا الطلب فقط.';

  @override
  String get dietTitle => 'التفضيلات الغذائية';

  @override
  String get allergensTitle => 'مسببات الحساسية';

  @override
  String get dSenior => 'أطعمة مناسبة لكبار السن';

  @override
  String get dLowSodium => 'قليل الصوديوم';

  @override
  String get dDiabetic => 'مناسب لمرضى السكري';

  @override
  String get dVegetarian => 'نباتي';

  @override
  String get dVegan => 'نباتي صرف';

  @override
  String get dHalal => 'حلال';

  @override
  String get dNoPork => 'من دون لحم خنزير';

  @override
  String get dGlutenFree => 'خالٍ من الغلوتين';

  @override
  String get gPeanuts => 'الفول السوداني';

  @override
  String get gTreeNuts => 'المكسرات الشجرية';

  @override
  String get gMilk => 'الحليب ومشتقاته';

  @override
  String get gEggs => 'البيض';

  @override
  String get gSoy => 'الصويا';

  @override
  String get gWheat => 'القمح والغلوتين';

  @override
  String get gFish => 'السمك';

  @override
  String get gShellfish => 'المحار والقشريات';

  @override
  String get gSesame => 'السمسم';

  @override
  String get rvCats => 'الفئات';

  @override
  String get rvMethod => 'الطريقة';

  @override
  String get rvHousehold => 'الأسرة';

  @override
  String get rvContact => 'جهة الاتصال';

  @override
  String get rvAddress => 'العنوان';

  @override
  String get rvDiet => 'النظام الغذائي';

  @override
  String get rvAlg => 'مسببات الحساسية';

  @override
  String get rvNotes => 'ملاحظات';

  @override
  String get rvNone => 'لا شيء';

  @override
  String get submitRequest => 'إرسال الطلب';

  @override
  String get reqOkTitle => 'تم إرسال الطلب.';

  @override
  String reqOkBody(String np) {
    return 'سيراجع $np طلبك ويؤكده. ستتلقى إشعارًا بالقرار.';
  }

  @override
  String get viewRequest => 'عرض الطلب';

  @override
  String get backHome => 'العودة إلى الرئيسية';

  @override
  String get errNoCat => 'اختر فئة طعام واحدة على الأقل.';

  @override
  String get errNoMethod => 'اختر الاستلام أو التوصيل.';

  @override
  String get deliveryUnavail =>
      'التوصيل غير متاح لهذا الطلب حاليًا. قد يظل الاستلام متاحًا.';

  @override
  String get deliveryChecking => 'جارٍ التحقق من توفر التوصيل…';

  @override
  String get deliveryAvailError =>
      'تعذّر التحقق من توفر التوصيل. حاول مرة أخرى.';

  @override
  String get actTitle => 'طلباتي';

  @override
  String get actSub => 'رموز الاستلام وحالة التوصيل وسجل الطلبات.';

  @override
  String get tabActive => 'نشطة';

  @override
  String get tabHistory => 'السجل';

  @override
  String get tabAll => 'الكل';

  @override
  String get actEmptyTitle => 'لا توجد طلبات هنا';

  @override
  String get actEmptyBody => 'ستظهر الطلبات التي ترسلها في هذه القائمة.';

  @override
  String get statusLabel => 'الحالة';

  @override
  String get weightLabel => 'الوزن';

  @override
  String get pickupCodeLabel => 'رمز الاستلام';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get trackDelivery => 'تتبع التوصيل';

  @override
  String get viewPickup => 'عرض تفاصيل الاستلام';

  @override
  String get editRequest => 'تعديل الطلب';

  @override
  String get cancelRequest => 'إلغاء الطلب';

  @override
  String get editLocked => 'لم يعد بإمكانك تعديل هذا الطلب.';

  @override
  String get cancelConfirmTitle => 'هل تريد إلغاء هذا الطلب؟';

  @override
  String get cancelConfirmBody =>
      'لا يمكن التراجع عن هذا الإجراء. سيتم إخطار المؤسسة غير الربحية الشريكة.';

  @override
  String get keepRequest => 'الاحتفاظ بالطلب';

  @override
  String get requestCancelled => 'تم إلغاء الطلب.';

  @override
  String get notFoundTitle => 'لم يتم العثور على الطلب';

  @override
  String get trackTitle => 'حالة التوصيل';

  @override
  String get trackSub => 'تحديثات مباشرة أثناء توصيل طلبك.';

  @override
  String get trackWay => 'طلبك في الطريق';

  @override
  String get trackNear => 'طلبك قريب';

  @override
  String get trackEtaLine => 'وقت الوصول المتوقع: 20–30 دقيقة';

  @override
  String get trackEtaNear => 'وقت الوصول المتوقع: أقل من 5 دقائق';

  @override
  String get trackEst => 'تقديري';

  @override
  String get trackDist => 'المسافة';

  @override
  String get trackPrivacy =>
      'لحماية خصوصيتك، لا نعرض تفاصيل السائق أو المسارات الدقيقة. سنُخطرك عند وصول طلبك.';

  @override
  String get trackDelayedTitle => 'تأخر التوصيل';

  @override
  String get trackDelayedBody =>
      'يعمل شريكك من المنظمات غير الربحية على تحديد وقت وصول جديد. سنُخطرك فور تحديثه.';

  @override
  String get trackUnavailTitle => 'التوصيل غير متاح';

  @override
  String get trackUnavailBody =>
      'تعذّر إكمال توصيل هذا الطلب. قد يتوفر الاستلام بدلًا منه — تواصل مع شريكك من المنظمات غير الربحية.';

  @override
  String get trackDoneTitle => 'اكتمل التوصيل';

  @override
  String get trackDoneBody => 'وصل طلبك. شكرًا لاستخدامك Savvi.';

  @override
  String get switchPickup => 'اسأل عن الاستلام بدلاً من ذلك';

  @override
  String get pkTitle => 'تفاصيل الاستلام';

  @override
  String get pkSub => 'الرمز والوقت والموقع.';

  @override
  String get pkWindow => 'وقت الاستلام';

  @override
  String get pkLocation => 'موقع الاستلام';

  @override
  String get pkShowQr => 'عرض رمز QR للاستلام';

  @override
  String get pkQrLabel => 'رمز QR للاستلام';

  @override
  String get pkCodeSub => 'اعرض هذا في موقع المؤسسة غير الربحية';

  @override
  String get pkWarn => 'هذا الرمز صالح لهذا الطلب فقط. لا تشاركه مع الآخرين.';

  @override
  String get pkReadyTitle => 'طلبك جاهز للاستلام';

  @override
  String get pkReadyBody => 'أحضر الرمز خلال فترة الاستلام الموضحة أدناه.';

  @override
  String get pkConfirmedTitle => 'تم تأكيد الاستلام';

  @override
  String get pkConfirmedBody => 'مسح الموظفون رمزك. اكتمل طلبك.';

  @override
  String get pkCompletedTitle => 'اكتمل الاستلام';

  @override
  String get pkCompletedBody => 'شكرًا لاستخدام Savvi.';

  @override
  String get pkMissedTitle => 'انتهت فترة الاستلام';

  @override
  String get pkMissedBody =>
      'انتهت فترة الاستلام. تواصل مع شريكك من المنظمات غير الربحية لإعادة الجدولة.';

  @override
  String get pkReschedule => 'طلب موعد جديد';

  @override
  String get pkReschedSent =>
      'طُلب من شريكك من المنظمات غير الربحية إعادة جدولة الاستلام.';

  @override
  String get directions => 'الاتجاهات';

  @override
  String get scanAtCounter => 'امسح عند المنضدة';

  @override
  String get nonprofitLabel => 'مؤسسة غير ربحية';

  @override
  String get naLabel => 'لم يتم التقديم';

  @override
  String get protoNote => 'محاكاة أولية — غير متصلة بنظام خلفي مباشر.';

  @override
  String get notifTitle => 'الإشعارات';

  @override
  String get notifSub => 'تحديثات الطلب وتنبيهات الوصول إلى الطعام.';

  @override
  String get notifEmptyTitle => 'أنت على اطلاع بكل شيء';

  @override
  String get notifEmptyBody => 'ليس لديك أي إشعارات حاليًا.';

  @override
  String get markAllRead => 'تحديد الكل كمقروء';

  @override
  String get clearAllNotifs => 'مسح الكل';

  @override
  String get markedReadOk => 'تم وضع علامة مقروء على جميع الإشعارات.';

  @override
  String get clearedOk => 'تم مسح الإشعارات.';

  @override
  String get clearConfirmTitle => 'هل تريد مسح جميع الإشعارات؟';

  @override
  String get clearConfirmBody =>
      'سيؤدي ذلك إلى إزالة جميع الإشعارات من هذه القائمة. لا يمكن التراجع عن ذلك.';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get prefsTitle => 'تفضيلات الإشعارات';

  @override
  String get prefsSub => 'اختر كيف تتلقى التحديثات من Savvi.';

  @override
  String get prefsChNote =>
      'يستخدم Savvi إشعارات التطبيق والإشعارات الفورية والبريد الإلكتروني فقط.';

  @override
  String get prefsSaved => 'تم حفظ تفضيلات الإشعارات';

  @override
  String get chInApp => 'داخل التطبيق';

  @override
  String get chInAppDesc => 'مفعّل دائمًا. يظهر في مركز الإشعارات.';

  @override
  String get chPush => 'الإشعارات الفورية';

  @override
  String get chPushDesc => 'تنبيهات على هاتفك عند تغيير طلبك.';

  @override
  String get chEmail => 'البريد الإلكتروني';

  @override
  String get chEmailDesc =>
      'نسخة من التحديثات المهمة تُرسل إلى بريدك الإلكتروني.';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get contactDetails => 'بيانات الاتصال';

  @override
  String get saveContact => 'حفظ بيانات الاتصال';

  @override
  String get contactSaved => 'تم تحديث الملف الشخصي';

  @override
  String get usedInRequests => 'يُستخدم في طلبات الطعام';

  @override
  String get activeLabel => 'نشط';

  @override
  String get zipNote =>
      'يساعد الرمز البريدي في تقارير الوصول إلى الغذاء ومناطق الخدمة.';

  @override
  String get phoneNote =>
      'يساعد رقم هاتفك المنظمة غير الربحية على تنسيق الاستلام أو التوصيل أو الدعم. لا تُستخدم إشعارات SMS في النسخة الأولية.';

  @override
  String get settingsHelp => 'الإعدادات والمساعدة';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get householdSize => 'حجم الأسرة';

  @override
  String get signedOut => 'تم تسجيل خروجك.';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get signOutConfirm => 'هل تريد تسجيل الخروج من Savvi؟';

  @override
  String get profileDietSub =>
      'يُرسل مع طلبات الطعام لاستخدامه في تجهيز الطلب من قِبل المنظمة غير الربحية فقط.';

  @override
  String get profileAlgSub =>
      'تُضمّن هذه المعلومات لمساعدة الموظفين على تجهيز الطعام بأمان.';

  @override
  String get errFix => 'يُرجى تصحيح الحقول المحددة.';

  @override
  String get savingLabel => 'جارٍ الحفظ…';

  @override
  String get returnToRequest => 'العودة إلى الطلب';

  @override
  String get returnToRequestBody => 'كنت تُكمل طلبًا للحصول على دعم غذائي.';

  @override
  String get householdConfirm => 'يُرجى تأكيد حجم الأسرة.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSub => 'إدارة حسابك والحصول على المساعدة.';

  @override
  String get sPersonal => 'الملف الشخصي';

  @override
  String get sPersonalDesc => 'الاسم وبيانات الاتصال والعنوان والأسرة';

  @override
  String get sLang => 'اللغة';

  @override
  String get sNotif => 'الإشعارات';

  @override
  String get sNotifDesc => 'القنوات والتفضيلات';

  @override
  String get sSecurity => 'الأمان وكلمة المرور';

  @override
  String get sSecurityDesc => 'تحديث كلمة المرور';

  @override
  String get sHelp => 'المساعدة والدعم';

  @override
  String get sHelpDesc => 'التواصل مع شريكك من المنظمات غير الربحية';

  @override
  String get langHelp => 'اختر لغة عرض تطبيق Savvi.';

  @override
  String get langSaved => 'تم تحديث اللغة';

  @override
  String get langEnglish => 'الإنجليزية';

  @override
  String get langSpanish => 'الإسبانية';

  @override
  String get closeAction => 'إغلاق';

  @override
  String get signOutBody => 'ستحتاج إلى تسجيل الدخول مرة أخرى لاستخدام Savvi.';

  @override
  String get securityHelper =>
      'استخدم هذا الخيار لطلب رابط آمن لإعادة تعيين كلمة مرور حساب Savvi.';

  @override
  String get sendResetLink => 'إرسال رابط إعادة تعيين كلمة المرور';

  @override
  String get resetLinkSent =>
      'تم إرسال رابط إعادة تعيين كلمة المرور. تحقق من بريدك الإلكتروني لمعرفة الخطوات التالية.';

  @override
  String get resetLinkError => 'تعذر إرسال رابط إعادة التعيين. حاول مرة أخرى.';

  @override
  String get resetEmailLabel => 'سيتم إرسال رابط إعادة التعيين إلى';

  @override
  String get helpContactPlaceholder => 'ستظهر تفاصيل الاتصال هنا عند توفرها.';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordSubtitle =>
      'سنرسل رمزًا من 6 أرقام إلى بريدك الإلكتروني.';

  @override
  String get sendResetLinkBtn => 'إرسال الرمز';

  @override
  String get checkYourInboxTitle => 'تحقق من صندوق الوارد.';

  @override
  String resetLinkSentBody(String email) {
    return 'أرسلنا رابط إعادة التعيين إلى $email. تنتهي صلاحيته خلال 15 دقيقة.';
  }

  @override
  String get iHaveTheLink => 'لدي الرابط ←';

  @override
  String get resendLinkBtn => 'إعادة إرسال الرابط';

  @override
  String resendInSeconds(int seconds) {
    return 'إعادة الإرسال خلال $seconds ث';
  }

  @override
  String get newPasswordTitle => 'كلمة مرور جديدة';

  @override
  String get newPasswordSubtitle =>
      '8 أحرف على الأقل، مع حرف كبير ورقم ورمز خاص.';

  @override
  String get fieldNewPassword => 'كلمة المرور الجديدة';

  @override
  String get hintCreatePassword => 'إنشاء كلمة مرور';

  @override
  String get fieldConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get hintReenterPassword => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get updatePasswordBtn => 'تحديث كلمة المرور';

  @override
  String get passwordMustMeetAllFour =>
      'يجب أن تستوفي كلمة المرور المتطلبات الأربعة جميعها.';

  @override
  String get valPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get passwordUpdatedTitle => 'تم تحديث كلمة المرور.';

  @override
  String get passwordUpdatedBody =>
      'تم تغيير كلمة مرور Savvi. سجّل الدخول باستخدام كلمة المرور الجديدة.';

  @override
  String get goToSignIn => 'الانتقال إلى تسجيل الدخول';

  @override
  String get checkInboxTitle => 'أدخل رمز التحقق';

  @override
  String checkInboxBody(String email) {
    return 'أرسلنا رمزًا مكوّنًا من 6 أرقام إلى $email. أدخله أدناه للمتابعة.';
  }

  @override
  String get resendLink => 'إعادة إرسال الرمز';

  @override
  String get otpVerifyBtn => 'التحقق من الرمز';

  @override
  String get otpIncomplete => 'أدخل الرمز المكوّن من 6 أرقام.';

  @override
  String get otpInvalid => 'الرمز غير صالح أو انتهت صلاحيته. حاول مرة أخرى.';

  @override
  String get otpSendFailed => 'تعذر إرسال الرمز. حاول مرة أخرى.';

  @override
  String get otpResent => 'تم إرسال رمز جديد.';

  @override
  String get confirmPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get edit => 'تعديل';

  @override
  String get editHouseholdNote =>
      'يمكن حاليًا إدارة حجم الأسرة من ملفك الشخصي.';
}
