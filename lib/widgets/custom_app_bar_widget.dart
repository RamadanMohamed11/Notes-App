import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget(
      {super.key,
      required this.appBarText,
      required this.icon,
      required this.onPressed});
  final String appBarText;
  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          appBarText,
          style: const TextStyle(fontSize: 35),
        ),
        const Spacer(),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.1)),
            child: IconButton(onPressed: onPressed, icon: icon))
      ],
    );
  }
}
