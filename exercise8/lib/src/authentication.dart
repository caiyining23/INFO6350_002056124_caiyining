import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final VoidCallback signOut;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loggedIn
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StyledButton(
            onPressed: signOut,
            child: const Text('Logout'),
          ),
          const SizedBox(width: 8),
          StyledButton(
            onPressed: () => GoRouter.of(context).push('/profile'),
            child: const Text('Profile'),
          ),
        ],
      )
          : StyledButton(
        onPressed: () => GoRouter.of(context).push('/sign-in'),
        child: const Text('SIGN IN'),
      ),
    );
  }
}
