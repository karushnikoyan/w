import 'package:flutter/material.dart';

import '../../../core/utils/style.dart';

class FactsCard extends StatelessWidget {
  final String title;
  final String url;

  const FactsCard({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(title,style: AppTextStyle.titleLarge,),
        const SizedBox(height: 24,),
        SizedBox(
          width: size.width ,
          height: 350,
          child: Image.asset(url,fit: BoxFit.fill,),
        )
      ],
    );
  }
}
