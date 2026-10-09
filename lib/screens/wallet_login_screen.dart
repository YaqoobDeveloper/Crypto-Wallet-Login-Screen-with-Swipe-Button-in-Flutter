import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/wallet/wallet_components.dart';
import '../theme/wallet_colors.dart';
import '../utils/validators.dart';

class WalletLoginScreen extends StatefulWidget {
  const WalletLoginScreen({super.key});

  @override
  State<WalletLoginScreen> createState() => _WalletLoginScreenState();
}

class _WalletLoginScreenState extends State<WalletLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int _tab = 0;

  bool get _isSignUp => _tab == 1;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSignUp
              ? 'Account created for ${_emailController.text}'
              : 'Logged in as ${_emailController.text}',
        ),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: WalletColors.background,
        // Fills the screen when there's room, scrolls when there isn't.
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                      child: Column(
                        children: [
                          WalletHeader(title: 'Wallet', onHelp: () {}),
                          const SizedBox(height: 28),
                          Text(
                            _isSignUp ? 'Get Started' : 'Welcome Back',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 44,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                              color: WalletColors.creamText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _isSignUp
                                ? 'Create your wallet in seconds'
                                : 'Log in to manage your crypto wallet',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RoundActionButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 22,
                                  color: WalletColors.ink,
                                ),
                                onTap: () {},
                              ),
                              RoundActionButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.apple,
                                  size: 24,
                                  color: WalletColors.ink,
                                ),
                                onTap: () {},
                              ),
                              RoundActionButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  size: 22,
                                  color: WalletColors.ink,
                                ),
                                onTap: () {},
                              ),
                              RoundActionButton(
                                icon: const Icon(
                                  Icons.fingerprint,
                                  size: 28,
                                  color: WalletColors.ink,
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabbedSheet(
                      tabs: const ['Log In', 'Sign Up'],
                      selectedIndex: _tab,
                      onTabChanged: (i) => setState(() => _tab = i),
                      child: _buildForm(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isSignUp) ...[
            WalletField(
              controller: _nameController,
              label: 'Full Name',
              hint: 'Your name',
              trailingIcon: Icons.person_outline_rounded,
              textInputAction: TextInputAction.next,
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Please enter your name'
                  : null,
            ),
            const SizedBox(height: 20),
          ],
          WalletField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'you@email.com',
            trailingIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.email,
          ),
          const SizedBox(height: 20),
          WalletPasswordField(
            controller: _passwordController,
            onSubmitted: (_) => _submit(),
            validator: Validators.password,
          ),
          if (!_isSignUp)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: WalletColors.orange,
                ),
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          else
            const SizedBox(height: 16),
          const Spacer(),
          const SizedBox(height: 20),
          SwipeButton(
            key: ValueKey(_tab),
            label: _isSignUp ? 'Swipe to Sign Up' : 'Swipe to Log In',
            onSwiped: _submit,
          ),
        ],
      ),
    );
  }
}
