import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/constants/values_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view_model.dart';
import 'package:curso_avanzado_flutter/presentation/common/state_render_impl.dart';
import 'package:curso_avanzado_flutter/presentation/components/text_button_component.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = instance<LoginViewModel>();

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

    loginViewModel.isUserLoggedInController.stream.listen((isLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        }
      });
    });
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  void dispose() {
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
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: loginViewModel.outputFlowState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                ViewLogin(
                  formKey: formKey,
                  loginViewModel: loginViewModel,
                  userNameController: userNameController,
                  passwordController: passwordController,
                ),
                loginViewModel.retry,                
              ) ??
              ViewLogin(
                formKey: formKey,
                loginViewModel: loginViewModel,
                userNameController: userNameController,
                passwordController: passwordController,
              );
        },
      ),
    );
  }
}

class ViewLogin extends StatelessWidget {
  const ViewLogin({
    super.key,
    required this.formKey,
    required this.loginViewModel,
    required this.userNameController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final LoginViewModel loginViewModel;
  final TextEditingController userNameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          return SizedBox(
                            width: double.infinity,
                            height: AppSize.s40,
                            child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      loginViewModel.login();
                                    }
                                  : null,
                              child: Text(
                                StringsManager.login,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(AppSize.s8),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p28,
                        right: AppPadding.p28,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FORGOT PASSWORD
                          TextButtonComponent(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                            },
                            text: StringsManager.forgetPassword,
                          ),
                          const Gap(AppSize.s8),
                          // REGISTER
                          Flexible(
                            child: TextButtonComponent(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, Routes.registerRoute);
                              },
                              text: StringsManager.registerText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
