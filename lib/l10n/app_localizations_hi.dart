// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'आज';

  @override
  String get relYesterday => 'कल';

  @override
  String get relTomorrow => 'आने वाला कल';

  @override
  String get actionContinue => 'जारी रखें';

  @override
  String get actionCancel => 'रद्द करें';

  @override
  String get actionSave => 'सहेजें';

  @override
  String get actionRetry => 'फिर कोशिश करें';

  @override
  String get actionClose => 'बंद करें';

  @override
  String get actionGoToProfile => 'प्रोफ़ाइल पर जाएँ';

  @override
  String get stateLoading => 'लोड हो रहा है…';

  @override
  String get stateEmptyTitle => 'अभी यहाँ कुछ नहीं है';

  @override
  String get stateErrorTitle => 'कुछ गलत हुआ';

  @override
  String get stateSuccessTitle => 'हो गया';

  @override
  String get errNetwork => 'कनेक्शन नहीं है। इंटरनेट जाँचें और फिर कोशिश करें।';

  @override
  String get errTimeout => 'बहुत समय लग गया। कृपया फिर कोशिश करें।';

  @override
  String get errUnauthorized =>
      'आपका सत्र समाप्त हो गया है। कृपया फिर साइन इन करें।';

  @override
  String get errServer =>
      'हमारी ओर से कुछ समस्या हुई। कृपया थोड़ी देर बाद फिर कोशिश करें।';

  @override
  String get errUnknown => 'कुछ गलत हुआ। कृपया फिर कोशिश करें।';

  @override
  String get valRequired => 'यह फ़ील्ड ज़रूरी है।';

  @override
  String get valEmail => 'मान्य ईमेल पता दर्ज करें।';

  @override
  String get valPhoneRequired => 'जारी रखने के लिए अपना फ़ोन नंबर दर्ज करें।';

  @override
  String get valPhoneInvalid => 'मान्य फ़ोन नंबर दर्ज करें।';

  @override
  String get valZip => 'मान्य ZIP कोड दर्ज करें।';

  @override
  String get phoneHelp =>
      'आपके भोजन सहायता अनुरोध के लिए पिकअप, डिलीवरी या सहायता का सुरक्षित समन्वय करने हेतु फ़ोन नंबर आवश्यक है। Savvi के MVP में SMS सूचनाएँ उपयोग नहीं की जातीं।';

  @override
  String get unitLbs => 'पाउंड';

  @override
  String get unitKg => 'किलोग्राम';

  @override
  String get unitMi => 'मील';

  @override
  String get unitMin => 'मिनट';

  @override
  String get stSubmitted => 'जमा किया गया';

  @override
  String get stNeedsUpdate => 'अपडेट आवश्यक';

  @override
  String get stApproved => 'स्वीकृत';

  @override
  String get stScheduled => 'निर्धारित';

  @override
  String get stPreparing => 'तैयारी जारी';

  @override
  String get stReadyPickup => 'पिकअप के लिए तैयार';

  @override
  String get stPickupConfirmed => 'पिकअप की पुष्टि हुई';

  @override
  String get stOutForDelivery => 'डिलीवरी के लिए निकल गया';

  @override
  String get stNearby => 'पास में';

  @override
  String get stDelivered => 'डिलीवर हो गया';

  @override
  String get stDelayed => 'देरी हुई';

  @override
  String get stUnavailable => 'उपलब्ध नहीं';

  @override
  String get stCompleted => 'पूरा हुआ';

  @override
  String get stMissed => 'छूट गया';

  @override
  String get stDeclined => 'अस्वीकृत';

  @override
  String get stCancelled => 'रद्द किया गया';

  @override
  String get actionBack => 'वापस';

  @override
  String get actionSignIn => 'साइन इन करें';

  @override
  String get actionSignInShort => 'साइन इन';

  @override
  String get signInTagline => 'परिवारों के लिए खाद्य सहायता का Savvi तरीका।';

  @override
  String get signInSubtitle =>
      'सदस्य नीचे साइन इन करें। नए सदस्यों को गैर-लाभकारी संस्था से एक्सेस लिंक चाहिए।';

  @override
  String get fieldEmail => 'ईमेल पता';

  @override
  String get fieldPassword => 'पासवर्ड';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => 'आपका पासवर्ड';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get newMemberPrompt => 'नए सदस्य हैं?';

  @override
  String get createWithAccessLink => 'एक्सेस लिंक से खाता बनाएँ';

  @override
  String get accessTitle => 'अपना एक्सेस सत्यापित करें';

  @override
  String get accessSubtitle =>
      'अपने गैर-लाभकारी संगठन द्वारा भेजा गया लिंक पेस्ट करें या Savvi नामांकन स्थान पर QR कोड स्कैन करें।';

  @override
  String get accessInviteNote =>
      'Savvi केवल आमंत्रण से उपलब्ध है। पहुँच लिंक गैर-लाभकारी संगठन के कर्मचारी भेजते हैं और 48 घंटे बाद समाप्त हो जाते हैं।';

  @override
  String get accessPasteLabel => 'एक्सेस लिंक या कोड पेस्ट करें';

  @override
  String get accessPasteHint => 'अपना लिंक या कोड पेस्ट करें';

  @override
  String get accessVerifyBtn => 'एक्सेस लिंक सत्यापित करें';

  @override
  String get orDivider => 'या';

  @override
  String get accessScanTitle => 'गैर-लाभकारी संगठन का QR कोड स्कैन करें';

  @override
  String get accessScanSubtitle =>
      'सामान्य नामांकन या विश्वसनीय स्थल पर तुरंत स्वीकृति वाले कार्यक्रमों के लिए';

  @override
  String get accessVerifiedTitle => 'पहुँच सत्यापित हुई।';

  @override
  String get accessVerifiedBody =>
      'स्वीकृति के लिए अपना खाता प्रोफ़ाइल पूरा करें।';

  @override
  String get accessOnsiteTitle => 'विश्वसनीय स्थल पर नामांकन मिला।';

  @override
  String get accessOnsiteBody =>
      'वहीं मौजूद गैर-लाभकारी संगठन के कर्मचारियों से तुरंत स्वीकृति पाने के लिए अपनी प्रोफ़ाइल पूरी करें।';

  @override
  String get accessContinueBtn => 'खाता बनाने के लिए आगे बढ़ें';

  @override
  String get accessContinueHint =>
      'आगे बढ़ने के लिए पहुँच लिंक सत्यापित करें या QR कोड स्कैन करें।';

  @override
  String get accessErrEmpty => 'पहले अपना पहुँच लिंक या कोड पेस्ट करें।';

  @override
  String get accessErrExpired =>
      'यह पहुँच लिंक समाप्त हो गया है। नया लिंक पाने के लिए अपने गैर-लाभकारी संगठन से संपर्क करें।';

  @override
  String get accessErrUsed => 'यह पहुँच लिंक पहले ही इस्तेमाल हो चुका है।';

  @override
  String get accessErrInvalid =>
      'हम इस लिंक या कोड को सत्यापित नहीं कर सके। जाँचकर फिर कोशिश करें।';

  @override
  String get qrTitle => 'पहुँच QR स्कैन करें';

  @override
  String get qrSubtitle =>
      'कैमरा गैर-लाभकारी संगठन के QR कोड पर रखें या नीचे कोड दर्ज करें।';

  @override
  String get qrScanBtn => 'स्कैन करने के लिए कैमरा खोलें';

  @override
  String get qrEnterLabel => 'कोड स्वयं दर्ज करें';

  @override
  String get qrCameraStaged =>
      'डिवाइस सेटअप के दौरान कैमरा स्कैनिंग सक्षम होगी। अभी नीचे अपने संगठन से मिला कोड दर्ज करें।';

  @override
  String get signUpTitle => 'अपना खाता बनाएँ';

  @override
  String get signUpSubtitle =>
      'गैर-लाभकारी संगठन की स्वीकृति के लिए अपनी प्रोफ़ाइल पूरी करें।';

  @override
  String get signUpAccessRequiredTitle => 'पहुँच लिंक आवश्यक है';

  @override
  String get signUpAccessRequiredBody =>
      'Savvi खाता बनाने के लिए गैर-लाभकारी संगठन का पहुँच लिंक या QR कोड आवश्यक है।';

  @override
  String get signUpAccessVerifiedTitle => 'पहुँच सत्यापित हुई';

  @override
  String get signUpAccessVerifiedBody =>
      'अपनी प्रोफ़ाइल पूरी करें और स्वीकृति के लिए जमा करें।';

  @override
  String get fieldFirstName => 'पहला नाम';

  @override
  String get fieldLastName => 'उपनाम';

  @override
  String get fieldPhone => 'फ़ोन नंबर';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'सड़क का पता';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'शहर';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'राज्य';

  @override
  String get fieldZip => 'ZIP कोड';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'परिवार के सदस्य';

  @override
  String householdPerson(int count) {
    return '$count व्यक्ति';
  }

  @override
  String householdPeople(int count) {
    return '$count लोग';
  }

  @override
  String get householdPeopleMax => '10 से अधिक लोग';

  @override
  String get pwdReqLength => '8 या अधिक अक्षर';

  @override
  String get pwdReqUpper => 'बड़ा अक्षर';

  @override
  String get pwdReqNumber => 'अंक';

  @override
  String get pwdReqSpecial => 'विशेष चिह्न';

  @override
  String get consentText =>
      'मैं Savvi की गोपनीयता नीति से सहमत हूँ और केवल भोजन सहायता के लिए अपने परिवार का डेटा गैर-लाभकारी भागीदार के साथ साझा करने की अनुमति देता/देती हूँ।';

  @override
  String get consentRequired => 'आगे बढ़ने के लिए सहमति दें।';

  @override
  String get signUpApprovalNote =>
      'भोजन अनुरोध जमा करने से पहले आपके खाते को गैर-लाभकारी भागीदार की स्वीकृति आवश्यक है।';

  @override
  String get signUpSubmitBtn => 'स्वीकृति के लिए जमा करें';

  @override
  String get haveAccountPrompt => 'पहले से खाता है?';

  @override
  String get approvalHeroTitle => 'आप लगभग पहुँच गए हैं।';

  @override
  String get approvalHeroBody =>
      'आपकी प्रोफ़ाइल गैर-लाभकारी संगठन के पास है। स्वीकृति जल्द मिल सकती है।';

  @override
  String get stepSubmitted => 'जमा किया गया';

  @override
  String get stepReview => 'समीक्षा';

  @override
  String get stepApproved => 'स्वीकृत';

  @override
  String get approvalStatusLabel => 'स्थिति';

  @override
  String get approvalPendingBadge => 'समीक्षा लंबित';

  @override
  String get approvalRow1Title => 'प्रोफ़ाइल जमा हुई';

  @override
  String get approvalRow1Body => 'आपके खाते का विवरण आज प्राप्त हुआ';

  @override
  String get approvalRow2Title => 'गैर-लाभकारी संगठन की समीक्षा जारी';

  @override
  String get approvalRow2Body =>
      'आपका भागीदार अभी आपकी प्रोफ़ाइल की समीक्षा कर रहा है';

  @override
  String get approvalRow3Title => 'स्वीकृति का निर्णय';

  @override
  String get approvalRow3Body => 'हम आपको पुश सूचना और ईमेल से बताएँगे';

  @override
  String get approvalMotivTitle => 'अच्छी खबर आने वाली है।';

  @override
  String get approvalMotivBody =>
      'अधिकांश स्वीकृतियाँ 1–2 कार्यदिवस में पूरी होती हैं। पहुँच तैयार होते ही आपको सूचना मिलेगी।';

  @override
  String get trackApprovalBtn => 'स्वीकृति की स्थिति देखें';

  @override
  String get backToSignIn => 'साइन इन पर वापस जाएँ';

  @override
  String get approvedTitle => 'आप स्वीकृत हैं!';

  @override
  String get approvedBody =>
      'आपके गैर-लाभकारी भागीदार ने आपका खाता स्वीकृत कर दिया है। अब आप भोजन सहायता माँग सकते हैं।';

  @override
  String get approvedCta => 'होम पर जाएँ';

  @override
  String get declinedTitle => 'स्वीकृति नहीं मिली';

  @override
  String get declinedBody =>
      'आपका गैर-लाभकारी भागीदार इस खाते को स्वीकृत नहीं कर सका। अगले चरणों के लिए उससे संपर्क करें।';

  @override
  String get needsReviewTitle => 'अतिरिक्त समीक्षा आवश्यक';

  @override
  String get needsReviewBody =>
      'स्वीकृति से पहले आपके भागीदार को कुछ और जानकारी चाहिए। वह पुश सूचना और ईमेल से संपर्क करेगा।';

  @override
  String get pwdNotMet => 'पासवर्ड अभी सभी आवश्यकताओं को पूरा नहीं करता।';

  @override
  String get requestIdLabel => 'अनुरोध ID';

  @override
  String get catProduce => 'ताज़ी उपज';

  @override
  String get catDairy => 'डेयरी उत्पाद';

  @override
  String get catMeatProtein => 'मांस / प्रोटीन';

  @override
  String get catPreparedMeals => 'तैयार भोजन';

  @override
  String get catBakeryBread => 'बेकरी / ब्रेड';

  @override
  String get catPantry => 'राशन';

  @override
  String get catFrozen => 'फ्रोजन खाद्य';

  @override
  String get catSnacksBeverages => 'स्नैक्स और पेय';

  @override
  String get catBabyFood => 'शिशु आहार';

  @override
  String get catInfantFormula => 'शिशु फ़ॉर्मूला';

  @override
  String get catControlledNote =>
      'नियंत्रित वस्तु — अतिरिक्त समीक्षा हो सकती है';

  @override
  String get navHome => 'होम';

  @override
  String get navAlerts => 'अलर्ट';

  @override
  String get navEvents => 'कार्यक्रम';

  @override
  String get navRequest => 'अनुरोध';

  @override
  String get navActivity => 'गतिविधि';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get greetMorning => 'सुप्रभात';

  @override
  String get greetAfternoon => 'नमस्कार';

  @override
  String get greetEvening => 'शुभ संध्या';

  @override
  String get homeCtaTitle => 'भोजन सहायता माँगें';

  @override
  String get homeCtaBody => 'कोई कतार नहीं। पिकअप या डिलीवरी।';

  @override
  String get homeCtaBtn => 'अनुरोध करें →';

  @override
  String get homeNoActive => 'कोई सक्रिय अनुरोध नहीं';

  @override
  String get homeNoActiveBody =>
      'भोजन सहायता का अनुरोध करने पर उसकी स्थिति यहाँ देख सकेंगे।';

  @override
  String etaAway(String eta) {
    return '$eta दूर';
  }

  @override
  String milesAway(String miles) {
    return '$miles दूर';
  }

  @override
  String get alertsTitle => 'कार्यक्रम';

  @override
  String get alertsSubtitle => 'आपके पास साझेदार संस्था के खाद्य कार्यक्रम।';

  @override
  String get alertTypeHot => 'गरम भोजन की सूचना';

  @override
  String get alertTypeDist => 'खाद्य वितरण कार्यक्रम';

  @override
  String alertSpotsLeft(int count) {
    return '$count स्थान शेष';
  }

  @override
  String get alertRsvpPrompt =>
      'बताएँ कि आप कितने लोगों के लिए जगह आरक्षित कर रहे हैं।';

  @override
  String get alertRsvpConfirm => 'मैं आ रहा/रही हूँ';

  @override
  String alertRsvpConfirmed(int count) {
    return '$count लोगों के लिए पंजीकरण की पुष्टि हुई';
  }

  @override
  String get alertRsvpChange => 'बदलें';

  @override
  String get alertRsvpCancel => 'पंजीकरण रद्द करें';

  @override
  String get alertsEmpty => 'अभी कोई अलर्ट नहीं है';

  @override
  String get alertsEmptyBody =>
      'आस-पास भोजन उपलब्ध होने पर हम आपको सूचित करेंगे।';

  @override
  String get tryAgain => 'फिर कोशिश करें';

  @override
  String get notificationsTitle => 'सूचनाएँ';

  @override
  String get savviMember => 'Savvi सदस्य';

  @override
  String get homeSub => 'सम्मान के साथ खाद्य सहायता।';

  @override
  String householdOf(String count) {
    return '$count सदस्यों का परिवार';
  }

  @override
  String get tileAlertsTitle => 'कार्यक्रम';

  @override
  String get tileAlertsSub => 'आपके पास भोजन कार्यक्रम';

  @override
  String get tileReqTitle => 'मेरे अनुरोध';

  @override
  String get tileReqSub => 'स्थिति और पिकअप विवरण';

  @override
  String get activeRequest => 'सक्रिय अनुरोध';

  @override
  String alertRsvpMax(int count) {
    return 'अधिकतम $count · आपके परिवार का आकार';
  }

  @override
  String get alertRsvpSeeYou => 'वहाँ मिलते हैं। धन्यवाद!';

  @override
  String get alertRsvpCancelled => 'आपका पंजीकरण रद्द कर दिया गया।';

  @override
  String get alertRsvpSelectFirst =>
      'पुष्टि करने से पहले कम से कम 1 व्यक्ति चुनें।';

  @override
  String get reqTitle => 'खाद्य सहायता का अनुरोध करें';

  @override
  String reqStep(int n, int t) {
    return 'चरण $n / $t';
  }

  @override
  String get s1Title => 'किससे सबसे अधिक मदद मिलेगी?';

  @override
  String get s1Sub => 'एक या अधिक श्रेणियाँ चुनें।';

  @override
  String get s2Title => 'पिकअप या डिलीवरी?';

  @override
  String get s2Sub => 'सहायता पाने का तरीका चुनें।';

  @override
  String get s3Title => 'परिवार और संपर्क';

  @override
  String get s3Sub =>
      'ये विवरण आपकी प्रोफ़ाइल से आते हैं। बदलाव होने पर वहीं अपडेट करें।';

  @override
  String get s4Title => 'अपने अनुरोध की समीक्षा करें';

  @override
  String get s4Sub => 'जमा करने से पहले सभी विवरण जाँचें।';

  @override
  String get s5Title => 'अपने अनुरोध की समीक्षा करें';

  @override
  String get s5Sub => 'जमा करने से पहले सभी विवरण जाँचें।';

  @override
  String get stepNext => 'आगे';

  @override
  String get stepBack => 'वापस';

  @override
  String get methodPickup => 'पिकअप';

  @override
  String get methodDelivery => 'डिलीवरी';

  @override
  String get pickupDesc => 'गैर-लाभकारी स्थान पर अपने पिकअप कोड से भोजन लें।';

  @override
  String get deliveryDesc =>
      'आपके पते पर डिलीवरी। ऐप में लाइव ट्रैकिंग उपलब्ध है।';

  @override
  String get controlledItem => 'नियंत्रित वस्तु';

  @override
  String get formulaNote =>
      'शिशु फ़ॉर्मूला की उपलब्धता संगठन की स्वीकृति, सीलबंद पैकेजिंग, समाप्ति तिथि और कार्यक्रम की पात्रता पर निर्भर करती है।';

  @override
  String get formulaAck => 'मैं समझता/समझती हूँ';

  @override
  String get notesLabel => 'संस्था के लिए नोट्स';

  @override
  String get notesHint =>
      'क्या ऐसी कोई बात है जो गैर-लाभकारी संगठन को जाननी चाहिए?';

  @override
  String get fromProfile => 'आपकी प्रोफ़ाइल से';

  @override
  String get editInProfile => 'सेटिंग्स में संपादित करें';

  @override
  String get editInSettings => 'सेटिंग्स में संपादित करें';

  @override
  String get rvDietNote =>
      'आहार संबंधी प्राथमिकताएँ और एलर्जेन आपकी प्रोफ़ाइल से आते हैं। बदलने के लिए सेटिंग्स पर जाएँ।';

  @override
  String get householdSizeNote =>
      'परिवार का आकार बदलने के लिए सेटिंग्स पर जाएँ। डिफ़ॉल्ट आपकी प्रोफ़ाइल से है';

  @override
  String get dietTitle => 'आहार संबंधी प्राथमिकताएँ';

  @override
  String get allergensTitle => 'एलर्जेन';

  @override
  String get dSenior => 'बुज़ुर्गों के अनुकूल भोजन';

  @override
  String get dLowSodium => 'कम सोडियम';

  @override
  String get dDiabetic => 'मधुमेह के अनुकूल';

  @override
  String get dVegetarian => 'शाकाहारी';

  @override
  String get dVegan => 'पूर्ण शाकाहारी';

  @override
  String get dHalal => 'हलाल';

  @override
  String get dNoPork => 'सूअर का मांस नहीं';

  @override
  String get dGlutenFree => 'ग्लूटेन-मुक्त';

  @override
  String get gPeanuts => 'मूँगफली';

  @override
  String get gTreeNuts => 'मेवे';

  @override
  String get gMilk => 'दूध / डेयरी';

  @override
  String get gEggs => 'अंडे';

  @override
  String get gSoy => 'सोया';

  @override
  String get gWheat => 'गेहूँ / ग्लूटेन';

  @override
  String get gFish => 'मछली';

  @override
  String get gShellfish => 'शेलफ़िश';

  @override
  String get gSesame => 'तिल';

  @override
  String get rvCats => 'श्रेणियाँ';

  @override
  String get rvMethod => 'तरीका';

  @override
  String get rvHousehold => 'परिवार';

  @override
  String get rvContact => 'संपर्क';

  @override
  String get rvAddress => 'पता';

  @override
  String get rvDiet => 'आहार';

  @override
  String get rvAlg => 'एलर्जेन';

  @override
  String get rvNotes => 'टिप्पणियाँ';

  @override
  String get rvNone => 'कोई नहीं';

  @override
  String get submitRequest => 'अनुरोध भेजें';

  @override
  String get reqOkTitle => 'अनुरोध जमा हुआ।';

  @override
  String reqOkBody(String np) {
    return '$np आपके अनुरोध की समीक्षा करके पुष्टि करेगा। निर्णय की सूचना आपको मिलेगी।';
  }

  @override
  String get viewRequest => 'अनुरोध देखें';

  @override
  String get backHome => 'होम पर वापस जाएँ';

  @override
  String get errNoCat => 'कम से कम एक खाद्य श्रेणी चुनें।';

  @override
  String get errNoMethod => 'पिकअप या डिलीवरी चुनें।';

  @override
  String get deliveryUnavail =>
      'इस अनुरोध के लिए अभी डिलीवरी उपलब्ध नहीं है। पिकअप उपलब्ध हो सकता है।';

  @override
  String get deliveryChecking => 'डिलीवरी की उपलब्धता जाँची जा रही है…';

  @override
  String get deliveryAvailError =>
      'डिलीवरी की उपलब्धता जाँची नहीं जा सकी। फिर कोशिश करें।';

  @override
  String get actTitle => 'मेरे अनुरोध';

  @override
  String get actSub => 'पिकअप कोड, डिलीवरी की स्थिति और इतिहास.';

  @override
  String get tabActive => 'सक्रिय';

  @override
  String get tabHistory => 'इतिहास';

  @override
  String get tabAll => 'सभी';

  @override
  String get actEmptyTitle => 'यहाँ कोई अनुरोध नहीं';

  @override
  String get actEmptyBody => 'आपके जमा किए गए अनुरोध इस सूची में दिखाई देंगे।';

  @override
  String get statusLabel => 'स्थिति';

  @override
  String get weightLabel => 'वज़न';

  @override
  String get pickupCodeLabel => 'पिकअप कोड';

  @override
  String get viewDetails => 'विवरण देखें';

  @override
  String get trackDelivery => 'डिलीवरी ट्रैक करें';

  @override
  String get viewPickup => 'पिकअप विवरण देखें';

  @override
  String get editRequest => 'अनुरोध संपादित करें';

  @override
  String get cancelRequest => 'अनुरोध रद्द करें';

  @override
  String get editLocked => 'इस अनुरोध को अब संपादित नहीं किया जा सकता।';

  @override
  String get cancelConfirmTitle => 'यह अनुरोध रद्द करें?';

  @override
  String get cancelConfirmBody =>
      'इसे वापस नहीं लिया जा सकता। आपके गैर-लाभकारी भागीदार को सूचित किया जाएगा।';

  @override
  String get keepRequest => 'अनुरोध रखें';

  @override
  String get requestCancelled => 'अनुरोध रद्द हुआ।';

  @override
  String get notFoundTitle => 'अनुरोध नहीं मिला';

  @override
  String get trackTitle => 'डिलीवरी की स्थिति';

  @override
  String get trackSub => 'डिलीवरी सक्रिय होने पर लाइव अपडेट देखें।';

  @override
  String get trackWay => 'आपकी डिलीवरी रास्ते में है';

  @override
  String get trackNear => 'आपकी डिलीवरी पास है';

  @override
  String get trackEtaLine => 'अनुमानित आगमन: 20–30 मिनट';

  @override
  String get trackEtaNear => 'अनुमानित आगमन: 5 मिनट से कम';

  @override
  String get trackEst => 'अनुमानित';

  @override
  String get trackDist => 'दूरी';

  @override
  String get trackPrivacy =>
      'आपकी गोपनीयता के लिए ड्राइवर का विवरण और सटीक मार्ग नहीं दिखाए जाते। डिलीवरी पहुँचने पर सूचना मिलेगी।';

  @override
  String get trackDelayedTitle => 'आपकी डिलीवरी में देरी है';

  @override
  String get trackDelayedBody =>
      'आपका गैर-लाभकारी भागीदार नया आगमन समय तय कर रहा है। अपडेट मिलते ही आपको सूचना मिलेगी।';

  @override
  String get trackUnavailTitle => 'डिलीवरी उपलब्ध नहीं';

  @override
  String get trackUnavailBody =>
      'यह अनुरोध डिलीवर नहीं हो सका। इसके बजाय पिकअप उपलब्ध हो सकता है — अपने गैर-लाभकारी भागीदार से संपर्क करें।';

  @override
  String get trackDoneTitle => 'डिलीवरी पूरी हुई';

  @override
  String get trackDoneBody =>
      'आपकी डिलीवरी पहुँच गई। Savvi का उपयोग करने के लिए धन्यवाद।';

  @override
  String get switchPickup => 'इसके बजाय पिकअप के बारे में पूछें';

  @override
  String get pkTitle => 'पिकअप विवरण';

  @override
  String get pkSub => 'आपका कोड, समय और स्थान.';

  @override
  String get pkWindow => 'पिकअप समय';

  @override
  String get pkLocation => 'पिकअप स्थान';

  @override
  String get pkShowQr => 'पिकअप QR दिखाएँ';

  @override
  String get pkQrLabel => 'पिकअप QR';

  @override
  String get pkCodeSub => 'इसे गैर-लाभकारी स्थान पर दिखाएँ';

  @override
  String get pkWarn =>
      'आपका कोड केवल इस अनुरोध के लिए मान्य है। इसे दूसरों से साझा न करें।';

  @override
  String get pkReadyTitle => 'आपका पिकअप तैयार है';

  @override
  String get pkReadyBody => 'नीचे दिए गए समय के दौरान अपना कोड साथ लाएँ।';

  @override
  String get pkConfirmedTitle => 'पिकअप की पुष्टि हुई';

  @override
  String get pkConfirmedBody =>
      'कर्मचारी ने आपका कोड स्कैन किया। अनुरोध पूरा हुआ।';

  @override
  String get pkCompletedTitle => 'पिकअप पूरा हुआ';

  @override
  String get pkCompletedBody => 'Savvi का उपयोग करने के लिए धन्यवाद।';

  @override
  String get pkMissedTitle => 'पिकअप का समय समाप्त';

  @override
  String get pkMissedBody =>
      'पिकअप का समय निकल गया। नया समय तय करने के लिए अपने गैर-लाभकारी भागीदार से संपर्क करें।';

  @override
  String get pkReschedule => 'नया समय माँगें';

  @override
  String get pkReschedSent =>
      'आपके गैर-लाभकारी भागीदार से नया समय तय करने का अनुरोध किया गया है।';

  @override
  String get directions => 'दिशा-निर्देश';

  @override
  String get scanAtCounter => 'काउंटर पर स्कैन करें';

  @override
  String get nonprofitLabel => 'गैर-लाभकारी संगठन';

  @override
  String get naLabel => 'प्रदान नहीं किया गया';

  @override
  String get protoNote => 'प्रोटोटाइप सिमुलेशन — लाइव बैकएंड से जुड़ा नहीं है।';

  @override
  String get notifTitle => 'सूचनाएँ';

  @override
  String get notifSub => 'अनुरोध अपडेट और खाद्य सहायता सूचनाएँ।';

  @override
  String get notifEmptyTitle => 'आप सभी सूचनाएँ देख चुके हैं';

  @override
  String get notifEmptyBody => 'अभी आपके पास कोई सूचना नहीं है।';

  @override
  String get markAllRead => 'सभी को पढ़ा हुआ चिह्नित करें';

  @override
  String get clearAllNotifs => 'सभी साफ़ करें';

  @override
  String get markedReadOk => 'सभी सूचनाओं को पढ़ा हुआ चिह्नित किया गया।';

  @override
  String get clearedOk => 'सूचनाएँ साफ़ कर दी गईं।';

  @override
  String get clearConfirmTitle => 'सभी सूचनाएँ हटाएँ?';

  @override
  String get clearConfirmBody =>
      'इस सूची की हर सूचना हट जाएगी। इसे वापस नहीं किया जा सकता।';

  @override
  String get cancelAction => 'रद्द करें';

  @override
  String get prefsTitle => 'सूचना प्राथमिकताएँ';

  @override
  String get prefsSub => 'चुनें कि Savvi आपसे कैसे संपर्क करे।';

  @override
  String get prefsChNote => 'Savvi केवल ऐप, पुश और ईमेल सूचनाएँ उपयोग करता है।';

  @override
  String get prefsSaved => 'सूचना प्राथमिकता सहेजी गई';

  @override
  String get chInApp => 'ऐप में';

  @override
  String get chInAppDesc => 'हमेशा चालू। सूचना केंद्र में दिखाई देता है।';

  @override
  String get chPush => 'पुश सूचनाएँ';

  @override
  String get chPushDesc => 'अनुरोध बदलने पर आपके फ़ोन पर अलर्ट।';

  @override
  String get chEmail => 'ईमेल';

  @override
  String get chEmailDesc =>
      'महत्वपूर्ण अपडेट की एक प्रति आपके ईमेल पर भेजी जाती है।';

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get personalInformation => 'व्यक्तिगत जानकारी';

  @override
  String get contactDetails => 'संपर्क विवरण';

  @override
  String get saveContact => 'संपर्क विवरण सहेजें';

  @override
  String get contactSaved => 'प्रोफ़ाइल अपडेट हुई';

  @override
  String get usedInRequests => 'भोजन अनुरोधों में उपयोग किया जाता है';

  @override
  String get activeLabel => 'सक्रिय';

  @override
  String get zipNote =>
      'ZIP कोड भोजन तक पहुँच और सेवा क्षेत्र की रिपोर्टिंग में मदद करता है।';

  @override
  String get phoneNote =>
      'आपका फ़ोन नंबर गैर-लाभकारी भागीदार को पिकअप, डिलीवरी या सहायता समन्वित करने में मदद करता है। MVP में SMS सूचनाएँ उपयोग नहीं होतीं।';

  @override
  String get settingsHelp => 'सेटिंग्स और सहायता';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get householdSize => 'परिवार का आकार';

  @override
  String get signedOut => 'आप साइन आउट हो गए हैं।';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get signOutConfirm => 'Savvi से साइन आउट करें?';

  @override
  String get profileDietSub =>
      'केवल गैर-लाभकारी संगठन द्वारा भोजन पैक करने के लिए भोजन अनुरोधों के साथ भेजा जाता है।';

  @override
  String get profileAlgSub =>
      'कर्मचारियों को सुरक्षित रूप से भोजन पैक करने में मदद के लिए शामिल है।';

  @override
  String get errFix => 'कृपया चिह्नित फ़ील्ड ठीक करें।';

  @override
  String get savingLabel => 'सहेजा जा रहा है…';

  @override
  String get returnToRequest => 'अनुरोध पर लौटें';

  @override
  String get returnToRequestBody => 'आप भोजन सहायता अनुरोध पूरा कर रहे थे।';

  @override
  String get householdConfirm => 'कृपया अपने परिवार के आकार की पुष्टि करें।';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsSub => 'अपना खाता प्रबंधित करें और सहायता पाएँ।';

  @override
  String get sPersonal => 'प्रोफ़ाइल';

  @override
  String get sPersonalDesc => 'नाम, संपर्क, पता, परिवार';

  @override
  String get sLang => 'भाषा';

  @override
  String get sNotif => 'सूचनाएँ';

  @override
  String get sNotifDesc => 'चैनल और प्राथमिकताएँ';

  @override
  String get sSecurity => 'सुरक्षा और पासवर्ड';

  @override
  String get sSecurityDesc => 'अपना पासवर्ड अपडेट करें';

  @override
  String get sHelp => 'सहायता और समर्थन';

  @override
  String get sHelpDesc => 'अपने गैर-लाभकारी भागीदार से संपर्क करें';

  @override
  String get langHelp => 'Savvi ऐप की भाषा चुनें।';

  @override
  String get langSaved => 'भाषा अपडेट की गई';

  @override
  String get langEnglish => 'अंग्रेज़ी';

  @override
  String get langSpanish => 'स्पेनिश';

  @override
  String get closeAction => 'बंद करें';

  @override
  String get signOutBody =>
      'Savvi का उपयोग करने के लिए आपको फिर से साइन इन करना होगा।';

  @override
  String get securityHelper =>
      'अपने Savvi खाते के लिए सुरक्षित पासवर्ड रीसेट लिंक माँगने हेतु इसका उपयोग करें।';

  @override
  String get sendResetLink => 'पासवर्ड रीसेट लिंक भेजें';

  @override
  String get resetLinkSent =>
      'पासवर्ड रीसेट लिंक भेजा गया। अगले चरणों के लिए अपना ईमेल देखें।';

  @override
  String get resetLinkError =>
      'रीसेट लिंक नहीं भेजा जा सका। कृपया फिर कोशिश करें।';

  @override
  String get resetEmailLabel => 'रीसेट लिंक यहाँ भेजा जाएगा';

  @override
  String get helpContactPlaceholder =>
      'उपलब्ध होने पर संपर्क विवरण यहाँ दिखाई देंगे।';

  @override
  String get resetPasswordTitle => 'पासवर्ड रीसेट करें';

  @override
  String get resetPasswordSubtitle => 'हम आपके ईमेल पर 6 अंकों का कोड भेजेंगे।';

  @override
  String get sendResetLinkBtn => 'कोड भेजें';

  @override
  String get checkYourInboxTitle => 'अपना इनबॉक्स देखें।';

  @override
  String resetLinkSentBody(String email) {
    return '$email पर रीसेट लिंक भेजा गया है। लिंक 15 मिनट में समाप्त हो जाएगा।';
  }

  @override
  String get iHaveTheLink => 'मेरे पास लिंक है →';

  @override
  String get resendLinkBtn => 'लिंक फिर भेजें';

  @override
  String resendInSeconds(int seconds) {
    return '$seconds सेकंड में फिर भेजें';
  }

  @override
  String get newPasswordTitle => 'नया पासवर्ड';

  @override
  String get newPasswordSubtitle =>
      'कम से कम 8 अक्षर, एक बड़ा अक्षर, एक अंक और एक विशेष चिह्न';

  @override
  String get fieldNewPassword => 'नया पासवर्ड';

  @override
  String get hintCreatePassword => 'पासवर्ड बनाएँ';

  @override
  String get fieldConfirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get hintReenterPassword => 'नया पासवर्ड फिर दर्ज करें';

  @override
  String get updatePasswordBtn => 'पासवर्ड अपडेट करें';

  @override
  String get passwordMustMeetAllFour =>
      'पासवर्ड को सभी चार आवश्यकताएँ पूरी करनी होंगी।';

  @override
  String get valPasswordMismatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get passwordUpdatedTitle => 'पासवर्ड अपडेट हुआ।';

  @override
  String get passwordUpdatedBody =>
      'आपका Savvi पासवर्ड बदल दिया गया है। नए पासवर्ड से साइन इन करें।';

  @override
  String get goToSignIn => 'साइन इन पर जाएँ';

  @override
  String get checkInboxTitle => 'सत्यापन कोड दर्ज करें';

  @override
  String checkInboxBody(String email) {
    return '$email पर 6 अंकों का कोड भेजा गया है। आगे बढ़ने के लिए नीचे दर्ज करें।';
  }

  @override
  String get resendLink => 'कोड फिर भेजें';

  @override
  String get otpVerifyBtn => 'कोड सत्यापित करें';

  @override
  String get otpIncomplete => '6 अंकों का कोड दर्ज करें।';

  @override
  String get otpInvalid =>
      'यह कोड अमान्य है या समाप्त हो गया है। फिर कोशिश करें।';

  @override
  String get otpSendFailed => 'कोड नहीं भेजा जा सका। कृपया फिर कोशिश करें।';

  @override
  String get otpResent => 'नया कोड भेज दिया गया है।';

  @override
  String get confirmPasswordMismatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get edit => 'संपादित करें';

  @override
  String get editHouseholdNote =>
      'फिलहाल परिवार का आकार आपकी प्रोफ़ाइल से प्रबंधित होता है।';
}
