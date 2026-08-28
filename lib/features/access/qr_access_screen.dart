import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/routing/app_router.dart';
import '../../core/theme/tokens.dart';
import '../../data/models/onboarding.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/patterns/feedback.dart';
import '../../shared/widgets/auth_scaffold.dart';
import '../../shared/widgets/sav_button.dart';
import '../../shared/widgets/sav_inputs.dart';
import 'access_controller.dart';

class QrAccessScreen extends StatefulWidget {
  const QrAccessScreen({super.key});

  @override
  State<QrAccessScreen> createState() => _QrAccessScreenState();
}

class _QrAccessScreenState extends State<QrAccessScreen> {
  late final AccessController controller;
  late final MobileScannerController scannerController;
  bool _handledScan = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AccessController>();
    scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      detectionTimeoutMs: 800,
    );
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handledScan || controller.isLoading.value) return;

    String? value;
    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue?.trim();
      if (raw != null && raw.isNotEmpty) {
        value = raw;
        break;
      }
    }
    if (value == null) return;

    _handledScan = true;
    await scannerController.stop();

    final grant = await controller.verifyQr(context, value);
    if (!mounted) return;

    if (grant?.verified == true) {
      Get.offNamed(Routes.signUp);
    } else {
      _handledScan = false;
      await scannerController.start();
    }
  }

  Future<void> _manualVerify() async {
    final grant = await controller.verifyQr(
      context,
      controller.qrCodeController.text,
    );
    if (!mounted) return;
    if (grant?.verified == true) Get.offNamed(Routes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Obx(() {
      final verifying = controller.isLoading.value;

      return AuthScaffold(
        title: l.qrTitle,
        subtitle: l.qrSubtitle,
        children: [
          _ScannerCard(
            controller: scannerController,
            onDetect: _onDetect,
          ),
          const SizedBox(height: SavSpace.x16),
          SavButton(
            label: l.qrScanBtn,
            onPressed: verifying
                ? null
                : () async {
                    _handledScan = false;
                    await scannerController.start();
                  },
          ),
          const SizedBox(height: SavSpace.x10),
          SavButton(
            label: l.cancelAction,
            variant: SavButtonVariant.ghost,
            onPressed: verifying
                ? null
                : () async {
              _handledScan = false;
              await scannerController.start();
            },
          ),
        ],
      );
    });
  }
}

class _ScannerCard extends StatelessWidget {
  const _ScannerCard({required this.controller, required this.onDetect});

  final MobileScannerController controller;
  final void Function(BarcodeCapture) onDetect;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: SavRadius.card,
        child: Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              controller: controller,
              onDetect: onDetect,
            ),
            const _ScannerOverlay(),
          ],
        ),
      ),
    );
  }
}

class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Container(color: Colors.black.withValues(alpha: .18)),
          Center(
            child: SizedBox(
              width: 238,
              height: 238,
              child: CustomPaint(painter: _ScannerFramePainter()),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .62),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Position the QR code inside the frame',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: SavFonts.sans,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScannerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const length = 34.0;
    const r = 2.0;
    final x = size.width;
    final y = size.height;

    final path = Path()
      ..moveTo(r, length)
      ..lineTo(r, r)
      ..lineTo(length, r)
      ..moveTo(x - length, r)
      ..lineTo(x - r, r)
      ..lineTo(x - r, length)
      ..moveTo(r, y - length)
      ..lineTo(r, y - r)
      ..lineTo(length, y - r)
      ..moveTo(x - length, y - r)
      ..lineTo(x - r, y - r)
      ..lineTo(x - r, y - length);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
