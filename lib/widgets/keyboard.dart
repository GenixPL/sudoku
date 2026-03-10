import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onTap,
  });

  final void Function(int number) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 1; i <= 9; i++)
          GestureDetector(
            onTap: () => onTap(i),
            child: Container(
              height: 40,
              width: 30,
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
    );
  }
}
