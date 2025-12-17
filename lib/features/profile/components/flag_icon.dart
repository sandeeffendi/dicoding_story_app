import 'package:flutter/material.dart';
import 'package:intermediate_first_submission/core/utils/localization_utils.dart';
import 'package:intermediate_first_submission/features/profile/provider/profile_provider.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FlagIcon extends StatelessWidget {
  const FlagIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<ProfileProvider>().locale;

    return DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: DropdownButton<Locale>(
          value: locale,
          alignment: Alignment.center,
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          items: AppLocalizations.supportedLocales.map((Locale locale) {
            final flag = LocalizationUtils.getFlag(locale.languageCode);

            return DropdownMenuItem<Locale>(
              value: locale,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(flag, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    locale.languageCode.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (locale) {
            if (locale == null) return;
            context.read<ProfileProvider>().setLocale(locale);
          },
        ),
      ),
    );
  }
}
