import 'package:app_phrases/domain/errors/errors.dart';
import 'package:app_phrases/presentation/pages/home/home_page.dart';
import 'package:app_phrases/presentation/pages/login/login_controller.dart';
import 'package:app_phrases/presentation/widgets/utils_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final LoginController _controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login_image.jpg'), fit: BoxFit.cover),
        ),
        child: SizedBox(
            width: 300,
            child: Form(
              key: _controller.globalKey,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        focusNode: _userFocus,
                        decoration: const InputDecoration(
                            labelText: 'Insira seu email'),
                        controller: _controller.ctlEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (text) {
                          _fieldFocusChange(context, _userFocus, _passFocus);
                        },
                      ),
                      Observer(
                        builder: (_) => TextFormField(
                            focusNode: _passFocus,
                            obscureText: !_controller.showPassword,
                            decoration: InputDecoration(
                              labelText: 'Insira a senha',
                              focusColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _controller.showPassword =
                                      !_controller.showPassword;
                                },
                                child: Icon(
                                  _controller.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            controller: _controller.ctlPassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _passFocus.unfocus();
                              _createAccountEmailPassword();
                            }),
                      ),
                      const Padding(padding: EdgeInsets.all(15)),
                      Observer(builder: (_) => _loginButton(context)),
                      Observer(
                          builder: (_) => TextButton(
                              onPressed: () {
                                _controller.loginMode = !_controller.loginMode;
                              },
                              child: Text(
                                _controller.loginMode ? 'Criar conta' : 'Login',
                                style: const TextStyle(fontSize: 12),
                              )))
                    ],
                  ),
                ),
              ),
            )),
      ),
    ));
  }

  Widget _loginButton(BuildContext context) {
    if (!_controller.logging) {
      return ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(150, 42)),
              backgroundColor: MaterialStateProperty.all(Colors.green),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)))),
          onPressed: () async {
            if (_controller.loginMode) {
              _loginEmailPassword();
            } else {
              _createAccountEmailPassword();
            }
          },
          child: Text(
            _controller.loginMode ? "Entrar" : "Criar conta",
            style: const TextStyle(color: Colors.white),
          ));
    } else {
      return const CircularProgressIndicator();
    }
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _createAccountEmailPassword() async {
    if (_controller.globalKey.currentState!.validate()) {
      try {
        await _controller.createAccountEmailPassword(
            _controller.ctlEmail.text, _controller.ctlPassword.text);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      } catch (error) {
        if (error is AlreadyExistsEmailError) {
          UtilsWidgets.showSnack(context, 'Já existe uma conta com esse email');
        } else if (error is InvalidEmailError) {
          UtilsWidgets.showSnack(context, 'O email inserido é inválido');
        } else if (error is WeakPasswordError) {
          UtilsWidgets.showSnack(context,
              'A senha inserida é muito simples, use uma senha mais complexa');
        }
      }
    }
  }

  void _loginEmailPassword() async {
    if (_controller.globalKey.currentState!.validate()) {
      try {
        await _controller.loginEmailPassword(
            _controller.ctlEmail.text, _controller.ctlPassword.text);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      } catch (error) {
        if (error is WrongPasswordError) {
          UtilsWidgets.showSnack(context, 'A senha informada está incorreta');
        } else if (error is UserDisabledError) {
          UtilsWidgets.showSnack(
              context, 'A conta desse usuário está desativada');
        } else if (error is UserNotFoundError) {
          UtilsWidgets.showSnack(context,
              'Não foi encontrada nenhuma conta com esse usuário, vamos criar uma?');
          _controller.loginMode = false;
        }
      }
    }
  }
}
