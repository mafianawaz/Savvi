// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'Aujourd’hui';

  @override
  String get relYesterday => 'Hier';

  @override
  String get relTomorrow => 'Demain';

  @override
  String get actionContinue => 'Continuer';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionRetry => 'Réessayer';

  @override
  String get actionClose => 'Fermer';

  @override
  String get actionGoToProfile => 'Accéder au profil';

  @override
  String get stateLoading => 'Chargement…';

  @override
  String get stateEmptyTitle => 'Rien pour le moment';

  @override
  String get stateErrorTitle => 'Une erreur est survenue';

  @override
  String get stateSuccessTitle => 'Terminé';

  @override
  String get errNetwork =>
      'Aucune connexion. Vérifiez votre connexion Internet et réessayez.';

  @override
  String get errTimeout => 'Cela a pris trop de temps. Veuillez réessayer.';

  @override
  String get errUnauthorized =>
      'Votre session a expiré. Veuillez vous reconnecter.';

  @override
  String get errServer =>
      'Un problème est survenu de notre côté. Veuillez réessayer dans quelques instants.';

  @override
  String get errUnknown => 'Une erreur s’est produite. Veuillez réessayer.';

  @override
  String get valRequired => 'Ce champ est obligatoire.';

  @override
  String get valEmail => 'Saisissez une adresse e-mail valide.';

  @override
  String get valPhoneRequired =>
      'Saisissez votre numéro de téléphone pour continuer.';

  @override
  String get valPhoneInvalid => 'Saisissez un numéro de téléphone valide.';

  @override
  String get valZip => 'Saisissez un code postal valide.';

  @override
  String get phoneHelp =>
      'Un numéro de téléphone est nécessaire pour permettre à l’organisme partenaire à but non lucratif de coordonner en toute sécurité le retrait, la livraison ou l’aide liée à votre demande alimentaire. Savvi n’utilise pas les SMS dans la version MVP.';

  @override
  String get unitLbs => 'lb';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMin => 'min';

  @override
  String get stSubmitted => 'Envoyée';

  @override
  String get stNeedsUpdate => 'Mise à jour nécessaire';

  @override
  String get stApproved => 'Approuvée';

  @override
  String get stScheduled => 'Planifiée';

  @override
  String get stPreparing => 'En préparation';

  @override
  String get stReadyPickup => 'Prête à être récupérée';

  @override
  String get stPickupConfirmed => 'Retrait confirmé';

  @override
  String get stOutForDelivery => 'En cours de livraison';

  @override
  String get stNearby => 'À proximité';

  @override
  String get stDelivered => 'Livrée';

  @override
  String get stDelayed => 'Retardée';

  @override
  String get stUnavailable => 'Indisponible';

  @override
  String get stCompleted => 'Terminée';

  @override
  String get stMissed => 'Manquée';

  @override
  String get stDeclined => 'Refusée';

  @override
  String get stCancelled => 'Annulée';

  @override
  String get actionBack => 'Retour';

  @override
  String get actionSignIn => 'Se connecter';

  @override
  String get actionSignInShort => 'Se connecter';

  @override
  String get signInTagline =>
      'La façon Savvi de demander une aide alimentaire pour les familles.';

  @override
  String get signInSubtitle =>
      'Les membres se connectent ci-dessous. Les nouveaux membres ont besoin d’un lien d’accès fourni par un organisme partenaire.';

  @override
  String get fieldEmail => 'Adresse e-mail';

  @override
  String get fieldPassword => 'Mot de passe';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => 'Votre mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get newMemberPrompt => 'Nouveau membre ?';

  @override
  String get createWithAccessLink => 'Créer un compte avec un lien d’accès';

  @override
  String get accessTitle => 'Vérifier votre accès';

  @override
  String get accessSubtitle =>
      'Collez le lien envoyé par votre organisme à but non lucratif ou scannez le code QR dans un lieu d’inscription Savvi.';

  @override
  String get accessInviteNote =>
      'Savvi est accessible uniquement sur invitation. Les liens d’accès sont envoyés par le personnel de l’organisme et expirent après 48 heures.';

  @override
  String get accessPasteLabel => 'Collez le lien ou le code d’accès';

  @override
  String get accessPasteHint => 'Collez votre lien ou code';

  @override
  String get accessVerifyBtn => 'Vérifier le lien d’accès';

  @override
  String get orDivider => 'ou';

  @override
  String get accessScanTitle => 'Scanner le code QR de l’organisme';

  @override
  String get accessScanSubtitle =>
      'Pour une inscription standard ou un événement de préapprobation sur place de confiance';

  @override
  String get accessVerifiedTitle => 'Accès vérifié.';

  @override
  String get accessVerifiedBody =>
      'Complétez votre profil pour soumettre votre compte à approbation.';

  @override
  String get accessOnsiteTitle =>
      'Inscription sur place de confiance détectée.';

  @override
  String get accessOnsiteBody =>
      'Complétez votre profil pour obtenir une approbation immédiate du personnel de l’organisme sur place.';

  @override
  String get accessContinueBtn => 'Continuer la création du compte';

  @override
  String get accessContinueHint =>
      'Vérifiez votre lien d’accès ou scannez un code QR pour continuer.';

  @override
  String get accessErrEmpty =>
      'Veuillez d’abord coller votre lien ou code d’accès.';

  @override
  String get accessErrExpired =>
      'Ce lien d’accès a expiré. Demandez-en un nouveau à votre organisme.';

  @override
  String get accessErrUsed => 'Ce lien d’accès a déjà été utilisé.';

  @override
  String get accessErrInvalid =>
      'Impossible de vérifier ce lien ou code. Vérifiez-le et réessayez.';

  @override
  String get qrTitle => 'Scanner le QR d’accès';

  @override
  String get qrSubtitle =>
      'Pointez votre caméra vers le code QR de l’organisme ou saisissez le code ci-dessous.';

  @override
  String get qrScanBtn => 'Ouvrir la caméra pour scanner';

  @override
  String get qrEnterLabel => 'Saisir le code manuellement';

  @override
  String get qrCameraStaged =>
      'Le scan par caméra sera activé lors de la configuration de l’appareil. Pour le moment, saisissez ci-dessous le code fourni par votre organisme.';

  @override
  String get signUpTitle => 'Créer votre compte';

  @override
  String get signUpSubtitle =>
      'Complétez votre profil pour demander l’approbation de l’organisme.';

  @override
  String get signUpAccessRequiredTitle => 'Lien d’accès requis';

  @override
  String get signUpAccessRequiredBody =>
      'Vous avez besoin d’un lien d’accès ou d’un code QR de l’organisme pour créer un compte Savvi.';

  @override
  String get signUpAccessVerifiedTitle => 'Accès vérifié';

  @override
  String get signUpAccessVerifiedBody =>
      'Complétez votre profil et soumettez-le pour approbation.';

  @override
  String get fieldFirstName => 'Prénom';

  @override
  String get fieldLastName => 'Nom';

  @override
  String get fieldPhone => 'Numéro de téléphone';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'Adresse';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'Ville';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'État';

  @override
  String get fieldZip => 'Code postal';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'Taille du foyer';

  @override
  String householdPerson(int count) {
    return '$count personne';
  }

  @override
  String householdPeople(int count) {
    return '$count personnes';
  }

  @override
  String get householdPeopleMax => '10 personnes ou plus';

  @override
  String get pwdReqLength => '8 caractères ou plus';

  @override
  String get pwdReqUpper => 'Majuscule';

  @override
  String get pwdReqNumber => 'Chiffre';

  @override
  String get pwdReqSpecial => 'Caractère spécial';

  @override
  String get consentText =>
      'J’accepte la Politique de confidentialité de Savvi et consens à ce que les données de mon foyer soient partagées avec mon organisme partenaire uniquement à des fins d’aide alimentaire.';

  @override
  String get consentRequired => 'Veuillez accepter pour continuer.';

  @override
  String get signUpApprovalNote =>
      'Votre compte doit être approuvé par un organisme partenaire avant que vous puissiez soumettre des demandes alimentaires.';

  @override
  String get signUpSubmitBtn => 'Soumettre pour approbation';

  @override
  String get haveAccountPrompt => 'Vous avez déjà un compte ?';

  @override
  String get approvalHeroTitle => 'Vous y êtes presque.';

  @override
  String get approvalHeroBody =>
      'Votre profil est auprès de l’organisme. L’approbation approche.';

  @override
  String get stepSubmitted => 'Soumis';

  @override
  String get stepReview => 'Examen';

  @override
  String get stepApproved => 'Approuvé';

  @override
  String get approvalStatusLabel => 'Statut';

  @override
  String get approvalPendingBadge => 'En attente d’examen';

  @override
  String get approvalRow1Title => 'Profil soumis';

  @override
  String get approvalRow1Body =>
      'Les informations de votre compte ont été reçues aujourd’hui';

  @override
  String get approvalRow2Title => 'Examen par l’organisme en cours';

  @override
  String get approvalRow2Body =>
      'Votre partenaire examine actuellement votre profil';

  @override
  String get approvalRow3Title => 'Décision d’approbation';

  @override
  String get approvalRow3Body =>
      'Nous vous informerons par notification push et par e-mail';

  @override
  String get approvalMotivTitle => 'De bonnes choses arrivent.';

  @override
  String get approvalMotivBody =>
      'La plupart des approbations sont effectuées sous 1 à 2 jours ouvrés. Vous recevrez une notification dès que votre accès sera activé.';

  @override
  String get trackApprovalBtn => 'Suivre le statut d’approbation';

  @override
  String get backToSignIn => 'Retour à la connexion';

  @override
  String get approvedTitle => 'Vous êtes approuvé !';

  @override
  String get approvedBody =>
      'Votre organisme partenaire a approuvé votre compte. Vous pouvez maintenant demander une aide alimentaire.';

  @override
  String get approvedCta => 'Aller à l’accueil';

  @override
  String get declinedTitle => 'Approbation refusée';

  @override
  String get declinedBody =>
      'Votre partenaire associatif n’a pas pu approuver ce compte. Contactez-le pour connaître les prochaines étapes.';

  @override
  String get needsReviewTitle => 'Examen supplémentaire nécessaire';

  @override
  String get needsReviewBody =>
      'Votre partenaire associatif a besoin de quelques informations supplémentaires avant de donner son accord. Il vous contactera par notification et par e-mail.';

  @override
  String get pwdNotMet =>
      'Le mot de passe ne respecte pas encore toutes les exigences.';

  @override
  String get requestIdLabel => 'Identifiant de demande';

  @override
  String get catProduce => 'Fruits et légumes';

  @override
  String get catDairy => 'Produits laitiers';

  @override
  String get catMeatProtein => 'Viande / Protéines';

  @override
  String get catPreparedMeals => 'Repas préparés';

  @override
  String get catBakeryBread => 'Boulangerie / Pain';

  @override
  String get catPantry => 'Épicerie de base';

  @override
  String get catFrozen => 'Surgelés';

  @override
  String get catSnacksBeverages => 'Collations et boissons';

  @override
  String get catBabyFood => 'Aliments pour bébé';

  @override
  String get catInfantFormula => 'Lait infantile';

  @override
  String get catControlledNote =>
      'Article réglementé — un examen supplémentaire peut être nécessaire';

  @override
  String get navHome => 'Accueil';

  @override
  String get navAlerts => 'Alertes';

  @override
  String get navEvents => 'Événements';

  @override
  String get navRequest => 'Demande';

  @override
  String get navActivity => 'Activité';

  @override
  String get navProfile => 'Profil';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get greetMorning => 'Bonjour';

  @override
  String get greetAfternoon => 'Bon après-midi';

  @override
  String get greetEvening => 'Bonsoir';

  @override
  String get homeCtaTitle => 'Demander une aide alimentaire';

  @override
  String get homeCtaBody => 'Pas de file d’attente. Retrait ou livraison.';

  @override
  String get homeCtaBtn => 'Demander →';

  @override
  String get homeNoActive => 'Aucune demande active';

  @override
  String get homeNoActiveBody =>
      'Lorsque vous demandez une aide alimentaire, vous pourrez la suivre ici.';

  @override
  String etaAway(String eta) {
    return 'à $eta';
  }

  @override
  String milesAway(String miles) {
    return 'à $miles';
  }

  @override
  String get alertsTitle => 'Événements';

  @override
  String get alertsSubtitle =>
      'Événements alimentaires de votre organisme partenaire à proximité.';

  @override
  String get alertTypeHot => 'Alerte repas chauds';

  @override
  String get alertTypeDist => 'Événement de distribution alimentaire';

  @override
  String alertSpotsLeft(int count) {
    return '$count places restantes';
  }

  @override
  String get alertRsvpPrompt => 'Choisissez le nombre de personnes à inscrire.';

  @override
  String get alertRsvpConfirm => 'Je viens';

  @override
  String alertRsvpConfirmed(int count) {
    return 'Inscription confirmée pour $count';
  }

  @override
  String get alertRsvpChange => 'Modifier';

  @override
  String get alertRsvpCancel => 'Annuler la réservation';

  @override
  String get alertsEmpty => 'Aucune alerte pour le moment';

  @override
  String get alertsEmptyBody =>
      'Nous vous avertirons lorsque des aliments seront disponibles à proximité.';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get savviMember => 'Membre Savvi';

  @override
  String get homeSub => 'Une aide alimentaire fournie avec dignité.';

  @override
  String householdOf(String count) {
    return 'Ménage de $count personnes';
  }

  @override
  String get tileAlertsTitle => 'Événements';

  @override
  String get tileAlertsSub => 'Événements alimentaires près de chez vous';

  @override
  String get tileReqTitle => 'Mes demandes';

  @override
  String get tileReqSub => 'Statut et détails du retrait';

  @override
  String get activeRequest => 'Demande active';

  @override
  String alertRsvpMax(int count) {
    return 'Maximum $count · taille de votre ménage';
  }

  @override
  String get alertRsvpSeeYou => 'À bientôt ! Merci !';

  @override
  String get alertRsvpCancelled => 'Votre inscription a été annulée.';

  @override
  String get alertRsvpSelectFirst =>
      'Veuillez sélectionner au moins une personne avant de confirmer.';

  @override
  String get reqTitle => 'Demander une aide alimentaire';

  @override
  String reqStep(int n, int t) {
    return 'Étape $n sur $t';
  }

  @override
  String get s1Title => 'Qu’est-ce qui vous aiderait le plus ?';

  @override
  String get s1Sub => 'Sélectionnez une ou plusieurs catégories.';

  @override
  String get s2Title => 'Retrait ou livraison ?';

  @override
  String get s2Sub => 'Choisissez comment recevoir votre aide.';

  @override
  String get s3Title => 'Foyer et contact';

  @override
  String get s3Sub =>
      'Ces informations proviennent de votre profil. Mettez-les à jour dans votre profil si elles ont changé.';

  @override
  String get s4Title => 'Vérifier votre demande';

  @override
  String get s4Sub => 'Vérifiez toutes les informations avant l’envoi.';

  @override
  String get s5Title => 'Vérifier votre demande';

  @override
  String get s5Sub => 'Vérifiez toutes les informations avant l’envoi.';

  @override
  String get stepNext => 'Suivant';

  @override
  String get stepBack => 'Retour';

  @override
  String get methodPickup => 'Retrait';

  @override
  String get methodDelivery => 'Livraison';

  @override
  String get pickupDesc =>
      'Récupérez votre commande avec le code de retrait au lieu de l’organisme.';

  @override
  String get deliveryDesc =>
      'Livrée à votre adresse. Suivi en direct dans l’application.';

  @override
  String get controlledItem => 'Article réglementé';

  @override
  String get formulaNote =>
      'La disponibilité du lait infantile dépend de l’approbation de l’association, de l’emballage scellé, de la date de péremption et des critères du programme.';

  @override
  String get formulaAck => 'Je comprends';

  @override
  String get notesLabel => 'Notes pour l’organisme partenaire';

  @override
  String get notesHint => 'Une information utile à communiquer à l’organisme ?';

  @override
  String get fromProfile => 'Depuis votre profil';

  @override
  String get editInProfile => 'Modifier dans les paramètres';

  @override
  String get editInSettings => 'Modifier dans les paramètres';

  @override
  String get rvDietNote =>
      'Vos préférences alimentaires et allergènes proviennent de votre profil. Pour les modifier, accédez aux paramètres.';

  @override
  String get householdSizeNote =>
      'Pour modifier la taille du ménage, accédez aux paramètres. La valeur par défaut vient de votre profil. Vous pouvez la modifier uniquement pour cette demande.';

  @override
  String get dietTitle => 'Préférences alimentaires';

  @override
  String get allergensTitle => 'Allergènes';

  @override
  String get dSenior => 'Aliments adaptés aux personnes âgées';

  @override
  String get dLowSodium => 'Faible teneur en sodium';

  @override
  String get dDiabetic => 'Adapté aux personnes diabétiques';

  @override
  String get dVegetarian => 'Végétarien';

  @override
  String get dVegan => 'Végétalien';

  @override
  String get dHalal => 'Halal';

  @override
  String get dNoPork => 'Sans porc';

  @override
  String get dGlutenFree => 'Sans gluten';

  @override
  String get gPeanuts => 'Cacahuètes';

  @override
  String get gTreeNuts => 'Fruits à coque';

  @override
  String get gMilk => 'Lait et produits laitiers';

  @override
  String get gEggs => 'Œufs';

  @override
  String get gSoy => 'Soja';

  @override
  String get gWheat => 'Blé / gluten';

  @override
  String get gFish => 'Poisson';

  @override
  String get gShellfish => 'Crustacés et mollusques';

  @override
  String get gSesame => 'Sésame';

  @override
  String get rvCats => 'Catégories';

  @override
  String get rvMethod => 'Méthode';

  @override
  String get rvHousehold => 'Foyer';

  @override
  String get rvContact => 'Contact';

  @override
  String get rvAddress => 'Adresse';

  @override
  String get rvDiet => 'Alimentation';

  @override
  String get rvAlg => 'Allergènes';

  @override
  String get rvNotes => 'Remarques';

  @override
  String get rvNone => 'Aucun';

  @override
  String get submitRequest => 'Envoyer la demande';

  @override
  String get reqOkTitle => 'Demande envoyée.';

  @override
  String reqOkBody(String np) {
    return '$np examinera et confirmera votre demande. Vous recevrez une notification avec la décision.';
  }

  @override
  String get viewRequest => 'Voir la demande';

  @override
  String get backHome => 'Retour à l’accueil';

  @override
  String get errNoCat => 'Sélectionnez au moins une catégorie alimentaire.';

  @override
  String get errNoMethod => 'Choisissez le retrait ou la livraison.';

  @override
  String get deliveryUnavail =>
      'La livraison n’est pas disponible pour cette demande pour le moment. Le retrait peut toutefois être possible.';

  @override
  String get deliveryChecking =>
      'Vérification de la disponibilité de la livraison…';

  @override
  String get deliveryAvailError =>
      'Impossible de vérifier la disponibilité de la livraison. Réessayez.';

  @override
  String get actTitle => 'Mes demandes';

  @override
  String get actSub => 'Codes de retrait, état de la livraison et historique.';

  @override
  String get tabActive => 'Actives';

  @override
  String get tabHistory => 'Historique';

  @override
  String get tabAll => 'Toutes';

  @override
  String get actEmptyTitle => 'Aucune demande ici';

  @override
  String get actEmptyBody =>
      'Les demandes que vous soumettez apparaîtront dans cette liste.';

  @override
  String get statusLabel => 'Statut';

  @override
  String get weightLabel => 'Poids';

  @override
  String get pickupCodeLabel => 'Code de retrait';

  @override
  String get viewDetails => 'Voir les détails';

  @override
  String get trackDelivery => 'Suivre la livraison';

  @override
  String get viewPickup => 'Voir les détails du retrait';

  @override
  String get editRequest => 'Modifier la demande';

  @override
  String get cancelRequest => 'Annuler la demande';

  @override
  String get editLocked => 'Cette demande ne peut plus être modifiée.';

  @override
  String get cancelConfirmTitle => 'Annuler cette demande ?';

  @override
  String get cancelConfirmBody =>
      'Cette action est irréversible. Votre organisme partenaire sera averti.';

  @override
  String get keepRequest => 'Conserver la demande';

  @override
  String get requestCancelled => 'Demande annulée.';

  @override
  String get notFoundTitle => 'Demande introuvable';

  @override
  String get trackTitle => 'État de la livraison';

  @override
  String get trackSub => 'Suivi en direct pendant la livraison.';

  @override
  String get trackWay => 'Votre livraison est en route';

  @override
  String get trackNear => 'Votre livraison est proche';

  @override
  String get trackEtaLine => 'Arrivée estimée : 20–30 minutes';

  @override
  String get trackEtaNear => 'Arrivée estimée : moins de 5 minutes';

  @override
  String get trackEst => 'Estimation';

  @override
  String get trackDist => 'Distance';

  @override
  String get trackPrivacy =>
      'Pour protéger votre vie privée, les informations du livreur et les itinéraires exacts ne sont pas affichés. Vous serez averti à l’arrivée de votre livraison.';

  @override
  String get trackDelayedTitle => 'Votre livraison est retardée';

  @override
  String get trackDelayedBody =>
      'Votre partenaire associatif cherche une nouvelle heure d’arrivée. Vous serez averti dès sa mise à jour.';

  @override
  String get trackUnavailTitle => 'Livraison indisponible';

  @override
  String get trackUnavailBody =>
      'La livraison de cette demande n’a pas pu être effectuée. Un retrait peut être possible à la place : contactez votre partenaire associatif.';

  @override
  String get trackDoneTitle => 'Livraison terminée';

  @override
  String get trackDoneBody =>
      'Votre livraison est arrivée. Merci d’utiliser Savvi.';

  @override
  String get switchPickup => 'Demander plutôt un retrait';

  @override
  String get pkTitle => 'Détails du retrait';

  @override
  String get pkSub => 'Votre code, créneau et lieu.';

  @override
  String get pkWindow => 'Créneau de retrait';

  @override
  String get pkLocation => 'Lieu de retrait';

  @override
  String get pkShowQr => 'Afficher le QR de retrait';

  @override
  String get pkQrLabel => 'QR de retrait';

  @override
  String get pkCodeSub => 'Présentez-le au lieu de l’organisme';

  @override
  String get pkWarn =>
      'Votre code est valable uniquement pour cette demande. Ne le partagez pas.';

  @override
  String get pkReadyTitle => 'Votre commande est prête';

  @override
  String get pkReadyBody =>
      'Présentez votre code pendant le créneau de retrait ci-dessous.';

  @override
  String get pkConfirmedTitle => 'Retrait confirmé';

  @override
  String get pkConfirmedBody =>
      'Le personnel a scanné votre code. Votre demande est terminée.';

  @override
  String get pkCompletedTitle => 'Retrait terminé';

  @override
  String get pkCompletedBody => 'Merci d’utiliser Savvi.';

  @override
  String get pkMissedTitle => 'Créneau de retrait expiré';

  @override
  String get pkMissedBody =>
      'Le créneau de retrait est passé. Contactez votre partenaire associatif pour le reprogrammer.';

  @override
  String get pkReschedule => 'Demander un nouvel horaire';

  @override
  String get pkReschedSent =>
      'Votre partenaire associatif a été invité à reprogrammer le retrait.';

  @override
  String get directions => 'Itinéraire';

  @override
  String get scanAtCounter => 'Scanner au comptoir';

  @override
  String get nonprofitLabel => 'Organisme à but non lucratif';

  @override
  String get naLabel => 'Non renseigné';

  @override
  String get protoNote =>
      'Simulation de prototype — non connectée à un serveur en direct.';

  @override
  String get notifTitle => 'Notifications';

  @override
  String get notifSub =>
      'Mises à jour des demandes et alertes d’accès à l’alimentation.';

  @override
  String get notifEmptyTitle => 'Vous êtes à jour';

  @override
  String get notifEmptyBody =>
      'Vous n’avez aucune notification pour le moment.';

  @override
  String get markAllRead => 'Tout marquer comme lu';

  @override
  String get clearAllNotifs => 'Tout effacer';

  @override
  String get markedReadOk =>
      'Toutes les notifications ont été marquées comme lues.';

  @override
  String get clearedOk => 'Notifications effacées.';

  @override
  String get clearConfirmTitle => 'Effacer toutes les notifications ?';

  @override
  String get clearConfirmBody =>
      'Toutes les notifications seront retirées de cette liste. Cette action est irréversible.';

  @override
  String get cancelAction => 'Annuler';

  @override
  String get prefsTitle => 'Préférences de notification';

  @override
  String get prefsSub => 'Choisissez comment recevoir les nouvelles de Savvi.';

  @override
  String get prefsChNote =>
      'Savvi utilise uniquement les notifications dans l’application, les notifications push et les e-mails.';

  @override
  String get prefsSaved => 'Préférences de notification enregistrées';

  @override
  String get chInApp => 'Dans l’application';

  @override
  String get chInAppDesc =>
      'Toujours activé. Affiché dans votre centre de notifications.';

  @override
  String get chPush => 'Notifications push';

  @override
  String get chPushDesc =>
      'Alertes sur votre téléphone lorsque votre demande change.';

  @override
  String get chEmail => 'E-mail';

  @override
  String get chEmailDesc =>
      'Copie des mises à jour importantes envoyée à votre adresse e-mail.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get personalInformation => 'Informations personnelles';

  @override
  String get contactDetails => 'Coordonnées';

  @override
  String get saveContact => 'Enregistrer les coordonnées';

  @override
  String get contactSaved => 'Profil mis à jour';

  @override
  String get usedInRequests => 'Utilisé dans les demandes alimentaires';

  @override
  String get activeLabel => 'Actif';

  @override
  String get zipNote =>
      'Le code postal contribue aux rapports sur l’accès alimentaire et les zones de service.';

  @override
  String get phoneNote =>
      'Votre numéro aide l’association à coordonner le retrait, la livraison ou l’assistance. Les SMS ne sont pas utilisés dans la version MVP.';

  @override
  String get settingsHelp => 'Paramètres et aide';

  @override
  String get openSettings => 'Ouvrir les paramètres';

  @override
  String get householdSize => 'Taille du foyer';

  @override
  String get signedOut => 'Vous êtes déconnecté.';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get signOutConfirm => 'Se déconnecter de Savvi ?';

  @override
  String get profileDietSub =>
      'Transmis avec les demandes alimentaires uniquement pour préparer les colis de l’association.';

  @override
  String get profileAlgSub =>
      'Inclus pour permettre au personnel de préparer les colis en toute sécurité.';

  @override
  String get errFix => 'Veuillez corriger les champs en surbrillance.';

  @override
  String get savingLabel => 'Enregistrement…';

  @override
  String get returnToRequest => 'Retour à la demande';

  @override
  String get returnToRequestBody =>
      'Vous étiez en train de remplir une demande d’aide alimentaire.';

  @override
  String get householdConfirm => 'Veuillez confirmer la taille de votre foyer.';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsSub => 'Gérez votre compte et obtenez de l’aide.';

  @override
  String get sPersonal => 'Profil';

  @override
  String get sPersonalDesc => 'Nom, contact, adresse, ménage';

  @override
  String get sLang => 'Langue';

  @override
  String get sNotif => 'Notifications';

  @override
  String get sNotifDesc => 'Canaux et préférences';

  @override
  String get sSecurity => 'Sécurité et mot de passe';

  @override
  String get sSecurityDesc => 'Modifier votre mot de passe';

  @override
  String get sHelp => 'Aide et assistance';

  @override
  String get sHelpDesc => 'Contacter votre partenaire associatif';

  @override
  String get langHelp => 'Choisissez la langue d’affichage de Savvi.';

  @override
  String get langSaved => 'Langue mise à jour';

  @override
  String get langEnglish => 'Anglais';

  @override
  String get langSpanish => 'Espagnol';

  @override
  String get closeAction => 'Fermer';

  @override
  String get signOutBody => 'Vous devrez vous reconnecter pour utiliser Savvi.';

  @override
  String get securityHelper =>
      'Utilisez cette option pour demander un lien sécurisé de réinitialisation du mot de passe de votre compte Savvi.';

  @override
  String get sendResetLink => 'Envoyer le lien de réinitialisation';

  @override
  String get resetLinkSent =>
      'Lien de réinitialisation envoyé. Consultez votre e-mail pour la suite.';

  @override
  String get resetLinkError =>
      'Impossible d’envoyer le lien. Veuillez réessayer.';

  @override
  String get resetEmailLabel => 'Le lien de réinitialisation sera envoyé à';

  @override
  String get helpContactPlaceholder =>
      'Les coordonnées apparaîtront ici lorsqu’elles seront disponibles.';

  @override
  String get resetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordSubtitle =>
      'Nous enverrons un code à 6 chiffres à votre adresse e-mail.';

  @override
  String get sendResetLinkBtn => 'Envoyer le code';

  @override
  String get checkYourInboxTitle => 'Consultez votre boîte de réception.';

  @override
  String resetLinkSentBody(String email) {
    return 'Nous avons envoyé un lien de réinitialisation à $email. Il expire dans 15 minutes.';
  }

  @override
  String get iHaveTheLink => 'J’ai le lien →';

  @override
  String get resendLinkBtn => 'Renvoyer le lien';

  @override
  String resendInSeconds(int seconds) {
    return 'Renvoyer dans $seconds s';
  }

  @override
  String get newPasswordTitle => 'Nouveau mot de passe';

  @override
  String get newPasswordSubtitle =>
      'Au moins 8 caractères, avec une majuscule, un chiffre et un caractère spécial.';

  @override
  String get fieldNewPassword => 'Nouveau mot de passe';

  @override
  String get hintCreatePassword => 'Créer un mot de passe';

  @override
  String get fieldConfirmPassword => 'Confirmer le mot de passe';

  @override
  String get hintReenterPassword => 'Saisir à nouveau le nouveau mot de passe';

  @override
  String get updatePasswordBtn => 'Mettre à jour le mot de passe';

  @override
  String get passwordMustMeetAllFour =>
      'Le mot de passe doit respecter les quatre exigences.';

  @override
  String get valPasswordMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get passwordUpdatedTitle => 'Mot de passe mis à jour.';

  @override
  String get passwordUpdatedBody =>
      'Le mot de passe de votre compte Savvi a été modifié. Connectez-vous avec votre nouveau mot de passe.';

  @override
  String get goToSignIn => 'Aller à la connexion';

  @override
  String get checkInboxTitle => 'Saisir le code de vérification';

  @override
  String checkInboxBody(String email) {
    return 'Nous avons envoyé un code à 6 chiffres à $email. Saisissez-le ci-dessous pour continuer.';
  }

  @override
  String get resendLink => 'Renvoyer le code';

  @override
  String get otpVerifyBtn => 'Vérifier le code';

  @override
  String get otpIncomplete => 'Saisissez le code à 6 chiffres.';

  @override
  String get otpInvalid => 'Code invalide ou expiré. Veuillez réessayer.';

  @override
  String get otpSendFailed =>
      'Impossible d’envoyer le code. Veuillez réessayer.';

  @override
  String get otpResent => 'Un nouveau code a été envoyé.';

  @override
  String get confirmPasswordMismatch =>
      'Les mots de passe ne correspondent pas.';

  @override
  String get edit => 'Modifier';

  @override
  String get editHouseholdNote =>
      'Pour le moment, la taille du ménage se gère depuis votre profil.';
}
