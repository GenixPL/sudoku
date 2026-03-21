import 'package:flutter/material.dart';

class HighlightsKeyboard extends StatelessWidget {
  const HighlightsKeyboard({
    super.key,
    required this.onTap,
    required this.active,
  });

  final void Function(int number) onTap;
  final List<int> active;

  @override
  Widget build(BuildContext context) {
    const double height = 35;
    const double width = 35;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: active.contains(i) ? Colors.blueAccent : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        i.toString(),
                        style: TextStyle(
                          fontSize: height * 0.6,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
