import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_changer/theme_option_pages/provider.dart';
import 'package:theme_changer/theme_option_pages/constant.dart';

class ThemeOptionsPage extends StatelessWidget {
  const ThemeOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Theme & Primary Color Switcher'),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              // Handle portrait orientation
              return Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                  // width: _containerWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Theme',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ThemeSwitcher(
                        side: MediaQuery.of(context).size.width / (appThemes.length + 1),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Primary Color',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      PrimaryColorSwitcher(
                        side: MediaQuery.of(context).size.width / (AppColors.primaryColors.length + 1),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Handle landscape orientation
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 17),
                    // width: _containerWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Theme'),
                        ),
                        ThemeSwitcher(
                          side: MediaQuery.of(context).size.height / (appThemes.length + 1),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Primary Color'),
                        ),
                        PrimaryColorSwitcher(
                          side: MediaQuery.of(context).size.height / (AppColors.primaryColors.length + 1),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key, required this.side});
  final double side;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (c, themeProvider, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < appThemes.length; i++)
                  GestureDetector(
                    onTap: appThemes[i].mode == themeProvider.selectedThemeMode ? null : () => themeProvider.setSelectedThemeMode(appThemes[i].mode),
                    child: AnimatedContainer(
                      width: side,
                      height: side,
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: appThemes[i].mode == themeProvider.selectedThemeMode ? Theme.of(context).primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(appThemes[i].icon),
                            Text(
                              appThemes[i].title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ));
  }
}

class PrimaryColorSwitcher extends StatelessWidget {
  final double side;

  const PrimaryColorSwitcher({super.key, required this.side});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (c, themeProvider, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < AppColors.primaryColors.length; i++)
            GestureDetector(
              onTap: AppColors.primaryColors[i] == themeProvider.selectedPrimaryColor
                  ? null
                  : () => themeProvider.setSelectedPrimaryColor(AppColors.primaryColors[i]),
              child: Container(
                height: side,
                width: side,
                decoration: BoxDecoration(
                  color: AppColors.primaryColors[i],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: AppColors.primaryColors[i] == themeProvider.selectedPrimaryColor ? 1 : 0,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
