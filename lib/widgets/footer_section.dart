import 'package:flutter/material.dart';
import 'package:ebram_martina_wedding/utils/localizations.dart';
import 'package:ebram_martina_wedding/widgets/insta.dart';
import '../theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  final AppLocalizations? loc;

  const FooterSection({super.key, this.loc, });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ebram & Martina .9 October 2026',
        style: AppText.button.copyWith(color: AppColors.ink,fontSize:12 )
        ),
        SizedBox(height: 20,),
        MomentoInstagramWidget(loc: loc),
      ],
    );
  }
}