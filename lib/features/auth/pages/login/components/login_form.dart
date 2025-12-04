import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intermediate_first_submission/app/story_app_router.dart';
import 'package:intermediate_first_submission/core/constants/form_error_constant.dart';
import 'package:intermediate_first_submission/core/utils/keyboard_util.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:intermediate_first_submission/features/auth/provider/auth_provider.dart';
import 'package:intermediate_first_submission/features/auth/provider/auth_state.dart';
import 'package:provider/provider.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _errors = <String>[];

  bool _remember = false;
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      authProvider = context.read<AuthProvider>();
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _addError(String error) {
    if (!_errors.contains(error)) {
      setState(() => _errors.add(error));
    }
  }

  void _removeError(String error) {
    if (_errors.contains(error)) {
      setState(() => _errors.remove(error));
    }
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);

      authProvider.setSubmitting(true);

      context.read<AuthProvider>().logIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  void _showErrorDialog(String? message) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: Colors.red[600],
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Login Failed',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message ?? 'Check your username or password and try again.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.go(StoryAppRouter.register);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Try Again'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email Field with improved design
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _removeError(FormErrorConstants.kEmailNullError);
                }
                if (FormErrorConstants.emailValidatorRegExp.hasMatch(value)) {
                  _removeError(FormErrorConstants.kInvalidEmailError);
                }
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  _addError(FormErrorConstants.kEmailNullError);
                  return "";
                }
                if (!FormErrorConstants.emailValidatorRegExp.hasMatch(value!)) {
                  _addError(FormErrorConstants.kInvalidEmailError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                prefixIcon: const Icon(Icons.email_outlined),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[300]!, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[400]!, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Password Field with show/hide toggle
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: _obscurePassword,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleLogin(),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _removeError(FormErrorConstants.kPassNullError);
                }
                if (value.length >= 8) {
                  _removeError(FormErrorConstants.kShortPassError);
                }
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  _addError(FormErrorConstants.kPassNullError);
                  return "";
                }
                if (value!.length < 8) {
                  _addError(FormErrorConstants.kShortPassError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey[600],
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[300]!, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[400]!, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Remember Me & Forgot Password with better styling
            Row(
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                    value: _remember,
                    activeColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (value) =>
                        setState(() => _remember = value ?? false),
                  ),
                ),
                Text(
                  "Remember me",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
              ],
            ),

            // Form Errors with better design
            if (_errors.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  children: _errors
                      .map(
                        (error) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red[700],
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  error,
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Login Button with enhanced design
            _LoginButton(
              onPressed: _handleLogin,
              onError: _showErrorDialog,
              onSuccess: () async {
                // todo: navigate to home
                if (authProvider.isSubmitting == true) {
                  authProvider.setSubmitting(false);

                  context.go(StoryAppRouter.splash);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final ValueChanged<String?> onError;
  final VoidCallback onSuccess;

  const _LoginButton({
    required this.onPressed,
    required this.onError,
    required this.onSuccess,
  });

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  AuthStatus? _lastStatus;

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, AuthState>(
      selector: (_, auth) => auth.state,
      builder: (context, state, child) {
        final isLoading = state.status == AuthStatus.loading;

        // Handle state changes
        if (_lastStatus != state.status) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            if (state.status == AuthStatus.error) {
              widget.onError(state.message);
            } else if (state.status == AuthStatus.loginSuccess) {
              widget.onSuccess();
            }
          });

          _lastStatus = state.status;
        }

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isLoading ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withAlpha((0.6 * 255).round()),
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.continueTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
