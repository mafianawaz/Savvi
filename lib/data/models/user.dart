import 'dart:convert';

class UserAddress {
  const UserAddress({
    this.street,
    this.city,
    this.zip,
    this.type,
    this.coordinates = const [],
  });

  final String? street;
  final String? city;
  final String? zip;
  final String? type;
  final List<double> coordinates;

  factory UserAddress.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const UserAddress();
    final rawCoordinates = json['coordinates'];
    return UserAddress(
      street: json['street']?.toString(),
      city: json['city']?.toString(),
      zip: json['zip']?.toString(),
      type: json['type']?.toString(),
      coordinates: rawCoordinates is List
          ? rawCoordinates
              .map((e) => double.tryParse(e.toString()))
              .whereType<double>()
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'zip': zip,
        'type': type,
        'coordinates': coordinates,
      };
}

class UserModel {
  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
    this.householdSize,
    this.dietary = const [],
    this.allergens = const [],
    this.privacyConsent = false,
    this.approvalStatus,
    this.invitedBy,
    this.inviteId,
    this.locationId,
    this.memberCode,
    this.resetPassOtp,
    this.role,
    this.termsAccepted = false,
    this.isEmailVerified = false,
    this.emailVerifyOtp,
    this.isSocialLogin = false,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String name;
  final String email;
  final String? phoneNumber;
  final UserAddress? address;
  final int? householdSize;
  final List<String> dietary;
  final List<String> allergens;
  final bool privacyConsent;
  final String? approvalStatus;
  final String? invitedBy;
  final String? inviteId;
  final String? locationId;
  final String? memberCode;
  final Map<String, dynamic>? resetPassOtp;
  final String? role;
  final bool termsAccepted;
  final bool isEmailVerified;
  final Map<String, dynamic>? emailVerifyOtp;
  final bool isSocialLogin;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      name: json['name']?.toString() ??
          '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      email: json['email']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString(),
      address: UserAddress.fromJson(
        json['address'] is Map
            ? Map<String, dynamic>.from(json['address'] as Map)
            : null,
      ),
      householdSize: _int(json['householdSize'] ?? json['household']),
      dietary: _strings(json['dietary'] ?? json['diet']),
      allergens: _strings(json['allergens']),
      privacyConsent: _bool(json['privacyConsent']),
      approvalStatus: json['approvalStatus']?.toString(),
      invitedBy: json['invitedBy']?.toString(),
      inviteId: json['inviteId']?.toString(),
      locationId: json['locationId']?.toString(),
      memberCode: json['memberCode']?.toString(),
      resetPassOtp: _map(json['resetPassOtp']),
      role: json['role']?.toString(),
      termsAccepted: _bool(json['termsAccepted']),
      isEmailVerified: _bool(json['isEmailVerified']),
      emailVerifyOtp: _map(json['emailVerifyOtp']),
      isSocialLogin: _bool(json['isSocialLogin']),
      status: json['status']?.toString(),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address?.toJson(),
        'householdSize': householdSize,
        'dietary': dietary,
        'allergens': allergens,
        'privacyConsent': privacyConsent,
        'approvalStatus': approvalStatus,
        'invitedBy': invitedBy,
        'inviteId': inviteId,
        'locationId': locationId,
        'memberCode': memberCode,
        'resetPassOtp': resetPassOtp,
        'role': role,
        'termsAccepted': termsAccepted,
        'isEmailVerified': isEmailVerified,
        'emailVerifyOtp': emailVerifyOtp,
        'isSocialLogin': isSocialLogin,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  String encode() => jsonEncode(toJson());

  factory UserModel.decode(String value) =>
      UserModel.fromJson(Map<String, dynamic>.from(jsonDecode(value) as Map));

  /// Compatibility map for existing Savvi screens while they migrate to the
  /// typed [UserModel]. New code should prefer [AuthController.user].
  Map<String, dynamic> toProfileMap() => {
        ...toJson(),
        'id': id,
        'memberId': memberCode ?? id,
        'phone': phoneNumber,
        'household': householdSize?.toString() ?? '',
        'diet': dietary,
        'nonprofit': '',
      };

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? name,
    String? phoneNumber,
    UserAddress? address,
    int? householdSize,
    List<String>? dietary,
    List<String>? allergens,
    String? approvalStatus,
    bool? termsAccepted,
    bool? isEmailVerified,
    String? status,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      email: email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      householdSize: householdSize ?? this.householdSize,
      dietary: dietary ?? this.dietary,
      allergens: allergens ?? this.allergens,
      privacyConsent: privacyConsent,
      approvalStatus: approvalStatus ?? this.approvalStatus,
      invitedBy: invitedBy,
      inviteId: inviteId,
      locationId: locationId,
      memberCode: memberCode,
      resetPassOtp: resetPassOtp,
      role: role,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      emailVerifyOtp: emailVerifyOtp,
      isSocialLogin: isSocialLogin,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static int? _int(dynamic value) => int.tryParse(value?.toString() ?? '');

  static bool _bool(dynamic value) => value == true || value?.toString() == 'true';

  static List<String> _strings(dynamic value) => value is List
      ? value.map((e) => e.toString()).where((e) => e.isNotEmpty).toList()
      : const [];

  static Map<String, dynamic>? _map(dynamic value) => value is Map
      ? Map<String, dynamic>.from(value)
      : null;
}
