// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Savvi';

  @override
  String get relToday => 'Hôm nay';

  @override
  String get relYesterday => 'Hôm qua';

  @override
  String get relTomorrow => 'Ngày mai';

  @override
  String get actionContinue => 'Tiếp tục';

  @override
  String get actionCancel => 'Hủy';

  @override
  String get actionSave => 'Lưu';

  @override
  String get actionRetry => 'Thử lại';

  @override
  String get actionClose => 'Đóng';

  @override
  String get actionGoToProfile => 'Đi đến hồ sơ';

  @override
  String get stateLoading => 'Đang tải…';

  @override
  String get stateEmptyTitle => 'Chưa có nội dung';

  @override
  String get stateErrorTitle => 'Đã xảy ra lỗi';

  @override
  String get stateSuccessTitle => 'Hoàn tất';

  @override
  String get errNetwork => 'Không có kết nối. Kiểm tra Internet và thử lại.';

  @override
  String get errTimeout => 'Đã mất quá nhiều thời gian. Vui lòng thử lại.';

  @override
  String get errUnauthorized =>
      'Phiên của bạn đã kết thúc. Vui lòng đăng nhập lại.';

  @override
  String get errServer =>
      'Hệ thống đang gặp sự cố. Vui lòng thử lại sau ít phút.';

  @override
  String get errUnknown => 'Đã xảy ra lỗi. Vui lòng thử lại.';

  @override
  String get valRequired => 'Trường này là bắt buộc.';

  @override
  String get valEmail => 'Nhập địa chỉ email hợp lệ.';

  @override
  String get valPhoneRequired => 'Nhập số điện thoại để tiếp tục.';

  @override
  String get valPhoneInvalid => 'Nhập số điện thoại hợp lệ.';

  @override
  String get valZip => 'Vui lòng nhập mã ZIP hợp lệ.';

  @override
  String get phoneHelp =>
      'Cần có số điện thoại để đối tác tổ chức phi lợi nhuận phối hợp an toàn việc nhận hàng, giao hàng hoặc hỗ trợ yêu cầu thực phẩm của bạn. Savvi không sử dụng thông báo SMS trong phiên bản MVP.';

  @override
  String get unitLbs => 'lbs';

  @override
  String get unitKg => 'kg';

  @override
  String get unitMi => 'mi';

  @override
  String get unitMin => 'min';

  @override
  String get stSubmitted => 'Đã gửi';

  @override
  String get stNeedsUpdate => 'Cần cập nhật';

  @override
  String get stApproved => 'Đã phê duyệt';

  @override
  String get stScheduled => 'Đã lên lịch';

  @override
  String get stPreparing => 'Đang chuẩn bị';

  @override
  String get stReadyPickup => 'Sẵn sàng nhận';

  @override
  String get stPickupConfirmed => 'Đã xác nhận nhận hàng';

  @override
  String get stOutForDelivery => 'Đang giao hàng';

  @override
  String get stNearby => 'Ở gần';

  @override
  String get stDelivered => 'Đã giao';

  @override
  String get stDelayed => 'Bị trễ';

  @override
  String get stUnavailable => 'Không khả dụng';

  @override
  String get stCompleted => 'Đã hoàn tất';

  @override
  String get stMissed => 'Đã bỏ lỡ';

  @override
  String get stDeclined => 'Đã từ chối';

  @override
  String get stCancelled => 'Đã hủy';

  @override
  String get actionBack => 'Quay lại';

  @override
  String get actionSignIn => 'Đăng nhập';

  @override
  String get actionSignInShort => 'Đăng nhập';

  @override
  String get signInTagline =>
      'Cách Savvi giúp các gia đình yêu cầu hỗ trợ thực phẩm.';

  @override
  String get signInSubtitle =>
      'Thành viên đăng nhập bên dưới. Thành viên mới cần liên kết truy cập từ tổ chức phi lợi nhuận.';

  @override
  String get fieldEmail => 'Địa chỉ email';

  @override
  String get fieldPassword => 'Mật khẩu';

  @override
  String get hintEmail => 'you@example.com';

  @override
  String get hintPassword => 'Mật khẩu của bạn';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get newMemberPrompt => 'Thành viên mới?';

  @override
  String get createWithAccessLink => 'Tạo tài khoản bằng liên kết truy cập';

  @override
  String get accessTitle => 'Xác minh quyền truy cập';

  @override
  String get accessSubtitle =>
      'Dán liên kết do tổ chức phi lợi nhuận gửi hoặc quét mã QR tại địa điểm đăng ký Savvi.';

  @override
  String get accessInviteNote =>
      'Savvi chỉ dành cho người được mời. Nhân viên tổ chức phi lợi nhuận gửi liên kết truy cập và liên kết hết hạn sau 48 giờ.';

  @override
  String get accessPasteLabel => 'Dán liên kết hoặc mã truy cập';

  @override
  String get accessPasteHint => 'Dán liên kết hoặc mã của bạn';

  @override
  String get accessVerifyBtn => 'Xác minh liên kết truy cập';

  @override
  String get orDivider => 'hoặc';

  @override
  String get accessScanTitle => 'Quét mã QR của tổ chức phi lợi nhuận';

  @override
  String get accessScanSubtitle =>
      'Dành cho đăng ký thông thường hoặc sự kiện được tin cậy có phê duyệt tại chỗ';

  @override
  String get accessVerifiedTitle => 'Đã xác minh quyền truy cập.';

  @override
  String get accessVerifiedBody => 'Hoàn tất hồ sơ tài khoản để gửi phê duyệt.';

  @override
  String get accessOnsiteTitle => 'Đã phát hiện đăng ký tại chỗ đáng tin cậy.';

  @override
  String get accessOnsiteBody =>
      'Hoàn tất hồ sơ để được nhân viên tổ chức phi lợi nhuận tại chỗ phê duyệt ngay.';

  @override
  String get accessContinueBtn => 'Tiếp tục tạo tài khoản';

  @override
  String get accessContinueHint =>
      'Xác minh liên kết truy cập hoặc quét mã QR để tiếp tục.';

  @override
  String get accessErrEmpty => 'Vui lòng dán liên kết hoặc mã truy cập trước.';

  @override
  String get accessErrExpired =>
      'Liên kết truy cập này đã hết hạn. Hãy yêu cầu tổ chức phi lợi nhuận gửi liên kết mới.';

  @override
  String get accessErrUsed => 'Liên kết truy cập này đã được sử dụng.';

  @override
  String get accessErrInvalid =>
      'Không thể xác minh liên kết hoặc mã này. Hãy kiểm tra và thử lại.';

  @override
  String get qrTitle => 'Quét mã QR truy cập';

  @override
  String get qrSubtitle =>
      'Hướng camera vào mã QR của tổ chức phi lợi nhuận hoặc nhập mã bên dưới.';

  @override
  String get qrScanBtn => 'Mở camera để quét';

  @override
  String get qrEnterLabel => 'Nhập mã thủ công';

  @override
  String get qrCameraStaged =>
      'Tính năng quét camera sẽ được bật trong quá trình thiết lập thiết bị. Hiện tại, hãy nhập mã do tổ chức phi lợi nhuận cung cấp bên dưới.';

  @override
  String get signUpTitle => 'Tạo tài khoản';

  @override
  String get signUpSubtitle =>
      'Hoàn tất hồ sơ để yêu cầu tổ chức phi lợi nhuận phê duyệt.';

  @override
  String get signUpAccessRequiredTitle => 'Cần có liên kết truy cập';

  @override
  String get signUpAccessRequiredBody =>
      'Bạn cần liên kết truy cập hoặc mã QR của tổ chức phi lợi nhuận để tạo tài khoản Savvi.';

  @override
  String get signUpAccessVerifiedTitle => 'Đã xác minh quyền truy cập';

  @override
  String get signUpAccessVerifiedBody =>
      'Hoàn tất hồ sơ và gửi yêu cầu phê duyệt.';

  @override
  String get fieldFirstName => 'Tên';

  @override
  String get fieldLastName => 'Họ';

  @override
  String get fieldPhone => 'Số điện thoại';

  @override
  String get hintPhone => '(713) 555-0000';

  @override
  String get fieldStreet => 'Địa chỉ đường phố';

  @override
  String get hintStreet => '1809 Elgin St';

  @override
  String get fieldCity => 'Thành phố';

  @override
  String get hintCity => 'Houston';

  @override
  String get fieldState => 'Tiểu bang';

  @override
  String get fieldZip => 'Mã ZIP';

  @override
  String get hintZip => '77004';

  @override
  String get fieldHousehold => 'Quy mô hộ gia đình';

  @override
  String householdPerson(int count) {
    return '$count người';
  }

  @override
  String householdPeople(int count) {
    return '$count người';
  }

  @override
  String get householdPeopleMax => '10+ người';

  @override
  String get pwdReqLength => 'Ít nhất 8 ký tự';

  @override
  String get pwdReqUpper => 'Chữ in hoa';

  @override
  String get pwdReqNumber => 'Chữ số';

  @override
  String get pwdReqSpecial => 'Ký tự đặc biệt';

  @override
  String get consentText =>
      'Tôi đồng ý với Chính sách quyền riêng tư của Savvi và đồng ý chia sẻ dữ liệu hộ gia đình với đối tác phi lợi nhuận chỉ nhằm mục đích hỗ trợ thực phẩm.';

  @override
  String get consentRequired => 'Vui lòng đồng ý để tiếp tục.';

  @override
  String get signUpApprovalNote =>
      'Tài khoản của bạn phải được đối tác phi lợi nhuận phê duyệt trước khi bạn có thể gửi yêu cầu thực phẩm.';

  @override
  String get signUpSubmitBtn => 'Gửi để phê duyệt';

  @override
  String get haveAccountPrompt => 'Bạn đã có tài khoản?';

  @override
  String get approvalHeroTitle => 'Bạn sắp hoàn tất.';

  @override
  String get approvalHeroBody =>
      'Hồ sơ của bạn đang được tổ chức phi lợi nhuận xem xét. Bạn sẽ sớm nhận được phê duyệt.';

  @override
  String get stepSubmitted => 'Đã gửi';

  @override
  String get stepReview => 'Đang xem xét';

  @override
  String get stepApproved => 'Đã phê duyệt';

  @override
  String get approvalStatusLabel => 'Trạng thái';

  @override
  String get approvalPendingBadge => 'Đang chờ xem xét';

  @override
  String get approvalRow1Title => 'Đã gửi hồ sơ';

  @override
  String get approvalRow1Body =>
      'Thông tin tài khoản của bạn đã được nhận hôm nay';

  @override
  String get approvalRow2Title => 'Đang xem xét hồ sơ';

  @override
  String get approvalRow2Body => 'Đối tác đang xem xét hồ sơ của bạn';

  @override
  String get approvalRow3Title => 'Quyết định phê duyệt';

  @override
  String get approvalRow3Body =>
      'Chúng tôi sẽ thông báo qua thông báo đẩy và email';

  @override
  String get approvalMotivTitle => 'Những điều tốt đẹp đang đến.';

  @override
  String get approvalMotivBody =>
      'Hầu hết các yêu cầu phê duyệt được hoàn tất trong 1–2 ngày làm việc. Bạn sẽ nhận được thông báo ngay khi quyền truy cập sẵn sàng.';

  @override
  String get trackApprovalBtn => 'Theo dõi trạng thái phê duyệt';

  @override
  String get backToSignIn => 'Quay lại đăng nhập';

  @override
  String get approvedTitle => 'Bạn đã được phê duyệt!';

  @override
  String get approvedBody =>
      'Đối tác phi lợi nhuận đã phê duyệt tài khoản của bạn. Giờ đây bạn có thể yêu cầu hỗ trợ thực phẩm.';

  @override
  String get approvedCta => 'Về trang chủ';

  @override
  String get declinedTitle => 'Chưa được phê duyệt';

  @override
  String get declinedBody =>
      'Đối tác phi lợi nhuận của bạn chưa thể phê duyệt tài khoản này. Vui lòng liên hệ với họ để biết các bước tiếp theo.';

  @override
  String get needsReviewTitle => 'Cần xem xét bổ sung';

  @override
  String get needsReviewBody =>
      'Đối tác phi lợi nhuận cần thêm một chút thông tin trước khi phê duyệt. Họ sẽ liên hệ với bạn qua thông báo đẩy và email.';

  @override
  String get pwdNotMet => 'Mật khẩu chưa đáp ứng tất cả yêu cầu.';

  @override
  String get requestIdLabel => 'Mã yêu cầu';

  @override
  String get catProduce => 'Rau củ quả';

  @override
  String get catDairy => 'Sản phẩm từ sữa';

  @override
  String get catMeatProtein => 'Thịt / Đạm';

  @override
  String get catPreparedMeals => 'Bữa ăn chế biến sẵn';

  @override
  String get catBakeryBread => 'Bánh nướng / Bánh mì';

  @override
  String get catPantry => 'Thực phẩm khô';

  @override
  String get catFrozen => 'Thực phẩm đông lạnh';

  @override
  String get catSnacksBeverages => 'Đồ ăn nhẹ và đồ uống';

  @override
  String get catBabyFood => 'Thức ăn trẻ em';

  @override
  String get catInfantFormula => 'Sữa công thức cho trẻ sơ sinh';

  @override
  String get catControlledNote =>
      'Mặt hàng có kiểm soát — có thể cần xem xét thêm';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navAlerts => 'Thông báo';

  @override
  String get navEvents => 'Sự kiện';

  @override
  String get navRequest => 'Yêu cầu';

  @override
  String get navActivity => 'Hoạt động';

  @override
  String get navProfile => 'Hồ sơ';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get greetMorning => 'Chào buổi sáng';

  @override
  String get greetAfternoon => 'Chào buổi chiều';

  @override
  String get greetEvening => 'Chào buổi tối';

  @override
  String get homeCtaTitle => 'Yêu cầu hỗ trợ thực phẩm';

  @override
  String get homeCtaBody =>
      'Không phải xếp hàng. Nhận tại điểm hoặc giao tận nơi.';

  @override
  String get homeCtaBtn => 'Yêu cầu →';

  @override
  String get homeNoActive => 'Không có yêu cầu đang hoạt động';

  @override
  String get homeNoActiveBody =>
      'Khi bạn yêu cầu hỗ trợ thực phẩm, bạn có thể theo dõi tại đây.';

  @override
  String etaAway(String eta) {
    return 'cách $eta';
  }

  @override
  String milesAway(String miles) {
    return 'cách $miles dặm';
  }

  @override
  String get alertsTitle => 'Sự kiện';

  @override
  String get alertsSubtitle =>
      'Sự kiện thực phẩm từ tổ chức phi lợi nhuận gần bạn.';

  @override
  String get alertTypeHot => 'Thông báo bữa ăn nóng';

  @override
  String get alertTypeDist => 'Sự kiện phân phối thực phẩm';

  @override
  String alertSpotsLeft(int count) {
    return 'còn $count';
  }

  @override
  String get alertRsvpPrompt => 'Chọn số người bạn muốn đăng ký.';

  @override
  String get alertRsvpConfirm => 'Tôi sẽ đến';

  @override
  String alertRsvpConfirmed(int count) {
    return 'Đã xác nhận đăng ký cho $count';
  }

  @override
  String get alertRsvpChange => 'Thay đổi';

  @override
  String get alertRsvpCancel => 'Hủy đăng ký';

  @override
  String get alertsEmpty => 'Hiện không có thông báo';

  @override
  String get alertsEmptyBody =>
      'Chúng tôi sẽ thông báo khi có thực phẩm ở gần bạn.';

  @override
  String get tryAgain => 'Thử lại';

  @override
  String get notificationsTitle => 'Thông báo';

  @override
  String get savviMember => 'Thành viên Savvi';

  @override
  String get homeSub =>
      'Hỗ trợ thực phẩm của bạn, được cung cấp với sự tôn trọng.';

  @override
  String householdOf(String count) {
    return 'Hộ gia đình gồm $count người';
  }

  @override
  String get tileAlertsTitle => 'Sự kiện';

  @override
  String get tileAlertsSub => 'Sự kiện thực phẩm gần bạn';

  @override
  String get tileReqTitle => 'Yêu cầu của tôi';

  @override
  String get tileReqSub => 'Trạng thái và chi tiết nhận hàng';

  @override
  String get activeRequest => 'Yêu cầu đang hoạt động';

  @override
  String alertRsvpMax(int count) {
    return 'Tối đa $count · theo quy mô hộ gia đình của bạn';
  }

  @override
  String get alertRsvpSeeYou => 'Hẹn gặp bạn ở đó. Xin cảm ơn!';

  @override
  String get alertRsvpCancelled => 'Bạn đã hủy đăng ký tham dự.';

  @override
  String get alertRsvpSelectFirst =>
      'Vui lòng chọn ít nhất 1 người trước khi xác nhận.';

  @override
  String get reqTitle => 'Yêu cầu hỗ trợ';

  @override
  String reqStep(int n, int t) {
    return 'Bước $n / $t';
  }

  @override
  String get s1Title => 'Điều gì sẽ giúp ích nhất?';

  @override
  String get s1Sub => 'Chọn một hoặc nhiều danh mục.';

  @override
  String get s2Title => 'Nhận tại chỗ hay giao hàng?';

  @override
  String get s2Sub => 'Chọn cách bạn muốn nhận hỗ trợ.';

  @override
  String get s3Title => 'Hộ gia đình và liên hệ';

  @override
  String get s3Sub =>
      'Thông tin này lấy từ hồ sơ của bạn. Hãy cập nhật tại đó nếu có thay đổi.';

  @override
  String get s4Title => 'Xem lại yêu cầu';

  @override
  String get s4Sub => 'Kiểm tra mọi thông tin trước khi gửi.';

  @override
  String get s5Title => 'Xem lại yêu cầu';

  @override
  String get s5Sub => 'Kiểm tra mọi thông tin trước khi gửi.';

  @override
  String get stepNext => 'Tiếp theo';

  @override
  String get stepBack => 'Quay lại';

  @override
  String get methodPickup => 'Nhận tại chỗ';

  @override
  String get methodDelivery => 'Giao hàng';

  @override
  String get pickupDesc =>
      'Dùng mã nhận hàng tại địa điểm của tổ chức phi lợi nhuận.';

  @override
  String get deliveryDesc =>
      'Giao đến địa chỉ của bạn. Theo dõi trực tiếp trong ứng dụng.';

  @override
  String get controlledItem => 'Mặt hàng có kiểm soát';

  @override
  String get formulaNote =>
      'Việc cung cấp sữa công thức cho trẻ sơ sinh tùy thuộc vào sự phê duyệt của đối tác phi lợi nhuận, bao bì còn niêm phong, hạn sử dụng và điều kiện của chương trình.';

  @override
  String get formulaAck => 'Tôi hiểu';

  @override
  String get notesLabel => 'Ghi chú cho tổ chức phi lợi nhuận';

  @override
  String get notesHint =>
      'Có thông tin nào hữu ích mà tổ chức phi lợi nhuận cần biết không?';

  @override
  String get fromProfile => 'Từ hồ sơ của bạn';

  @override
  String get editInProfile => 'Chỉnh sửa trong Cài đặt';

  @override
  String get editInSettings => 'Chỉnh sửa trong Cài đặt';

  @override
  String get rvDietNote =>
      'Sở thích ăn uống và chất gây dị ứng lấy từ hồ sơ của bạn. Để cập nhật, hãy vào Cài đặt.';

  @override
  String get householdSizeNote =>
      'Để cập nhật quy mô hộ gia đình, hãy vào Cài đặt. Mặc định lấy từ hồ sơ của bạn. Bạn chỉ có thể thay đổi cho yêu cầu này.';

  @override
  String get dietTitle => 'Sở thích ăn uống';

  @override
  String get allergensTitle => 'Chất gây dị ứng';

  @override
  String get dSenior => 'Thực phẩm phù hợp cho người cao tuổi';

  @override
  String get dLowSodium => 'Ít natri';

  @override
  String get dDiabetic => 'Phù hợp cho người tiểu đường';

  @override
  String get dVegetarian => 'Ăn chay';

  @override
  String get dVegan => 'Thuần chay';

  @override
  String get dHalal => 'Phù hợp với halal';

  @override
  String get dNoPork => 'Không có thịt heo';

  @override
  String get dGlutenFree => 'Không chứa gluten';

  @override
  String get gPeanuts => 'Đậu phộng';

  @override
  String get gTreeNuts => 'Các loại hạt cây';

  @override
  String get gMilk => 'Sữa / sản phẩm từ sữa';

  @override
  String get gEggs => 'Trứng';

  @override
  String get gSoy => 'Đậu nành';

  @override
  String get gWheat => 'Lúa mì / gluten';

  @override
  String get gFish => 'Cá';

  @override
  String get gShellfish => 'Động vật có vỏ';

  @override
  String get gSesame => 'Mè';

  @override
  String get rvCats => 'Danh mục';

  @override
  String get rvMethod => 'Phương thức';

  @override
  String get rvHousehold => 'Hộ gia đình';

  @override
  String get rvContact => 'Liên hệ';

  @override
  String get rvAddress => 'Địa chỉ';

  @override
  String get rvDiet => 'Chế độ ăn';

  @override
  String get rvAlg => 'Chất gây dị ứng';

  @override
  String get rvNotes => 'Ghi chú';

  @override
  String get rvNone => 'Không có';

  @override
  String get submitRequest => 'Gửi yêu cầu';

  @override
  String get reqOkTitle => 'Đã gửi yêu cầu.';

  @override
  String reqOkBody(String np) {
    return '$np sẽ xem xét và xác nhận yêu cầu của bạn. Bạn sẽ nhận được thông báo về quyết định.';
  }

  @override
  String get viewRequest => 'Xem yêu cầu';

  @override
  String get backHome => 'Về trang chủ';

  @override
  String get errNoCat => 'Chọn ít nhất một danh mục thực phẩm.';

  @override
  String get errNoMethod => 'Chọn nhận tại điểm hoặc giao hàng.';

  @override
  String get deliveryUnavail =>
      'Hiện không có dịch vụ giao hàng cho yêu cầu này. Bạn vẫn có thể nhận hàng trực tiếp.';

  @override
  String get deliveryChecking => 'Đang kiểm tra khả năng giao hàng…';

  @override
  String get deliveryAvailError =>
      'Không thể kiểm tra khả năng giao hàng. Vui lòng thử lại.';

  @override
  String get actTitle => 'Yêu cầu của tôi';

  @override
  String get actSub => 'Mã nhận hàng, trạng thái giao hàng và lịch sử.';

  @override
  String get tabActive => 'Đang hoạt động';

  @override
  String get tabHistory => 'Lịch sử';

  @override
  String get tabAll => 'Tất cả';

  @override
  String get actEmptyTitle => 'Không có yêu cầu ở đây';

  @override
  String get actEmptyBody =>
      'Các yêu cầu bạn gửi sẽ xuất hiện trong danh sách này.';

  @override
  String get statusLabel => 'Trạng thái';

  @override
  String get weightLabel => 'Cân nặng';

  @override
  String get pickupCodeLabel => 'Mã nhận hàng';

  @override
  String get viewDetails => 'Xem chi tiết';

  @override
  String get trackDelivery => 'Theo dõi giao hàng';

  @override
  String get viewPickup => 'Xem chi tiết nhận hàng';

  @override
  String get editRequest => 'Chỉnh sửa yêu cầu';

  @override
  String get cancelRequest => 'Hủy yêu cầu';

  @override
  String get editLocked => 'Bạn không thể chỉnh sửa yêu cầu này nữa.';

  @override
  String get cancelConfirmTitle => 'Hủy yêu cầu này?';

  @override
  String get cancelConfirmBody =>
      'Bạn không thể hoàn tác thao tác này. Đối tác phi lợi nhuận sẽ được thông báo.';

  @override
  String get keepRequest => 'Giữ yêu cầu';

  @override
  String get requestCancelled => 'Đã hủy yêu cầu.';

  @override
  String get notFoundTitle => 'Không tìm thấy yêu cầu';

  @override
  String get trackTitle => 'Trạng thái giao hàng';

  @override
  String get trackSub =>
      'Cập nhật trực tiếp khi đơn giao hàng của bạn đang hoạt động.';

  @override
  String get trackWay => 'Đơn hàng đang trên đường đến';

  @override
  String get trackNear => 'Đơn hàng sắp đến';

  @override
  String get trackEtaLine => 'Thời gian dự kiến đến: 20–30 phút';

  @override
  String get trackEtaNear => 'Thời gian dự kiến đến: dưới 5 phút';

  @override
  String get trackEst => 'Ước tính';

  @override
  String get trackDist => 'Khoảng cách';

  @override
  String get trackPrivacy =>
      'Để bảo vệ quyền riêng tư, thông tin tài xế và lộ trình chính xác sẽ không được hiển thị. Bạn sẽ nhận thông báo khi đơn hàng đến nơi.';

  @override
  String get trackDelayedTitle => 'Giao hàng bị trễ';

  @override
  String get trackDelayedBody =>
      'Đối tác phi lợi nhuận đang xác định thời gian đến mới. Bạn sẽ được thông báo ngay khi có cập nhật.';

  @override
  String get trackUnavailTitle => 'Không thể giao hàng';

  @override
  String get trackUnavailBody =>
      'Không thể hoàn tất giao hàng cho yêu cầu này. Có thể bạn vẫn nhận hàng trực tiếp được — hãy liên hệ đối tác phi lợi nhuận.';

  @override
  String get trackDoneTitle => 'Đã giao hàng';

  @override
  String get trackDoneBody =>
      'Đơn hàng đã được giao. Cảm ơn bạn đã sử dụng Savvi.';

  @override
  String get switchPickup => 'Hỏi về việc nhận tại điểm';

  @override
  String get pkTitle => 'Chi tiết nhận hàng';

  @override
  String get pkSub => 'Mã, khung giờ và địa điểm của bạn.';

  @override
  String get pkWindow => 'Khung giờ nhận hàng';

  @override
  String get pkLocation => 'Địa điểm nhận hàng';

  @override
  String get pkShowQr => 'Hiển thị mã QR nhận hàng';

  @override
  String get pkQrLabel => 'Mã QR nhận hàng';

  @override
  String get pkCodeSub =>
      'Xuất trình mã này tại địa điểm của tổ chức phi lợi nhuận';

  @override
  String get pkWarn =>
      'Mã chỉ hợp lệ cho yêu cầu này. Không chia sẻ mã với người khác.';

  @override
  String get pkReadyTitle => 'Đơn hàng đã sẵn sàng nhận';

  @override
  String get pkReadyBody => 'Mang theo mã trong khung giờ nhận hàng bên dưới.';

  @override
  String get pkConfirmedTitle => 'Đã xác nhận nhận hàng';

  @override
  String get pkConfirmedBody =>
      'Nhân viên đã quét mã của bạn. Yêu cầu đã hoàn tất.';

  @override
  String get pkCompletedTitle => 'Đã hoàn tất nhận hàng';

  @override
  String get pkCompletedBody => 'Cảm ơn bạn đã sử dụng Savvi.';

  @override
  String get pkMissedTitle => 'Đã hết khung giờ nhận hàng';

  @override
  String get pkMissedBody =>
      'Khung giờ nhận hàng đã qua. Hãy liên hệ đối tác phi lợi nhuận để đặt lại lịch.';

  @override
  String get pkReschedule => 'Yêu cầu thời gian mới';

  @override
  String get pkReschedSent =>
      'Đã gửi yêu cầu đổi lịch đến đối tác phi lợi nhuận.';

  @override
  String get directions => 'Chỉ đường';

  @override
  String get scanAtCounter => 'Quét tại quầy';

  @override
  String get nonprofitLabel => 'Tổ chức phi lợi nhuận';

  @override
  String get naLabel => 'Chưa cung cấp';

  @override
  String get protoNote => 'Mô phỏng bản mẫu — chưa kết nối với hệ thống thực.';

  @override
  String get notifTitle => 'Thông báo';

  @override
  String get notifSub => 'Cập nhật yêu cầu và cảnh báo tiếp cận thực phẩm.';

  @override
  String get notifEmptyTitle => 'Bạn đã xem hết thông báo';

  @override
  String get notifEmptyBody => 'Hiện bạn không có thông báo nào.';

  @override
  String get markAllRead => 'Đánh dấu tất cả đã đọc';

  @override
  String get clearAllNotifs => 'Xóa tất cả';

  @override
  String get markedReadOk => 'Đã đánh dấu tất cả thông báo là đã đọc.';

  @override
  String get clearedOk => 'Đã xóa thông báo.';

  @override
  String get clearConfirmTitle => 'Xóa tất cả thông báo?';

  @override
  String get clearConfirmBody =>
      'Thao tác này xóa mọi thông báo khỏi danh sách. Bạn không thể hoàn tác.';

  @override
  String get cancelAction => 'Hủy';

  @override
  String get prefsTitle => 'Tùy chọn thông báo';

  @override
  String get prefsSub => 'Chọn cách bạn nhận thông tin từ Savvi.';

  @override
  String get prefsChNote =>
      'Savvi chỉ sử dụng thông báo trong ứng dụng, thông báo đẩy và email.';

  @override
  String get prefsSaved => 'Đã lưu tùy chọn thông báo';

  @override
  String get chInApp => 'Trong ứng dụng';

  @override
  String get chInAppDesc => 'Luôn bật. Hiển thị trong trung tâm thông báo.';

  @override
  String get chPush => 'Thông báo đẩy';

  @override
  String get chPushDesc =>
      'Cảnh báo trên điện thoại khi yêu cầu của bạn thay đổi.';

  @override
  String get chEmail => 'Thư điện tử';

  @override
  String get chEmailDesc =>
      'Bản sao các cập nhật quan trọng được gửi đến email của bạn.';

  @override
  String get profileTitle => 'Hồ sơ';

  @override
  String get personalInformation => 'Thông tin cá nhân';

  @override
  String get contactDetails => 'Thông tin liên hệ';

  @override
  String get saveContact => 'Lưu thông tin liên hệ';

  @override
  String get contactSaved => 'Đã cập nhật hồ sơ';

  @override
  String get usedInRequests => 'Được sử dụng trong yêu cầu thực phẩm';

  @override
  String get activeLabel => 'Đang hoạt động';

  @override
  String get zipNote =>
      'Mã ZIP hỗ trợ việc tiếp cận thực phẩm và báo cáo khu vực phục vụ.';

  @override
  String get phoneNote =>
      'Số điện thoại giúp đối tác phi lợi nhuận điều phối việc nhận hàng, giao hàng hoặc hỗ trợ. Phiên bản MVP không sử dụng thông báo SMS.';

  @override
  String get settingsHelp => 'Cài đặt và trợ giúp';

  @override
  String get openSettings => 'Mở cài đặt';

  @override
  String get householdSize => 'Quy mô hộ gia đình';

  @override
  String get signedOut => 'Bạn đã đăng xuất.';

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get signOutConfirm => 'Đăng xuất khỏi Savvi?';

  @override
  String get profileDietSub =>
      'Chỉ gửi kèm yêu cầu thực phẩm để đối tác phi lợi nhuận chuẩn bị phần thực phẩm.';

  @override
  String get profileAlgSub =>
      'Thông tin này giúp nhân viên đóng gói thực phẩm an toàn.';

  @override
  String get errFix => 'Vui lòng sửa các trường được đánh dấu.';

  @override
  String get savingLabel => 'Đang lưu…';

  @override
  String get returnToRequest => 'Quay lại yêu cầu';

  @override
  String get returnToRequestBody =>
      'Bạn đang hoàn tất một yêu cầu hỗ trợ thực phẩm.';

  @override
  String get householdConfirm => 'Vui lòng xác nhận quy mô hộ gia đình.';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get settingsSub => 'Quản lý tài khoản và nhận trợ giúp.';

  @override
  String get sPersonal => 'Hồ sơ';

  @override
  String get sPersonalDesc => 'Tên, thông tin liên hệ, địa chỉ và hộ gia đình';

  @override
  String get sLang => 'Ngôn ngữ';

  @override
  String get sNotif => 'Thông báo';

  @override
  String get sNotifDesc => 'Kênh và tùy chọn thông báo';

  @override
  String get sSecurity => 'Bảo mật và mật khẩu';

  @override
  String get sSecurityDesc => 'Cập nhật mật khẩu';

  @override
  String get sHelp => 'Trợ giúp và hỗ trợ';

  @override
  String get sHelpDesc => 'Liên hệ đối tác phi lợi nhuận';

  @override
  String get langHelp => 'Chọn ngôn ngữ hiển thị của ứng dụng Savvi.';

  @override
  String get langSaved => 'Đã cập nhật ngôn ngữ';

  @override
  String get langEnglish => 'Tiếng Anh';

  @override
  String get langSpanish => 'Tiếng Tây Ban Nha';

  @override
  String get closeAction => 'Đóng';

  @override
  String get signOutBody => 'Bạn cần đăng nhập lại để sử dụng Savvi.';

  @override
  String get securityHelper =>
      'Sử dụng tùy chọn này để yêu cầu liên kết đặt lại mật khẩu an toàn cho tài khoản Savvi.';

  @override
  String get sendResetLink => 'Gửi liên kết đặt lại mật khẩu';

  @override
  String get resetLinkSent =>
      'Đã gửi liên kết đặt lại mật khẩu. Kiểm tra email để biết bước tiếp theo.';

  @override
  String get resetLinkError =>
      'Không thể gửi liên kết đặt lại. Vui lòng thử lại.';

  @override
  String get resetEmailLabel => 'Liên kết đặt lại sẽ được gửi đến';

  @override
  String get helpContactPlaceholder =>
      'Thông tin liên hệ sẽ xuất hiện tại đây khi có sẵn.';

  @override
  String get resetPasswordTitle => 'Đặt lại mật khẩu';

  @override
  String get resetPasswordSubtitle =>
      'Chúng tôi sẽ gửi mã gồm 6 chữ số đến email của bạn.';

  @override
  String get sendResetLinkBtn => 'Gửi mã OTP';

  @override
  String get checkYourInboxTitle => 'Kiểm tra hộp thư đến.';

  @override
  String resetLinkSentBody(String email) {
    return 'Chúng tôi đã gửi liên kết đặt lại mật khẩu đến $email. Liên kết hết hạn sau 15 phút.';
  }

  @override
  String get iHaveTheLink => 'Tôi có liên kết →';

  @override
  String get resendLinkBtn => 'Gửi lại liên kết';

  @override
  String resendInSeconds(int seconds) {
    return 'Gửi lại sau $seconds giây';
  }

  @override
  String get newPasswordTitle => 'Mật khẩu mới';

  @override
  String get newPasswordSubtitle =>
      'Ít nhất 8 ký tự, bao gồm chữ hoa, số và ký tự đặc biệt.';

  @override
  String get fieldNewPassword => 'Mật khẩu mới';

  @override
  String get hintCreatePassword => 'Tạo mật khẩu';

  @override
  String get fieldConfirmPassword => 'Xác nhận mật khẩu';

  @override
  String get hintReenterPassword => 'Nhập lại mật khẩu mới';

  @override
  String get updatePasswordBtn => 'Cập nhật mật khẩu';

  @override
  String get passwordMustMeetAllFour => 'Mật khẩu phải đáp ứng cả bốn yêu cầu.';

  @override
  String get valPasswordMismatch => 'Mật khẩu không khớp.';

  @override
  String get passwordUpdatedTitle => 'Đã cập nhật mật khẩu.';

  @override
  String get passwordUpdatedBody =>
      'Mật khẩu Savvi của bạn đã được thay đổi. Hãy đăng nhập bằng mật khẩu mới.';

  @override
  String get goToSignIn => 'Đi đến đăng nhập';

  @override
  String get checkInboxTitle => 'Nhập mã xác minh';

  @override
  String checkInboxBody(String email) {
    return 'Chúng tôi đã gửi mã gồm 6 chữ số đến $email. Nhập mã bên dưới để tiếp tục.';
  }

  @override
  String get resendLink => 'Gửi lại mã';

  @override
  String get otpVerifyBtn => 'Xác minh mã';

  @override
  String get otpIncomplete => 'Nhập mã gồm 6 chữ số.';

  @override
  String get otpInvalid => 'Mã không hợp lệ hoặc đã hết hạn. Vui lòng thử lại.';

  @override
  String get otpSendFailed => 'Không thể gửi mã. Vui lòng thử lại.';

  @override
  String get otpResent => 'Đã gửi mã mới.';

  @override
  String get confirmPasswordMismatch => 'Mật khẩu không khớp.';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get editHouseholdNote =>
      'Hiện tại, quy mô hộ gia đình được quản lý trong hồ sơ của bạn.';
}
