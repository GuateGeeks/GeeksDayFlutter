import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeksday/services/navigationService.dart';
import 'package:rive/rive.dart' as rive;
import 'package:geeksday/bloc/auth_cubit.dart';
import 'package:geeksday/ui/inputs_form/email_form.dart';
import 'package:geeksday/ui/inputs_form/password_form.dart';
import 'package:geeksday/ui/locator.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const EmailSignIn();

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Controller for playback
  late rive.RiveAnimationController _blinkController;
  late rive.RiveAnimationController _noLookController;

  /// Is the animation currently playing?
  bool _isBlinkPlaying = false;
  bool _isNoLookPlaying = false;

  @override
  void initState() {
    super.initState();
    _blinkController = rive.OneShotAnimation(
      '2_blink',
      autoplay: false,
      onStop: () => setState(() => _isBlinkPlaying = false),
      onStart: () => setState(() => _isBlinkPlaying = true),
    );
    _noLookController = rive.OneShotAnimation(
      'not_looking',
      autoplay: false,
      onStop: () => setState(() => _isNoLookPlaying = false),
      onStart: () => setState(() => _isNoLookPlaying = true),
    );
    _emailController.addListener(() {
      final int textLength = _emailController.text.length;
      _inputLenght?.value = textLength as double;
    });
    _passwordController.addListener(
        () => _isNoLookPlaying ? null : _noLookController.isActive = true);
  }

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty)
        ? 'Este es un campo requerido'
        : null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Este es un campo requerido';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    double width = MediaQuery.of(context).size.width;
    double maxWidth = width > 400 ? 400 : width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 200,
          height: 37,
          child: rive.RiveAnimation.network(
            '/GeeksDayFlutter/assets/assets/rive/guategeeks_logo.riv',
            artboard: 'full_logo',
            animations: const ['single_blink_loop'],
            onInit: _onRiveInit,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 0.9,
            colors: [
              Color(0xFF0E89AF),
              Color(0xFF4B3BAB),
            ],
          ),
        ),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return cardLogin(maxWidth, state, authCubit);
          },
        ),
      ),
    );
  }

  Widget cardLogin(double maxWidth, AuthState state, authCubit) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 90),
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 35),
          child: Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 20.0),
                width: maxWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(255, 255, 255, 0.79)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Iniciar Sesión",
                        style: Theme.of(context).textTheme.overline,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      formLogin(state),
                      const SizedBox(height: 15),
                      forgotPassword(),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                child: SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      primary: const Color(0xFF4B3BAB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      locator<NavigationService>().navigateTo('/registrarse');
                    },
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        // fontFamily: 'Biryani',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -135,
                child: SizedBox(
                    width: maxWidth,
                    height: 160,
                    child: rive.RiveAnimation.network(
                      '/GeeksDayFlutter/assets/assets/rive/guategeeks_logo.riv',
                      artboard: 'eye_lid_v2',
                      animations: const ['idle'],
                      onInit: _onRiveInit,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  rive.SMINumber? _inputLenght;
  void _onRiveInit(rive.Artboard artboard) {
    final controller =
        rive.StateMachineController.fromArtboard(artboard, 'follow_input');
    artboard.addController(controller!);
    artboard.addController(_noLookController);
    _inputLenght =
        controller.findInput<double>('inputLenght') as rive.SMINumber;
    _inputLenght?.value = 0;
  }

  Widget formLogin(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is AuthSigningIn)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (state is AuthError)
            Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 24),
            ),
          //Input email
          const SizedBox(height: 8),
          EmailForm(emptyValidator, _emailController, submitForm),
          //Input Password
          const SizedBox(height: 8),
          PasswordForm(passwordValidator, _passwordController, submitForm),
          const SizedBox(height: 22),
          loginButton(),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Center(
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 180,
        height: 57,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20),
            primary: const Color(0xFF0E89AF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Center(
            child: Text(
              "Ingresar",
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () => submitForm(),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return InkWell(
      onTap: () {},
      child: const Text(
        "Recuperar contraseña",
        style: TextStyle(
          color: Color(0xFF4A4A4A),
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState?.validate() == true) {
      context.read<AuthCubit>().signInWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
    }
  }
}
