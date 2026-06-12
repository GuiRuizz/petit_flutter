import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petit_flutter/pages/web_page.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  Future<void> _requestAgain(BuildContext context) async {
    final result = await [
      Permission.camera,
      Permission.photos,
      Permission.notification,
      Permission.microphone,
    ].request();

    final allGranted = result.values.every((status) => status.isGranted);

    if (allGranted && context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WebPage()),
      );
      return;
    }

    final permanentlyDenied = result.values.any(
      (status) => status.isPermanentlyDenied,
    );

    if (permanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.security, size: 100),

            const SizedBox(height: 24),

            const Text(
              'Permissões necessárias',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            const Text(
              'Precisamos de acesso à câmera, fotos, vídeos, notificações e microfone para que todos os recursos do aplicativo funcionem corretamente.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => _requestAgain(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                    255,
                    20,
                    20,
                    20,
                  ), // preto elegante
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Permitir acesso',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
