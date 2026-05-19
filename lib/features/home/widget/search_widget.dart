import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/widget/app_card.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  AppCard(
      color: AppColor.surface,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      hasBorder: true,
      child: Row(
        children: [
          SizedBox(width: context.sWidth*0.03),
          Icon(CupertinoIcons.search, color: AppColor.muted, size: context.sHeight*0.025),
          SizedBox(width: context.sWidth*0.03),
          Text(
            "Search fresh groceries…",
            style: GoogleFonts.poppins(
              fontSize: context.text14,
              color: Colors.grey.shade400,
            ),
          ),
          const Spacer(),
          AppCard(
            color: AppColor.primary,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(10),
            child: const Icon(Icons.tune, color: Colors.white, size: 18),
          ),
          SizedBox(width: 6,),
        ],
      ),
    );
  }
}
