// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Brazilian Portuguese (`pt_BR`).
class AppLocalizationsPtBR extends AppLocalizations {
  AppLocalizationsPtBR([String locale = 'pt_BR']) : super(locale);

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
  String get errNetwork => 'Sem conexão. Verifique sua internet e tente novamente.';

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
  String get phoneHelp => 'O número de telefone é necessário para que a organização sem fins lucrativos possa coordenar com segurança a retirada, a entrega ou o suporte para sua solicitação de alimentos. O Savvi não usa notificações por SMS no MVP.';

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
  String get signInTagline => 'O jeito Savvi de solicitar apoio alimentar para famílias.';

  @override
  String get signInSubtitle => 'Membros entram abaixo. Novos membros precisam de um link de acesso de uma organização parceira.';

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
  String get accessSubtitle => 'Cole o link enviado pela organização sem fins lucrativos ou leia o código QR em um local de inscrição do Savvi.';

  @override
  String get accessInviteNote => 'O Savvi funciona apenas por convite. Os links de acesso são enviados pela equipe da organização e expiram após 48 horas.';

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
  String get accessScanSubtitle => 'Para inscrições padrão ou eventos confiáveis de aprovação automática no local';

  @override
  String get accessVerifiedTitle => 'Acesso verificado.';

  @override
  String get accessVerifiedBody => 'Complete o perfil da sua conta para enviá-lo para aprovação.';

  @override
  String get accessOnsiteTitle => 'Inscrição confiável no local detectada.';

  @override
  String get accessOnsiteBody => 'Complete seu perfil para receber aprovação imediata da equipe da organização no local.';

  @override
  String get accessContinueBtn => 'Continuar para criar conta';

  @override
  String get accessContinueHint => 'Verifique seu link de acesso ou leia um código QR para continuar.';

  @override
  String get accessErrEmpty => 'Cole primeiro seu link ou código de acesso.';

  @override
  String get accessErrExpired => 'Este link de acesso expirou. Peça outro à organização.';

  @override
  String get accessErrUsed => 'Este link de acesso já foi usado.';

  @override
  String get accessErrInvalid => 'Não foi possível verificar esse link ou código. Confira e tente novamente.';

  @override
  String get qrTitle => 'Ler QR de acesso';

  @override
  String get qrSubtitle => 'Aponte a câmera para o código QR da organização ou digite o código abaixo.';

  @override
  String get qrScanBtn => 'Abrir câmera para ler';

  @override
  String get qrEnterLabel => 'Digitar código manualmente';

  @override
  String get qrCameraStaged => 'A leitura pela câmera será ativada durante a configuração do dispositivo. Por enquanto, digite abaixo o código fornecido pela organização.';

  @override
  String get signUpTitle => 'Crie sua conta';

  @override
  String get signUpSubtitle => 'Complete seu perfil para solicitar aprovação da organização.';

  @override
  String get signUpAccessRequiredTitle => 'Link de acesso necessário';

  @override
  String get signUpAccessRequiredBody => 'Você precisa de um link de acesso ou código QR da organização para criar uma conta Savvi.';

  @override
  String get signUpAccessVerifiedTitle => 'Acesso verificado';

