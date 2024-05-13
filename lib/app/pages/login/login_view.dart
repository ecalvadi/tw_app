import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean;
import 'package:tw_app/app/pages/login/login_controller.dart';
import 'package:tw_app/app/utils/resources.dart';
import 'package:tw_app/data/repositories/remote/data_remote_authentication_repository.dart';
import 'package:tw_app/data/repositories/remote/data_remote_position_repository.dart';

class LoginPage extends clean.View {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends clean.ViewState<LoginPage, LoginController> {
  _LoginPageState()
      : super(LoginController(
            DataRemoteAuthenticationRepository())); //Agregar controller
  @override
  Widget get view {
    return clean.ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) {
      const double space = 20.0;
      return Scaffold(
        key: globalKey,
        body: Container(
          color: Colors.blue[100],
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 120),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Image(
                      height: 100,
                      image: AssetImage(Resources.logo),
                    ),
                  ),
                  const SizedBox(height: 90),
                  Container(
                    height: MediaQuery.of(context).size.height - 40 - 150 - 180,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: controller.email,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.email),
                              labelText: 'Usuario',
                              hintText: 'Ingrese Usuario',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email vacío';
                              }
                              // if (!RegExp(
                              //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              //     .hasMatch(value)) {
                              //   return 'Email inválido';
                              // }
                            },
                          ),
                          const SizedBox(height: space),
                          TextFormField(
                            controller: controller.pass,
                            obscureText: controller.hidePassword,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                child: Icon(controller.hidePassword
                                    ? Icons.shield
                                    : Icons.remove_moderator),
                                onTap: () {
                                  controller.showPassword();
                                },
                              ),
                              labelText: 'Password',
                              hintText: 'Ingrese contraseña',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email vacío';
                              }
                            },
                          ),
                          const SizedBox(height: space),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.login();
                                  }
                                },
                                child: const Text('Login'),
                              )),
                          const SizedBox(height: space),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
