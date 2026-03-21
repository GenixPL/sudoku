import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onTap,
  });

  final void Function(int number) onTap;

  @override
  Widget build(BuildContext context) {
    const double height = 50;
    const double width = 35;

    return Row(
      children: [
        Expanded(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8,
            runAlignment: WrapAlignment.spaceBetween,
            children: [
              for (int i = 1; i <= 9; i++)
                GestureDetector(
                  onTap: () => onTap(i),
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      border: BoxBorder.all(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text(i.toString())),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
