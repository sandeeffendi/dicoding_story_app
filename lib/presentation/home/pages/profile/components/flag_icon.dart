import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/core/utils/localization_utils.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:intermediate_first_submission/presentation/home/provider/profile_proivder/profile_provider.dart';
import 'package:provider/provider.dart';

class FlagIcon extends StatelessWidget {
  const FlagIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: context.watch<ProfileProvider>().locale,
        autofocus: false,
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.languagePreferencesTitle),
            const SizedBox(width: 12),
            const Icon(Icons.flag),
          ],
        ),
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = LocalizationUtils.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        }).toList(),
        onChanged: (locale) {
          if (locale == null) return;
          final provider = context.read<ProfileProvider>();
          provider.setLocale(locale);
        },
      ),
    );
  }
}
