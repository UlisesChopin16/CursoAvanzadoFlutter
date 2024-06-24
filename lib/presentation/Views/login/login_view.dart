import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel(loginUseCase: null);

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void bind() {
    loginViewModel.start();
    userNameController.addListener(() {
      loginViewModel.setUserName(userNameController.text);
    });
    passwordController.addListener(() {
      loginViewModel.setPassword(passwordController.text);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    bind();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginViewModel.dispose();
    userNameController.dispose();
    passwordController.dispose();
    userNameController.removeListener(() {});
    passwordController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage(
                          ImageAssets.splashLogo,
                        ),
                      ),
                      const Gap(AppSize.s28),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p28,
                          right: AppPadding.p28,
                        ),
                        child: StreamBuilder<bool>(
                          stream: loginViewModel.outputIsUserNameValid,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: userNameController,
                              decoration: InputDecoration(
                                hintText: StringsManager.username,
                                labelText: StringsManager.username,
                                errorText:
                                    (snapshot.data ?? true) ? null : StringsManager.usernameError,
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(AppSize.s28),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p28,
                          right: AppPadding.p28,
                        ),
                        child: StreamBuilder<bool>(
                          stream: loginViewModel.outputIsPasswordValid,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: StringsManager.password,
                                labelText: StringsManager.password,
                                errorText:
                                    (snapshot.data ?? true) ? null : StringsManager.passwordError,
                              ),
                            );
                          },
                        ),
                      ),
                      const Gap(AppSize.s28),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p28,
                          right: AppPadding.p28,
                        ),
                        child: StreamBuilder<bool>(
                          stream: loginViewModel.outputIsAllInputsValid,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      loginViewModel.login();
                                    }
                                  : null,
                              child: const Text(StringsManager.login),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
