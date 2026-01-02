import 'package:flutter/material.dart';

class BadgeStack extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;
  
  const BadgeStack({
    super.key,
    required this.child,
    required this.value,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? Theme.of(context).colorScheme.secondary
            ),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10
              ),
            ),
          )
        )
      ],
    );
  }
}