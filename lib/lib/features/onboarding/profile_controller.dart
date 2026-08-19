import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/providers.dart';
import '../../data/models/onboarding.dart';

/// State for the profile-creation submission.
// sealed class ProfileSubmitState {
//   const ProfileSubmitState();
// }
//
// class ProfileIdle extends ProfileSubmitState {
//   const ProfileIdle();
// }
//
// class ProfileSubmitting extends ProfileSubmitState {
//   const ProfileSubmitting();
// }
//
// class ProfileSubmitted extends ProfileSubmitState {
//   const ProfileSubmitted(this.approval);
//   final ApprovalState approval; // backend-returned initial approval state
// }
//
// class ProfileSubmitError extends ProfileSubmitState {
//   const ProfileSubmitError(this.messageKey);
//   final String messageKey;
// }
//
// class ProfileController extends StateNotifier<ProfileSubmitState> {
//   ProfileController(this._ref) : super(const ProfileIdle());
//   final Ref _ref;
//
//   /// Submit the completed profile for nonprofit approval. The client sends only
//   /// member-entered fields; the backend assigns the member ID and the initial
//   /// approval state. For a trusted onsite grant the backend may return an
//   /// instant `approved` state — the client just displays whatever comes back.
//   Future<ApprovalState> submit(Map<String, dynamic> body) async {
//     state = const ProfileSubmitting();
//     final api = _ref.read(savviApiProvider);
//     final res = await api.createProfile(body);
//     final next = res.when(
//       ok: (data) {
//         final approval = ApprovalState.fromApi(data['approval'] as String? ??
//             (data['status'] == 'approved' ? 'approved' : 'pending'));
//         return ProfileSubmitted(approval);
//       },
//       err: (f) => ProfileSubmitError(f.messageKey),
//     );
//     state = next;
//     return next is ProfileSubmitted ? next.approval : ApprovalState.pending;
//   }
//
//   void reset() => state = const ProfileIdle();
// }
//
// final profileControllerProvider =
//     StateNotifierProvider<ProfileController, ProfileSubmitState>(
//         (ref) => ProfileController(ref));
