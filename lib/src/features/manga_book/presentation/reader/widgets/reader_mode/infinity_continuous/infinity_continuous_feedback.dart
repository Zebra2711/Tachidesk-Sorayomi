// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../../utils/extensions/custom_extensions.dart';
import 'infinity_continuous_config.dart';

/// UI feedback components for infinity continuous reader mode
class InfinityContinuousFeedback {
  const InfinityContinuousFeedback._();

  /// Shows feedback when user tries to scroll past the last chapter
  static void showEndOfMangaFeedback(
    BuildContext context,
    ObjectRef<DateTime?> lastFeedbackTime,
  ) {
    final now = DateTime.now();

    // Debounce to prevent spam
    if (lastFeedbackTime.value != null &&
        now.difference(lastFeedbackTime.value!) <
            InfinityContinuousConfig.feedbackCooldown) {
      return;
    }

    lastFeedbackTime.value = now;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.auto_stories_rounded,
              color: context.theme.colorScheme.onInverseSurface,
            ),
            const Gap(12),
            Expanded(
              child: Text(
                context.l10n.noMoreChaptersAhead,
                style: TextStyle(
                  color: context.theme.colorScheme.onInverseSurface,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: context.theme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Shows feedback when user tries to scroll past the first chapter
  static void showStartOfMangaFeedback(
    BuildContext context,
    ObjectRef<DateTime?> lastFeedbackTime,
  ) {
    final now = DateTime.now();

    // Debounce to prevent spam
    if (lastFeedbackTime.value != null &&
        now.difference(lastFeedbackTime.value!) <
            InfinityContinuousConfig.feedbackCooldown) {
      return;
    }

    lastFeedbackTime.value = now;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.first_page_rounded,
              color: context.theme.colorScheme.onInverseSurface,
            ),
            const Gap(12),
            Expanded(
              child: Text(
                context.l10n.noMoreChaptersBehind,
                style: TextStyle(
                  color: context.theme.colorScheme.onInverseSurface,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: context.theme.colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }


  /// Shows feedback when chapter loading fails
  static void showChapterLoadFailedFeedback(
    BuildContext context,
    String chapterName, {
    bool isNext = true,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: context.theme.colorScheme.onErrorContainer,
              size: 18,
            ),
            const Gap(12),
            Expanded(
              child: Text(
                isNext
                    ? context.l10n.failedToLoadNextChapter
                    : context.l10n.failedToLoadPreviousChapter,
                style: TextStyle(
                  color: context.theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: context.theme.colorScheme.errorContainer,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

