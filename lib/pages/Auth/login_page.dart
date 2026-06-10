import 'package:flutter/material.dart';
import 'package:sadewa_fe/constants/sdw_colors.dart';
import 'package:sadewa_fe/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:sadewa_fe/pages/Auth/widgets/login_field_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    // Future.microtask(() => authController.devAutoLogin());
    // Future.microtask(() => authController.devAutoLogin());

    return Scaffold(
      backgroundColor: SDWcolors.bgD,
      body: Stack(
        children: [
          Container(
            height: height * 0.6,
            decoration: const BoxDecoration(
              color: SDWcolors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: keyboardHeight > 0 ? width * 0.22 : width * 0.44,
                    height: keyboardHeight > 0 ? height * 0.12 : height * 0.24,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: width * 0.82,
                height: height * 0.44,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/form-auth-bg.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: SDWcolors.essentialDR.withAlpha(50),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: SDWcolors.primary,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          LoginFieldForm(
                            inputlabel: 'Email/Username',
                            controller: authController.emailUsername,
                            obscureText: false,
                            inputType: TextInputType.emailAddress,
                            showTitle: false,
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          SizedBox(height: 20),
                          LoginFieldForm(
                            inputlabel: 'Password',
                            controller: authController.password,
                            obscureText: true,
                            inputType: TextInputType.visiblePassword,
                            showTitle: false,
                            prefixIcon: Icon(Icons.lock_outlined),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/forgotPassword');
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: SDWcolors.primary,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Transform.scale(
                                scale: 0.72,
                                child: Checkbox(
                                  value: authController.rememberMe.value,
                                  onChanged: (val) {
                                    if (val != null) {
                                      authController.rememberMe.value = val;
                                    }
                                  },
                                  activeColor: SDWcolors.primary,
                                ),
                              ),
                            ),

                            Text(
                              'Ingat Saya',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: SDWcolors.primary),
                            ),
                            SizedBox(width: 30),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => Container(
                        width: width * 0.4,
                        height: 54,
                        decoration: BoxDecoration(
                          color: SDWcolors.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SDWcolors.primary,
                          ),
                          onPressed:
                              (authController.isLoading.isFalse &&
                                  authController.isFormValid.isTrue)
                              ? authController.loginAttempt
                              : null,
                          child: authController.isLoading.value
                              ? CircularProgressIndicator(
                                  color: SDWcolors.white,
                                )
                              : Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(color: SDWcolors.textL),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
