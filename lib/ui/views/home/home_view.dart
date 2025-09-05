import 'package:flutter/material.dart';
import 'package:language_translator/ui/common/custom_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'package:language_translator/ui/common/app_colors.dart';
import 'home_viewmodel.dart';
import 'package:flutter/services.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    final isDark = viewModel.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppColors.darkGradient : AppColors.lightGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar(viewModel, context),
        body: _mainBody(context, viewModel),
      ),
    );
  }

  AppBar _appBar(HomeViewModel viewModel, BuildContext context) {
    final isDark = viewModel.isDarkMode;
    return AppBar(
      title: Text(
        "Language Translator",
        style: TextStyle(
          color: isDark ? AppColors.darkText : AppColors.lightText,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: viewModel.openSettings,
          icon: Icon(Icons.settings,
              color: isDark ? AppColors.darkText : AppColors.lightText),
        )
      ],
    );
  }

  Widget _mainBody(BuildContext context, HomeViewModel viewModel) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = viewModel.isDarkMode;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.02),
              _languageSelection(context, viewModel),
              SizedBox(height: screenHeight * 0.03),
              _inputField(viewModel, isDark),
              SizedBox(height: screenHeight * 0.03),
              if (!viewModel.isAutoTranslate)
                _translateButton(context, viewModel, isDark),
              SizedBox(height: screenHeight * 0.04),
              if (viewModel.isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              if (!viewModel.isLoading && viewModel.translatedText.isNotEmpty)
                _outputText(context, viewModel, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageSelection(BuildContext context, HomeViewModel viewModel) {
    final isDark = viewModel.isDarkMode;
    return Row(
      children: [
        Expanded(
          child: CustomDropdown(
            label: 'From',
            value: viewModel.fromLang,
            items: viewModel.availableLanguages,
            onChanged: viewModel.setFromLanguage,
            isDarkMode: isDark,
          ),
        ),
        IconButton(
          onPressed: viewModel.swapLanguages,
          icon: const Icon(Icons.swap_horiz, size: 28, color: Colors.white),
        ),
        Expanded(
          child: CustomDropdown(
            label: 'To',
            value: viewModel.toLang,
            items: viewModel.availableLanguages,
            onChanged: viewModel.setToLanguage,
            isDarkMode: isDark,
          ),
        ),
      ],
    );
  }

  Widget _inputField(HomeViewModel viewModel, bool isDark) {
    return TextField(
      controller: viewModel.textController,
      maxLines: 5,
      style: TextStyle(
        color: isDark ? AppColors.darkText : AppColors.lightText,
      ),
      onChanged: (_) {
        if (viewModel.isAutoTranslate) {
          viewModel.translateText();
        }
        viewModel.notifyListeners();
      },
      decoration: InputDecoration(
        hintText: "Enter text to translate...",
        filled: true,
        fillColor: isDark
            ? AppColors.darkBackground.withOpacity(0.8)
            : AppColors.lightBackground,
        hintStyle:
            TextStyle(color: isDark ? AppColors.darkHint : AppColors.lightHint),
        suffixIcon: viewModel.textController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear,
                    color: isDark ? AppColors.darkHint : AppColors.lightHint),
                onPressed: () {
                  viewModel.textController.clear();
                  viewModel.clearTranslation();
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _translateButton(
      BuildContext context, HomeViewModel viewModel, bool isDark) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: viewModel.translateText,
      icon: Icon(Icons.translate,
          color: isDark ? AppColors.darkText : AppColors.lightText),
      label: Text(
        "Translate",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDark ? AppColors.darkText : AppColors.lightText,
        ),
      ),
    );
  }

  Widget _outputText(
      BuildContext context, HomeViewModel viewModel, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkBackground.withOpacity(0.8)
            : AppColors.lightBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.copy,
                  size: 20,
                  color: isDark ? AppColors.darkHint : AppColors.lightHint),
              onPressed: () {
                Clipboard.setData(
                    ClipboardData(text: viewModel.translatedText));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Copied to clipboard")),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              viewModel.translatedText,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
