// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'Hoy';

  @override
  String get relYesterday => 'Ayer';

  @override
  String get relTomorrow => 'Mañana';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionRetry => 'Intentar de nuevo';

  @override
  String get actionClose => 'Cerrar';

  @override
  String get actionGoToProfile => 'Ir al perfil';

  @override
  String get stateLoading => 'Cargando…';

  @override
  String get stateEmptyTitle => 'Aún no hay nada aquí';

  @override
  String get stateErrorTitle => 'Algo salió mal';

  @override
  String get stateSuccessTitle => 'Listo';

  @override
  String get errNetwork =>
      'Sin conexión. Revisa tu internet e intenta de nuevo.';

  @override
  String get errTimeout => 'Tardó demasiado. Intenta de nuevo.';

  @override
  String get errUnauthorized => 'Tu sesión terminó. Inicia sesión de nuevo.';

  @override
  String get errServer =>
      'Tuvimos un problema. Intenta de nuevo en un momento.';

  @override
  String get errUnknown => 'Algo salió mal. Intenta de nuevo.';

  @override
  String get valRequired => 'Este campo es obligatorio.';

  @override
  String get valEmail => 'Ingresa un correo electrónico válido.';

  @override
  String get valPhoneRequired =>
      'Ingresa tu número de teléfono para continuar.';

  @override
  String get valPhoneInvalid => 'Ingresa un número de teléfono válido.';

  @override
  String get valZip => 'Ingresa un código postal válido.';

  @override
  String get phoneHelp =>
      'El número de teléfono es obligatorio para que la organización aliada pueda coordinar de forma segura la recogida, la entrega o el apoyo de tu solicitud de alimentos. Savvi no usa notificaciones SMS para el MVP.';

  @override
  String get unitLbs => 'lbs';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMin => 'min';

  @override
  String get stSubmitted => 'Enviada';

  @override
  String get stNeedsUpdate => 'Requiere actualización';

  @override
  String get stApproved => 'Aprobada';

  @override
  String get stScheduled => 'Programada';

  @override
  String get stPreparing => 'En preparación';

  @override
  String get stReadyPickup => 'Lista para recoger';

  @override
  String get stPickupConfirmed => 'Recogida confirmada';

  @override
  String get stOutForDelivery => 'En camino';

  @override
  String get stNearby => 'Cerca';

  @override
  String get stDelivered => 'Entregada';

  @override
  String get stDelayed => 'Retrasada';

  @override
  String get stUnavailable => 'No disponible';

  @override
  String get stCompleted => 'Completada';

  @override
  String get stMissed => 'Perdida';

  @override
  String get stDeclined => 'Rechazada';

  @override
  String get stCancelled => 'Cancelada';

  @override
  String get actionBack => 'Atrás';

  @override
  String get actionSignIn => 'Iniciar sesión';

  @override
  String get actionSignInShort => 'Inicia sesión';

  @override
  String get signInTagline =>
      'La manera Savvi de solicitar alimentos para las familias.';

  @override
  String get signInSubtitle =>
      'Los miembros inician sesión abajo. Los nuevos miembros necesitan un enlace de acceso de una organización aliada.';

  @override
  String get fieldEmail => 'Correo electrónico';

  @override
  String get fieldPassword => 'Contraseña';

  @override
  String get hintEmail => 'tú@ejemplo.com';

  @override
  String get hintPassword => 'Tu contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get newMemberPrompt => '¿Nuevo miembro?';

  @override
  String get createWithAccessLink => 'Crear cuenta con enlace de acceso';

  @override
  String get accessTitle => 'Verifica tu acceso';

  @override
  String get accessSubtitle =>
      'Pega el enlace que te envió tu organización aliada, o escanea el código QR en un lugar de inscripción de Savvi.';

  @override
  String get accessInviteNote =>
      'Savvi es solo por invitación. El personal de la organización aliada envía los enlaces de acceso, que vencen después de 48 horas.';

  @override
  String get accessPasteLabel => 'Pega el enlace o código de acceso';

  @override
  String get accessPasteHint => 'Pega tu enlace o código';

  @override
  String get accessVerifyBtn => 'Verificar enlace de acceso';

  @override
  String get orDivider => 'o';

  @override
  String get accessScanTitle => 'Escanear código QR de la organización';

  @override
  String get accessScanSubtitle =>
      'Para inscripción estándar o eventos de aprobación automática en el lugar';

  @override
  String get accessVerifiedTitle => 'Acceso verificado.';

  @override
  String get accessVerifiedBody =>
      'Completa el perfil de tu cuenta para enviarlo a aprobación.';

  @override
  String get accessOnsiteTitle =>
      'Inscripción presencial de confianza detectada.';

  @override
  String get accessOnsiteBody =>
      'Completa tu perfil para recibir aprobación instantánea del personal de la organización aliada en el lugar.';

  @override
  String get accessContinueBtn => 'Continuar para crear la cuenta';

  @override
  String get accessContinueHint =>
      'Verifica tu enlace de acceso o escanea un código QR para continuar.';

  @override
  String get accessErrEmpty => 'Primero pega tu enlace o código de acceso.';

  @override
  String get accessErrExpired =>
      'Este enlace de acceso venció. Pide uno nuevo a tu organización aliada.';

  @override
  String get accessErrUsed => 'Este enlace de acceso ya se usó.';

  @override
  String get accessErrInvalid =>
      'No pudimos verificar ese enlace o código. Revísalo e intenta de nuevo.';

  @override
  String get qrTitle => 'Escanear acceso QR';

  @override
  String get qrSubtitle =>
      'Apunta tu cámara al código QR de la organización, o ingresa el código abajo.';

  @override
  String get qrScanBtn => 'Abrir cámara para escanear';

  @override
  String get qrEnterLabel => 'Ingresar el código manualmente';

  @override
  String get qrCameraStaged =>
      'El escaneo con cámara se activa durante la configuración del dispositivo. Por ahora, ingresa abajo el código de tu organización aliada.';

  @override
  String get signUpTitle => 'Crea tu cuenta';

  @override
  String get signUpSubtitle =>
      'Completa tu perfil para solicitar la aprobación de la organización aliada.';

  @override
  String get signUpAccessRequiredTitle => 'Se requiere enlace de acceso';

  @override
  String get signUpAccessRequiredBody =>
      'Necesitas un enlace de acceso o código QR de una organización aliada para crear una cuenta de Savvi.';

  @override
  String get signUpAccessVerifiedTitle => 'Acceso verificado';

  @override
  String get signUpAccessVerifiedBody =>
      'Completa tu perfil y envíalo a aprobación.';

  @override
  String get fieldFirstName => 'Nombre';

  @override
  String get fieldLastName => 'Apellido';

  @override
  String get fieldPhone => 'Número de teléfono';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'Dirección';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'Ciudad';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'Estado';

  @override
  String get fieldZip => 'Código postal';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'Tamaño del hogar';

  @override
  String householdPerson(int count) {
    return '$count persona';
  }

  @override
  String householdPeople(int count) {
    return '$count personas';
  }

  @override
  String get householdPeopleMax => '10+ personas';

  @override
  String get pwdReqLength => '8+ caracteres';

  @override
  String get pwdReqUpper => 'Mayúscula';

  @override
  String get pwdReqNumber => 'Número';

  @override
  String get pwdReqSpecial => 'Carácter especial';

  @override
  String get consentText =>
      'Acepto la Política de Privacidad de Savvi y consiento que los datos de mi hogar se compartan con mi organización aliada únicamente para fines de apoyo alimentario.';

  @override
  String get consentRequired => 'Acepta para continuar.';

  @override
  String get signUpApprovalNote =>
      'Tu cuenta debe ser aprobada por una organización aliada antes de que puedas enviar solicitudes de alimentos.';

  @override
  String get signUpSubmitBtn => 'Enviar a aprobación';

  @override
  String get haveAccountPrompt => '¿Ya tienes una cuenta?';

  @override
  String get approvalHeroTitle => 'Ya casi está.';

  @override
  String get approvalHeroBody =>
      'Tu perfil está con la organización aliada. La aprobación está muy cerca.';

  @override
  String get stepSubmitted => 'Enviado';

  @override
  String get stepReview => 'Revisión';

  @override
  String get stepApproved => 'Aprobado';

  @override
  String get approvalStatusLabel => 'Estado';

  @override
  String get approvalPendingBadge => 'Revisión pendiente';

  @override
  String get approvalRow1Title => 'Perfil enviado';

  @override
  String get approvalRow1Body => 'Recibimos los datos de tu cuenta hoy';

  @override
  String get approvalRow2Title => 'Revisión de la organización en curso';

  @override
  String get approvalRow2Body =>
      'Tu organización aliada está revisando tu perfil ahora';

  @override
  String get approvalRow3Title => 'Decisión de aprobación';

  @override
  String get approvalRow3Body =>
      'Te avisaremos por notificación push y correo electrónico';

  @override
  String get approvalMotivTitle => 'Se acercan cosas buenas.';

  @override
  String get approvalMotivBody =>
      'La mayoría de las aprobaciones se completan en 1–2 días hábiles. Recibirás una notificación en cuanto tu acceso esté listo.';

  @override
  String get trackApprovalBtn => 'Ver estado de aprobación';

  @override
  String get backToSignIn => 'Volver a iniciar sesión';

  @override
  String get approvedTitle => '¡Estás aprobado!';

  @override
  String get approvedBody =>
      'Tu organización aliada aprobó tu cuenta. Ya puedes solicitar apoyo alimentario.';

  @override
  String get approvedCta => 'Ir al inicio';

  @override
  String get declinedTitle => 'Aprobación no otorgada';

  @override
  String get declinedBody =>
      'Tu organización aliada no pudo aprobar esta cuenta. Comunícate con ellos para los próximos pasos.';

  @override
  String get needsReviewTitle => 'Se necesita revisión adicional';

  @override
  String get needsReviewBody =>
      'Tu organización aliada necesita un poco más de información antes de aprobar. Se comunicarán por notificación push y correo electrónico.';

  @override
  String get pwdNotMet => 'La contraseña aún no cumple todos los requisitos.';

  @override
  String get requestIdLabel => 'ID de solicitud';

  @override
  String get catProduce => 'Frutas y verduras';

  @override
  String get catDairy => 'Lácteos';

  @override
  String get catMeatProtein => 'Carne / Proteína';

  @override
  String get catPreparedMeals => 'Comidas preparadas';

  @override
  String get catBakeryBread => 'Panadería / Pan';

  @override
  String get catPantry => 'Despensa';

  @override
  String get catFrozen => 'Congelados';

  @override
  String get catSnacksBeverages => 'Snacks y bebidas';

  @override
  String get catBabyFood => 'Comida para bebé';

  @override
  String get catInfantFormula => 'Fórmula infantil';

  @override
  String get catControlledNote =>
      'Artículo controlado — puede requerir revisión adicional';

  @override
  String get navHome => 'Inicio';

  @override
  String get navAlerts => 'Avisos';

  @override
  String get navEvents => 'Eventos';

  @override
  String get navRequest => 'Solicitar';

  @override
  String get navActivity => 'Actividad';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navSettings => 'Configuración';

  @override
  String get greetMorning => 'Buenos días';

  @override
  String get greetAfternoon => 'Buenas tardes';

  @override
  String get greetEvening => 'Buenas noches';

  @override
  String get homeCtaTitle => 'Solicitar apoyo alimentario';

  @override
  String get homeCtaBody => 'Sin filas. Recogida o entrega.';

  @override
  String get homeCtaBtn => 'Solicitar →';

  @override
  String get homeNoActive => 'Sin solicitud activa';

  @override
  String get homeNoActiveBody =>
      'Cuando solicites apoyo alimentario, lo verás aquí.';

  @override
  String etaAway(String eta) {
    return 'a $eta';
  }

  @override
  String milesAway(String miles) {
    return 'a $miles';
  }

  @override
  String get alertsTitle => 'Acceso a alimentos';

  @override
  String get alertsSubtitle =>
      'Comidas calientes, distribuciones y entregas cerca de ti.';

  @override
  String get alertTypeHot => 'Aviso de comida caliente';

  @override
  String get alertTypeDist => 'Evento de distribución';

  @override
  String alertSpotsLeft(int count) {
    return '$count disponibles';
  }

  @override
  String get alertRsvpPrompt => 'Selecciona para cuántas personas reservas.';

  @override
  String get alertRsvpConfirm => 'Voy a asistir';

  @override
  String alertRsvpConfirmed(int count) {
    return 'Asistencia confirmada para $count';
  }

  @override
  String get alertRsvpChange => 'Cambiar';

  @override
  String get alertRsvpCancel => 'Cancelar asistencia';

  @override
  String get alertsEmpty => 'No hay avisos por ahora';

  @override
  String get alertsEmptyBody =>
      'Te avisaremos cuando haya comida disponible cerca.';

  @override
  String get tryAgain => 'Reintentar';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get savviMember => 'Miembro Savvi';

  @override
  String get homeSub => 'Tu apoyo alimentario, entregado con dignidad.';

  @override
  String householdOf(String count) {
    return 'Hogar de $count';
  }

  @override
  String get tileAlertsTitle => 'Avisos de acceso a alimentos';

  @override
  String get tileAlertsSub => 'Comidas calientes y eventos cerca';

  @override
  String get tileReqTitle => 'Mis solicitudes';

  @override
  String get tileReqSub => 'Estado y detalles de recogida';

  @override
  String get activeRequest => 'Solicitud activa';

  @override
  String alertRsvpMax(int count) {
    return 'Máx $count · tamaño de tu hogar';
  }

  @override
  String get alertRsvpSeeYou => '¡Te esperamos. Gracias!';

  @override
  String get alertRsvpCancelled => 'Tu asistencia fue cancelada.';

  @override
  String get alertRsvpSelectFirst =>
      'Por favor selecciona al menos 1 antes de confirmar.';

  @override
  String get reqTitle => 'Solicitar apoyo';

  @override
  String reqStep(int n, int t) {
    return 'Paso $n de $t';
  }

  @override
  String get s1Title => '¿Qué te ayudaría más?';

  @override
  String get s1Sub => 'Selecciona una o más categorías.';

  @override
  String get s2Title => '¿Recogida o entrega?';

  @override
  String get s2Sub => 'Elige cómo quieres recibir tu apoyo.';

  @override
  String get s3Title => 'Hogar y contacto';

  @override
  String get s3Sub =>
      'Provienen de tu perfil. Actualízalos ahí si algo cambió.';

  @override
  String get s4Title => 'Dieta y alérgenos';

  @override
  String get s4Sub => 'Se envía a la organización solo para el empaque.';

  @override
  String get s5Title => 'Revisa tu solicitud';

  @override
  String get s5Sub => 'Verifica todo antes de enviar.';

  @override
  String get stepNext => 'Siguiente';

  @override
  String get stepBack => 'Atrás';

  @override
  String get methodPickup => 'Recogida';

  @override
  String get methodDelivery => 'Entrega';

  @override
  String get pickupDesc =>
      'Recoge con tu código en el lugar de la organización.';

  @override
  String get deliveryDesc =>
      'Entregado en tu domicilio. Seguimiento en vivo en la app.';

  @override
  String get controlledItem => 'Artículo controlado';

  @override
  String get formulaNote =>
      'La disponibilidad de fórmula infantil depende de la aprobación de la organización, el empaque sellado, la fecha de caducidad y la elegibilidad del programa.';

  @override
  String get formulaAck => 'Entiendo';

  @override
  String get notesLabel => 'Notas para la organización';

  @override
  String get notesHint => '¿Algo útil que la organización deba saber?';

  @override
  String get fromProfile => 'De tu perfil';

  @override
  String get editInProfile => 'Editar en el perfil';

  @override
  String get dietTitle => 'Preferencias dietéticas';

  @override
  String get allergensTitle => 'Alérgenos';

  @override
  String get dSenior => 'Alimentos para personas mayores';

  @override
  String get dLowSodium => 'Bajo en sodio';

  @override
  String get dDiabetic => 'Apto para diabéticos';

  @override
  String get dVegetarian => 'Vegetariano';

  @override
  String get dVegan => 'Vegano';

  @override
  String get dHalal => 'Apto halal';

  @override
  String get dNoPork => 'Sin cerdo';

  @override
  String get dGlutenFree => 'Sin gluten';

  @override
  String get gPeanuts => 'Cacahuetes';

  @override
  String get gTreeNuts => 'Frutos secos';

  @override
  String get gMilk => 'Leche / Lácteos';

  @override
  String get gEggs => 'Huevos';

  @override
  String get gSoy => 'Soya';

  @override
  String get gWheat => 'Trigo / Gluten';

  @override
  String get gFish => 'Pescado';

  @override
  String get gShellfish => 'Mariscos';

  @override
  String get gSesame => 'Sésamo';

  @override
  String get rvCats => 'Categorías';

  @override
  String get rvMethod => 'Método';

  @override
  String get rvHousehold => 'Hogar';

  @override
  String get rvContact => 'Contacto';

  @override
  String get rvAddress => 'Dirección';

  @override
  String get rvDiet => 'Dieta';

  @override
  String get rvAlg => 'Alérgenos';

  @override
  String get rvNotes => 'Notas';

  @override
  String get rvNone => 'Ninguno';

  @override
  String get submitRequest => 'Enviar solicitud';

  @override
  String get reqOkTitle => 'Solicitud enviada.';

  @override
  String reqOkBody(String np) {
    return '$np revisará y confirmará tu solicitud. Recibirás una notificación con la decisión.';
  }

  @override
  String get viewRequest => 'Ver solicitud';

  @override
  String get backHome => 'Volver al inicio';

  @override
  String get errNoCat => 'Selecciona al menos una categoría.';

  @override
  String get errNoMethod => 'Elige recogida o entrega.';

  @override
  String get deliveryUnavail =>
      'La entrega no está disponible para esta solicitud en este momento. La recogida puede estar disponible.';

  @override
  String get deliveryChecking => 'Verificando disponibilidad de entrega…';

  @override
  String get deliveryAvailError =>
      'No se pudo verificar la disponibilidad de entrega. Reintentar.';

  @override
  String get actTitle => 'Mis solicitudes';

  @override
  String get actSub => 'Códigos de recogida, estado de entrega e historial.';

  @override
  String get tabActive => 'Activas';

  @override
  String get tabHistory => 'Historial';

  @override
  String get tabAll => 'Todas';

  @override
  String get actEmptyTitle => 'Sin solicitudes aquí';

  @override
  String get actEmptyBody =>
      'Las solicitudes que envíes aparecerán en esta lista.';

  @override
  String get statusLabel => 'Estado';

  @override
  String get weightLabel => 'Peso';

  @override
  String get pickupCodeLabel => 'Código de recogida';

  @override
  String get viewDetails => 'Ver detalles';

  @override
  String get trackDelivery => 'Seguir entrega';

  @override
  String get viewPickup => 'Ver detalles de recogida';

  @override
  String get editRequest => 'Editar solicitud';

  @override
  String get cancelRequest => 'Cancelar solicitud';

  @override
  String get editLocked => 'Esta solicitud ya no se puede editar.';

  @override
  String get cancelConfirmTitle => '¿Cancelar esta solicitud?';

  @override
  String get cancelConfirmBody =>
      'Esto no se puede deshacer. Tu organización aliada será notificada.';

  @override
  String get keepRequest => 'Conservar solicitud';

  @override
  String get requestCancelled => 'Solicitud cancelada.';

  @override
  String get notFoundTitle => 'Solicitud no encontrada';

  @override
  String get trackTitle => 'Estado de entrega';

  @override
  String get trackSub =>
      'Actualizaciones en vivo mientras tu entrega está activa.';

  @override
  String get trackWay => 'Tu entrega está en camino';

  @override
  String get trackNear => 'Tu entrega está cerca';

  @override
  String get trackEtaLine => 'Llegada estimada: 20–30 minutos';

  @override
  String get trackEtaNear => 'Llegada estimada: menos de 5 minutos';

  @override
  String get trackEst => 'Estimado';

  @override
  String get trackDist => 'Distancia';

  @override
  String get trackPrivacy =>
      'Por tu privacidad, no se muestran los datos del conductor ni las rutas exactas. Te avisaremos cuando llegue tu entrega.';

  @override
  String get trackDelayedTitle => 'Tu entrega está retrasada';

  @override
  String get trackDelayedBody =>
      'Tu organización está trabajando en un nuevo horario. Te avisaremos en cuanto se actualice.';

  @override
  String get trackUnavailTitle => 'Entrega no disponible';

  @override
  String get trackUnavailBody =>
      'No se pudo completar la entrega de esta solicitud. La recogida puede estar disponible — contacta a tu organización.';

  @override
  String get trackDoneTitle => 'Entrega completada';

  @override
  String get trackDoneBody => 'Tu entrega llegó. Gracias por usar Savvi.';

  @override
  String get switchPickup => 'Preguntar por recogida';

  @override
  String get pkTitle => 'Detalles de recogida';

  @override
  String get pkSub => 'Tu código, horario y ubicación.';

  @override
  String get pkWindow => 'Horario de recogida';

  @override
  String get pkLocation => 'Lugar de recogida';

  @override
  String get pkShowQr => 'Mostrar QR de recogida';

  @override
  String get pkQrLabel => 'QR de recogida';

  @override
  String get pkCodeSub => 'Muéstralo en el lugar de la organización';

  @override
  String get pkWarn =>
      'Tu código es válido solo para esta solicitud. No lo compartas.';

  @override
  String get pkReadyTitle => 'Tu recogida está lista';

  @override
  String get pkReadyBody =>
      'Lleva tu código durante el horario indicado abajo.';

  @override
  String get pkConfirmedTitle => 'Recogida confirmada';

  @override
  String get pkConfirmedBody =>
      'El personal escaneó tu código. Tu solicitud está completa.';

  @override
  String get pkCompletedTitle => 'Recogida completada';

  @override
  String get pkCompletedBody => 'Gracias por usar Savvi.';

  @override
  String get pkMissedTitle => 'El horario de recogida cerró';

  @override
  String get pkMissedBody =>
      'El horario de recogida ya pasó. Contacta a tu organización para reprogramar.';

  @override
  String get pkReschedule => 'Solicitar un nuevo horario';

  @override
  String get pkReschedSent => 'Se le pidió a tu organización reprogramar.';

  @override
  String get directions => 'Cómo llegar';

  @override
  String get scanAtCounter => 'Escanear en el mostrador';

  @override
  String get nonprofitLabel => 'Organización';

  @override
  String get naLabel => 'No proporcionado';

  @override
  String get protoNote =>
      'Simulación de prototipo — no conectado a un backend en vivo.';

  @override
  String get notifTitle => 'Notificaciones';

  @override
  String get notifSub =>
      'Actualizaciones de solicitudes y avisos de alimentos.';

  @override
  String get notifEmptyTitle => 'Estás al día';

  @override
  String get notifEmptyBody => 'No tienes notificaciones ahora.';

  @override
  String get markAllRead => 'Marcar todo leído';

  @override
  String get clearAllNotifs => 'Borrar todo';

  @override
  String get markedReadOk => 'Todas marcadas como leídas.';

  @override
  String get clearedOk => 'Notificaciones borradas.';

  @override
  String get clearConfirmTitle => '¿Borrar todas las notificaciones?';

  @override
  String get clearConfirmBody =>
      'Esto elimina todas las notificaciones de la lista. No se puede deshacer.';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get prefsTitle => 'Preferencias de notificación';

  @override
  String get prefsSub => 'Elige cómo quieres recibir avisos de Savvi.';

  @override
  String get prefsChNote => 'Savvi usa solo la app, push y correo electrónico.';

  @override
  String get prefsSaved => 'Preferencia de notificación guardada';

  @override
  String get chInApp => 'En la app';

  @override
  String get chInAppDesc =>
      'Siempre activo. Se muestra en tu centro de notificaciones.';

  @override
  String get chPush => 'Notificaciones push';

  @override
  String get chPushDesc => 'Avisos en tu teléfono cuando cambie tu solicitud.';

  @override
  String get chEmail => 'Correo electrónico';

  @override
  String get chEmailDesc =>
      'Una copia de las actualizaciones importantes a tu correo.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get contactDetails => 'Datos de contacto';

  @override
  String get saveContact => 'Guardar datos de contacto';

  @override
  String get contactSaved => 'Perfil actualizado';

  @override
  String get usedInRequests => 'Se usa en las solicitudes';

  @override
  String get activeLabel => 'Activo';

  @override
  String get zipNote =>
      'El código postal apoya el acceso a alimentos y los reportes de área de servicio.';

  @override
  String get phoneNote =>
      'Tu número de teléfono ayuda a la organización aliada a coordinar la recogida, la entrega o el apoyo. No se usan notificaciones SMS para el MVP.';

  @override
  String get settingsHelp => 'Ajustes y ayuda';

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get householdSize => 'Tamaño del hogar';

  @override
  String get signedOut => 'Se cerró tu sesión.';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutConfirm => '¿Cerrar sesión de Savvi?';

  @override
  String get profileDietSub =>
      'Se envía con las solicitudes solo para el empaque.';

  @override
  String get profileAlgSub =>
      'Se incluye para que el personal empaque de forma segura.';

  @override
  String get errFix => 'Corrige los campos marcados.';

  @override
  String get savingLabel => 'Guardando…';

  @override
  String get returnToRequest => 'Volver a la solicitud';

  @override
  String get returnToRequestBody => 'Estabas completando una solicitud.';

  @override
  String get householdConfirm => 'Confirma el tamaño de tu hogar.';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsSub => 'Administra tu cuenta y obtén ayuda.';

  @override
  String get sPersonal => 'Información personal';

  @override
  String get sPersonalDesc => 'Nombre, contacto, dirección, hogar';

  @override
  String get sLang => 'Idioma';

  @override
  String get sNotif => 'Notificaciones';

  @override
  String get sNotifDesc => 'Canales y preferencias';

  @override
  String get sSecurity => 'Seguridad y contraseña';

  @override
  String get sSecurityDesc => 'Actualiza tu contraseña';

  @override
  String get sHelp => 'Ayuda y soporte';

  @override
  String get sHelpDesc => 'Contacta a tu organización';

  @override
  String get langHelp =>
      'Inglés y español están disponibles para el MVP. Pronto habrá más idiomas.';

  @override
  String get langSaved => 'Idioma actualizado';

  @override
  String get langEnglish => 'English';

  @override
  String get langSpanish => 'Español';

  @override
  String get closeAction => 'Cerrar';

  @override
  String get signOutBody => 'Deberás iniciar sesión de nuevo para usar Savvi.';

  @override
  String get securityHelper =>
      'Úsalo para solicitar un enlace seguro para restablecer la contraseña de tu cuenta de Savvi.';

  @override
  String get sendResetLink => 'Enviar enlace para restablecer contraseña';

  @override
  String get resetLinkSent =>
      'Enlace de restablecimiento enviado. Revisa tu correo para los siguientes pasos.';

  @override
  String get resetLinkError =>
      'No pudimos enviar el enlace. Inténtalo de nuevo.';

  @override
  String get resetEmailLabel => 'El enlace se enviará a';

  @override
  String get helpContactPlaceholder =>
      'Los datos de contacto aparecerán aquí cuando estén disponibles.';

  @override
  String get resetPasswordTitle => 'Restablecer contraseña';

  @override
  String get resetPasswordSubtitle =>
      'Enviaremos un enlace de restablecimiento a tu correo.';

  @override
  String get sendResetLinkBtn => 'Enviar enlace';

  @override
  String get checkYourInboxTitle => 'Revisa tu correo.';

  @override
  String resetLinkSentBody(String email) {
    return 'Enviamos un enlace de restablecimiento a $email. El enlace vence en 15 minutos.';
  }

  @override
  String get iHaveTheLink => 'Tengo el enlace →';

  @override
  String get resendLinkBtn => 'Reenviar enlace';

  @override
  String resendInSeconds(int seconds) {
    return 'Reenviar en ${seconds}s';
  }

  @override
  String get newPasswordTitle => 'Nueva contraseña';

  @override
  String get newPasswordSubtitle =>
      'Al menos 8 caracteres con mayúscula, número y carácter especial.';

  @override
  String get fieldNewPassword => 'Nueva contraseña';

  @override
  String get hintCreatePassword => 'Crea una contraseña';

  @override
  String get fieldConfirmPassword => 'Confirmar contraseña';

  @override
  String get hintReenterPassword => 'Vuelve a ingresar la contraseña';

  @override
  String get updatePasswordBtn => 'Actualizar contraseña';

  @override
  String get passwordMustMeetAllFour =>
      'La contraseña debe cumplir los cuatro requisitos.';

  @override
  String get valPasswordMismatch => 'Las contraseñas no coinciden.';

  @override
  String get passwordUpdatedTitle => 'Contraseña actualizada.';

  @override
  String get passwordUpdatedBody =>
      'Tu contraseña de Savvi ha sido cambiada. Inicia sesión con tu nueva contraseña.';

  @override
  String get goToSignIn => 'Ir a iniciar sesión';

  @override
  String get checkInboxTitle => 'Revisa tu bandeja de entrada.';

  @override
  String checkInboxBody(String email) {
    return 'Enviamos un enlace de restablecimiento a $email. El enlace vence en 15 minutos.';
  }

  @override
  String get resendLink => 'Reenviar enlace';

  @override
  String get confirmPasswordMismatch => 'Las contraseñas no coinciden.';
}
