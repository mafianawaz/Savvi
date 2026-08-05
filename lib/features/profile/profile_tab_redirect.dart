import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../../core/state/shell_nav.dart';
import '../../core/theme/tokens.dart';

/// Deep-link target for `/profile`. Profile lives as a single shell tab, so this
/// activates the Profile tab and redirects to the shell instead of building a
/// second, independent ProfileScreen instance.
// class ProfileTabRedirect extends ConsumerStatefulWidget {
//   const ProfileTabRedirect({super.key});
//
//   @override
//   ConsumerState<ProfileTabRedirect> createState() => _ProfileTabRedirectState();
// }
//
// class _ProfileTabRedirectState extends ConsumerState<ProfileTabRedirect> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(shellTabProvider.notifier).state = kTabProfile;
//       if (mounted) context.go(Routes.home);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => const Scaffold(
//         backgroundColor: SavColors.page,
//         body: Center(child: CircularProgressIndicator(color: SavColors.navy)),
//       );
// }
