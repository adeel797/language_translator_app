import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:language_translator/ui/common/app_colors.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = viewModel.isDarkMode;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.darkGradient : AppColors.lightGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App Logo
              Container(
                height: screenHeight * 0.15,
                width: screenHeight * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                ),
                child: Icon(
                  Icons.translate,
                  size: screenHeight * 0.08,
                  color:
                      isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // App Title
              Text(
                "Language Translator",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

              // Tagline
              Text(
                "Breaking barriers, one word at a time",
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: isDark ? AppColors.darkHint : AppColors.lightHint,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.05),

              // Loading Row
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Loading ...",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  SizedBox(
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                    child: CircularProgressIndicator(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      strokeWidth: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((_) => viewModel.runStartupLogic());
}
