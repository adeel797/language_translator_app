import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:language_translator/ui/common/app_colors.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    final isDark = viewModel.isDarkMode;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.darkGradient : AppColors.lightGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Settings"),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Auto Translate",
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Switch(
                    value: viewModel.isAutoTranslate,
                    onChanged: viewModel.toggleAutoTranslate,
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  Switch(
                    value: viewModel.isDarkMode,
                    onChanged: viewModel.toggleDarkMode,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) =>
      SettingsViewModel();
}
