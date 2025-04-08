import 'package:flutter/material.dart';
import 'package:exercise8/app_state.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}

class Header extends StatelessWidget {
  const Header(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.iconData, this.detail, {super.key});
  final IconData iconData;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 8),
        Text(detail),
      ],
    );
  }
}
