import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> setupWindow() async {
  // Only run on desktop, not web
  if (kIsWeb) return;
  if (!Platform.isWindows && !Platform.isMacOS && !Platform.isLinux) return;

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 800),
    minimumSize: Size(900, 600),  
    center: true,
    title: 'Netflix Clone',
    backgroundColor: Color(0xFF141414),
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}