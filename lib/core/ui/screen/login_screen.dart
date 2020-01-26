import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_test/core/bloc/login_bloc/bloc.dart';
import 'package:login_test/core/ui/styles/styles.dart';
import 'package:login_test/core/ui/widget/common_button.dart';
import 'package:login_test/core/ui/widget/custom_text_field.dart';
import 'package:ovprogresshud/progresshud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginState) {
          if (state.isSubmitting) {
            Progresshud.show();
            Progresshud.setDefaultMaskTypeGradient();
          } else if (state.isSuccess) {
            Future.delayed(Duration(seconds: 3));
            Progresshud.dismiss();
            Progresshud.showSuccessWithStatus('Thành công');
          } else if (state.isFailure) {
            Future.delayed(Duration(seconds: 3));
            Progresshud.dismiss();
            Progresshud.showErrorWithStatus('Lỗi, thử lại');
          }
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _logoSection(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    onTextChanged: (value) {},
                    isPassword: false,
                    icon: FontAwesomeIcons.envelopeOpen,
                    textEditingController: _emailController,
                  ),
                  CustomTextField(
                    hintText: 'Mật khẩu',
                    onTextChanged: (value) {},
                    isPassword: true,
                    icon: FontAwesomeIcons.lock,
                    textEditingController: _passwordController,
                  ),
                  CommonButton(
                    onPressed: isLoginButtonEnabled(state)
                        ? () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _loginBloc.add(LoginWithCredentials(
                                email: _emailController.text.toString(),
                                password: _passwordController.text.toString()));
                          }
                        : null,
                    text: Text(
                      'Đăng nhập',
                      style: TextStyle(
                          color: isLoginButtonEnabled(state)
                              ? KColors.white
                              : KColors.ColorPrimary,
                          fontFamily: Kfonts.TitleFont),
                    ),
                    icon: ImageIcon(
                      AssetImage('assets/images/login.png'),
                      color: isLoginButtonEnabled(state)
                          ? KColors.white
                          : KColors.ColorPrimary,
                    ),
                    radiusValue: 5,
                    width: MediaQuery.of(context).size.width * 0.7,
                    backgroundColor: KColors.ColorPrimary,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _logoSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/images/password.png',
        ),
      )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }
}
