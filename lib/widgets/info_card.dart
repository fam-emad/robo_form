import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'app_text.dart';
import 'bordered_box.dart';

class TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const TagChip({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return BorderedBox.tinted(
      tint: color,
      fillOpacity: 0.12,
      borderOpacity: 0.6,
      radius: 6,
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: AppText(label, 9, color: color),
    );
  }
}

/// صف واحد: عنوان على الشمال وقيمة (نص أو أي ويدجت) على اليمين.
class InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? trailing;
  final bool showDivider;

  const InfoRow({
    super.key,
    required this.label,
    this.value,
    this.trailing,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.border))
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText.dim(label, 10),
          trailing ?? AppText(value ?? '', 11, weight: FontWeight.w600),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String fullName;
  final List<String> committees;
  final String referenceId;

  const InfoCard({
    super.key,
    required this.fullName,
    required this.committees,
    required this.referenceId,
  });

  @override
  Widget build(BuildContext context) {
    return BorderedBox(
      color: AppColors.cardAlt,
      radius: 10,
      child: Column(
        children: [
          InfoRow(label: 'Applicant', value: fullName),
          InfoRow(
            label: 'Committees Selected',
            trailing: Row(children: [
              for (var i = 0; i < committees.length; i++)
                TagChip(label: committees[i], color: AppColors.accent(i)),
            ]),
          ),
          InfoRow(
            label: 'Reference ID',
            showDivider: false,
            trailing: AppText(referenceId, 11,
                weight: FontWeight.w600, color: AppColors.red),
          ),
        ],
      ),
    );
  }
}
