import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morse_web_play/models/nav_model.dart';

class NavNotifier extends Notifier<AppSection> {
  // Appsection(enum) contains the pages
  @override
  build() {
    // Initially, show the converter
    return AppSection.converter;
  }

  void changeSection(AppSection section) {
    // Change the current section based on the index inputed
    state = section;
  }
}

final navProvider = NotifierProvider<NavNotifier, AppSection>(
  () => NavNotifier(),
);
