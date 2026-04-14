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

    return Scaffold(
      backgroundColor: SDWcolors.bgL,
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
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 160,
                    height: 160,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: width * 0.82,
                height: height * 0.48,
                decoration: BoxDecoration(
                  color: SDWcolors.bgL,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4), // changes position of shadow
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => Transform.scale(
                            scale: 0.72,
                            child: Checkbox(
                              value: authController.rememberMe.value,
                              onChanged: (val) =>
                                  authController.rememberMe.value = val!,
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
