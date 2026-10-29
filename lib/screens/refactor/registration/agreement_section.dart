import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../widgets/widgets.dart';

/// خانة الموافقة على التواصل.
class AgreementSection extends StatelessWidget {
  final bool agreed;
  final bool showError;
  final ValueChanged<bool> onChanged;

  const AgreementSection({
    super.key,
    required this.agreed,
    required this.showError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Checkbox(
            value: agreed,
            activeColor: AppColors.cyan,
            side: BorderSide(
                color: showError ? AppColors.red : AppColors.textDim),
            onChanged: (v) => onChanged(v ?? false),
          ),
          const Expanded(
            child: AppText.muted(
                'I agree to RoboTech contacting me regarding this application and activity updates.',
                10),
          ),
        ]),
        if (showError)
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: FieldHelper('You need to agree to continue', isError: true),
          ),
      ],
    );
  }
}
