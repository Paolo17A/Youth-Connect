import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  final String letter;
  final String answer;
  final void Function() onTap;
  final bool isSelected;
  const AnswerButton(
      {required this.letter,
      required this.answer,
      required this.onTap,
      required this.isSelected,
      super.key});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.isSelected
            ? const Color.fromARGB(255, 21, 57, 119)
            : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.75,
          height: 60,
          child: ElevatedButton(
              onPressed: widget.onTap,
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 53, 113, 217)),
              child: Text(
                widget.answer,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
