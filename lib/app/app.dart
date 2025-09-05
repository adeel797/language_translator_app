import 'package:language_translator/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:language_translator/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:language_translator/ui/views/home/home_view.dart';
import 'package:language_translator/ui/views/home/home_viewmodel.dart';
import 'package:language_translator/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:language_translator/services/translator_service.dart';
import 'package:language_translator/ui/views/settings/settings_view.dart';
import 'package:language_translator/services/hive_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SettingsView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TranslatorService),
    LazySingleton(classType: HiveService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
