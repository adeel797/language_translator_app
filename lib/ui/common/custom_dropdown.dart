import 'package:flutter/material.dart';
import 'package:language_translator/ui/common/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool isDarkMode;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontSize: 14,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkHint : AppColors.lightHint,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.005,
            ),
            filled: true,
            fillColor: isDark
                ? AppColors.darkBackground.withOpacity(0.7)
                : AppColors.lightBackground.withOpacity(0.9),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              dropdownColor: isDark
                  ? AppColors.darkBackground.withOpacity(0.95)
                  : AppColors.lightBackground,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: screenWidth * 0.05,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
              style: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color:
                              isDark ? AppColors.darkText : AppColors.lightText,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