  @override
  String get signUpAccessVerifiedBody => 'Complete seu perfil e envie-o para aprovação.';

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
    return '${count} pessoa';
  }

  @override
  String householdPeople(int count) {
    return '${count} pessoas';
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
  String get consentText => 'Concordo com a Política de Privacidade do Savvi e autorizo o compartilhamento dos dados da minha família com a organização parceira exclusivamente para fins de apoio alimentar.';

  @override
  String get consentRequired => 'Concorde para continuar.';

  @override
  String get signUpApprovalNote => 'Sua conta precisa ser aprovada por uma organização sem fins lucrativos antes que você possa enviar solicitações de alimentos.';

  @override
  String get signUpSubmitBtn => 'Enviar para aprovação';

  @override
  String get haveAccountPrompt => 'Já tem uma conta?';

  @override
  String get approvalHeroTitle => 'Você está quase lá.';

  @override
  String get approvalHeroBody => 'Seu perfil está com a organização. A aprovação está próxima.';

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
  String get approvalRow2Body => 'Sua organização parceira está analisando seu perfil agora';

  @override
  String get approvalRow3Title => 'Decisão de aprovação';

  @override
  String get approvalRow3Body => 'Enviaremos uma notificação por push e e-mail';

  @override
  String get approvalMotivTitle => 'Boas notícias estão a caminho.';

  @override
  String get approvalMotivBody => 'A maioria das aprovações é concluída em 1 a 2 dias úteis. Você receberá uma notificação assim que seu acesso estiver liberado.';

  @override
  String get trackApprovalBtn => 'Acompanhar status da aprovação';

  @override
  String get backToSignIn => 'Voltar para entrar';

  @override
  String get approvedTitle => 'Você foi aprovado!';

  @override
  String get approvedBody => 'A organização parceira aprovou sua conta. Agora você pode solicitar apoio alimentar.';

  @override
  String get approvedCta => 'Ir para o início';

  @override
  String get declinedTitle => 'Aprovação não concedida';

  @override
  String get declinedBody => 'A organização parceira não pôde aprovar esta conta. Entre em contato com ela para saber os próximos passos.';

  @override
  String get needsReviewTitle => 'É necessária uma análise adicional';

  @override
  String get needsReviewBody => 'A organização parceira precisa de mais algumas informações antes de aprovar. Ela entrará em contato por notificação push e e-mail.';

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
  String get catControlledNote => 'Item controlado — pode exigir análise adicional';

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
  String get homeNoActiveBody => 'Quando você solicitar apoio alimentar, poderá acompanhar tudo aqui.';

  @override
  String etaAway(String eta) {
    return 'a ${eta} de distância';
  }

  @override
  String milesAway(String miles) {
    return 'a ${miles} milhas';
  }

  @override
  String get alertsTitle => 'Eventos';

  @override
  String get alertsSubtitle => 'Eventos de alimentos da organização parceira perto de você.';

  @override
  String get alertTypeHot => 'Alerta de refeição quente';

  @override
  String get alertTypeDist => 'Evento de distribuição de alimentos';

  @override
  String alertSpotsLeft(int count) {
    return '${count} restantes';
  }

  @override
  String get alertRsvpPrompt => 'Selecione para quantas pessoas você está reservando.';

  @override
  String get alertRsvpConfirm => 'Vou participar';

  @override
  String alertRsvpConfirmed(int count) {
    return 'Presença confirmada para ${count}';
  }

  @override
  String get alertRsvpChange => 'Alterar';

  @override
  String get alertRsvpCancel => 'Cancelar presença';

  @override
  String get alertsEmpty => 'Nenhum alerta no momento';

  @override
  String get alertsEmptyBody => 'Avisaremos quando houver alimentos disponíveis nas proximidades.';

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
    return 'Família de ${count} pessoas';
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
    return 'Máximo de ${count} · tamanho da sua família';
  }

  @override
  String get alertRsvpSeeYou => 'Esperamos você lá. Obrigado!';

  @override
  String get alertRsvpCancelled => 'Sua presença foi cancelada.';

  @override
  String get alertRsvpSelectFirst => 'Selecione pelo menos 1 pessoa antes de confirmar.';

  @override
  String get reqTitle => 'Solicitar apoio alimentar';

  @override
  String reqStep(int n, int t) {
    return 'Etapa ${n} de ${t}';
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
  String get s3Sub => 'Estas informações vêm do seu perfil. Atualize-as lá se algo tiver mudado.';

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
  String get deliveryDesc => 'Entrega no seu endereço. Acompanhe em tempo real pelo aplicativo.';

  @override
  String get controlledItem => 'Item controlado';

  @override
  String get formulaNote => 'A disponibilidade de fórmula infantil depende da aprovação da organização, da embalagem lacrada, da data de validade e dos critérios de elegibilidade do programa.';

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
  String get rvDietNote => 'As preferências alimentares e os alérgenos vêm do seu perfil. Para atualizá-los, acesse Configurações.';

  @override
  String get householdSizeNote => 'Para atualizar o tamanho da família, acesse Configurações. O valor padrão vem do seu perfil. Você pode alterá-lo apenas para esta solicitação.';

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
    return '${np} analisará e confirmará sua solicitação. Você receberá uma notificação com a decisão.';
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
  String get deliveryUnavail => 'A entrega não está disponível para esta solicitação no momento. A retirada ainda pode estar disponível.';

  @override
  String get deliveryChecking => 'Verificando disponibilidade de entrega…';

  @override
  String get deliveryAvailError => 'Não foi possível verificar a disponibilidade da entrega. Tente novamente.';

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
  String get cancelConfirmBody => 'Esta ação não pode ser desfeita. A organização parceira será notificada.';

  @override
  String get keepRequest => 'Manter solicitação';

  @override
  String get requestCancelled => 'Solicitação cancelada.';

  @override
  String get notFoundTitle => 'Solicitação não encontrada';

  @override
  String get trackTitle => 'Status da entrega';

  @override
  String get trackSub => 'Atualizações em tempo real enquanto sua entrega estiver ativa.';

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
  String get trackPrivacy => 'Para sua privacidade, os dados do motorista e as rotas exatas não são exibidos. Você receberá uma notificação quando a entrega chegar.';

  @override
  String get trackDelayedTitle => 'Sua entrega está atrasada';

  @override
  String get trackDelayedBody => 'A organização parceira está trabalhando em um novo horário de chegada. Você será notificado assim que houver atualização.';

  @override
  String get trackUnavailTitle => 'Entrega indisponível';

  @override
  String get trackUnavailBody => 'Não foi possível concluir a entrega desta solicitação. A retirada pode ser uma alternativa — entre em contato com a organização parceira.';

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
  String get pkWarn => 'Seu código é válido apenas para esta solicitação. Não o compartilhe com outras pessoas.';

  @override
  String get pkReadyTitle => 'Sua retirada está pronta';

  @override
  String get pkReadyBody => 'Apresente seu código durante o horário de retirada abaixo.';

  @override
  String get pkConfirmedTitle => 'Retirada confirmada';

  @override
  String get pkConfirmedBody => 'A equipe leu seu código. Sua solicitação foi concluída.';

  @override
  String get pkCompletedTitle => 'Retirada concluída';

  @override
  String get pkCompletedBody => 'Obrigado por usar o Savvi.';

  @override
  String get pkMissedTitle => 'O horário de retirada terminou';

  @override
  String get pkMissedBody => 'O horário de retirada já passou. Entre em contato com a organização parceira para reagendar.';

  @override
  String get pkReschedule => 'Solicitar novo horário';

  @override
  String get pkReschedSent => 'Foi solicitado à organização parceira que reagende.';

  @override
  String get directions => 'Como chegar';

  @override
  String get scanAtCounter => 'Leia no balcão';

  @override
  String get nonprofitLabel => 'Organização sem fins lucrativos';

  @override
  String get naLabel => 'Não informado';

  @override
  String get protoNote => 'Simulação de protótipo — não conectado a um sistema ativo.';

  @override
  String get notifTitle => 'Notificações';

  @override
  String get notifSub => 'Atualizações de solicitações e alertas de acesso a alimentos.';

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
  String get clearConfirmBody => 'Isso remove todas as notificações desta lista. Não é possível desfazer.';

  @override
  String get cancelAction => 'Cancelar';

  @override
  String get prefsTitle => 'Preferências de notificação';

  @override
  String get prefsSub => 'Escolha como receber notícias do Savvi.';

  @override
  String get prefsChNote => 'O Savvi usa apenas notificações no app, push e e-mail.';

  @override
  String get prefsSaved => 'Preferências de notificação salvas';

  @override
  String get chInApp => 'No aplicativo';

  @override
  String get chInAppDesc => 'Sempre ativadas. Exibidas na central de notificações.';

  @override
  String get chPush => 'Notificações push';

  @override
  String get chPushDesc => 'Alertas no celular quando sua solicitação mudar.';

  @override
  String get chEmail => 'E-mail';

  @override
  String get chEmailDesc => 'Uma cópia das atualizações importantes enviada ao seu e-mail.';

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
  String get zipNote => 'O CEP ajuda no acesso a alimentos e nos relatórios da área de atendimento.';

  @override
  String get phoneNote => 'Seu telefone ajuda a organização parceira a coordenar a retirada, a entrega ou o suporte. As notificações por SMS não são usadas no MVP.';

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
  String get profileDietSub => 'Enviado com solicitações de alimentos apenas para orientar a preparação pela organização.';

  @override
  String get profileAlgSub => 'Incluído para que a equipe da organização possa embalar os alimentos com segurança.';

  @override
  String get errFix => 'Corrija os campos destacados.';

  @override
  String get savingLabel => 'Salvando…';

  @override
  String get returnToRequest => 'Voltar à solicitação';

  @override
  String get returnToRequestBody => 'Você estava preenchendo uma solicitação de alimentos.';

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
  String get signOutBody => 'Você precisará entrar novamente para usar o Savvi.';

  @override
  String get securityHelper => 'Use esta opção para solicitar um link seguro de redefinição de senha da sua conta Savvi.';

  @override
  String get sendResetLink => 'Enviar link para redefinir a senha';

  @override
  String get resetLinkSent => 'Link de redefinição de senha enviado. Confira seu e-mail para ver as próximas etapas.';

  @override
  String get resetLinkError => 'Não foi possível enviar o link. Tente novamente.';

  @override
  String get resetEmailLabel => 'O link será enviado para';

  @override
  String get helpContactPlaceholder => 'Os dados de contato aparecerão aqui quando estiverem disponíveis.';

  @override
  String get resetPasswordTitle => 'Redefinir senha';

  @override
  String get resetPasswordSubtitle => 'Enviaremos um código de 6 dígitos para seu e-mail.';

  @override
  String get sendResetLinkBtn => 'Enviar código';

  @override
  String get checkYourInboxTitle => 'Confira sua caixa de entrada.';

  @override
  String resetLinkSentBody(String email) {
    return 'Enviamos um link de redefinição para ${email}. O link expira em 15 minutos.';
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
  String get newPasswordSubtitle => 'Pelo menos 8 caracteres, com letra maiúscula, número e caractere especial.';

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
  String get passwordMustMeetAllFour => 'A senha precisa atender aos quatro requisitos.';

  @override
  String get valPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get passwordUpdatedTitle => 'Senha atualizada.';

  @override
  String get passwordUpdatedBody => 'Sua senha do Savvi foi alterada. Entre com sua nova senha.';

  @override
  String get goToSignIn => 'Ir para entrar';

  @override
  String get checkInboxTitle => 'Digite o código de verificação';

  @override
  String checkInboxBody(String email) {
    return 'Enviamos um código de 6 dígitos para ${email}. Digite-o abaixo para continuar.';
  }

  @override
  String get resendLink => 'Reenviar código';

  @override
  String get otpVerifyBtn => 'Verificar código';

  @override
  String get otpIncomplete => 'Digite o código de 6 dígitos.';

  @override
  String get otpInvalid => 'Esse código é inválido ou expirou. Tente novamente.';

  @override
  String get otpSendFailed => 'Não foi possível enviar o código. Tente novamente.';

  @override
  String get otpResent => 'Um novo código foi enviado.';

  @override
  String get confirmPasswordMismatch => 'As senhas não coincidem.';

  @override
  String get edit => 'Editar';

  @override
  String get editHouseholdNote => 'Por enquanto, o tamanho da família é gerenciado pelo seu perfil.';
}
