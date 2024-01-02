import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keep_it_fresh/lib.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginFocused = false;
  bool isPasswordFocued = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF46DE99),
      //   elevation: 0,
      //   toolbarHeight: 0,
      // ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          left: false,
          right: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF46DE99),
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.images.imgFreshGo.path,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(
                        50,
                      ),
                      bottomRight: Radius.circular(
                        50,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24.w),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF355B3E),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'FreshGo ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'give you the best transportation in the world!',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.w,
                      ),
                      const CommonText(
                        'Welcome Back, Please login to your account',
                        textColor: Color(0xFF58745E),
                      ),
                      SizedBox(
                        height: 24.w,
                      ),
                      const CommonText(
                        'Email',
                        textColor: Color(0xFF2F3D4C),
                        fontStyle: FontStyle.semibold,
                      ),
                      AppConstants.kSpacingItem8,
                      CommonTextFormField(
                        boxDecoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(
                              0xFF355B3E,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      AppConstants.kSpacingItem24,
                      const CommonText(
                        'Password',
                        textColor: Color(0xFF2F3D4C),
                        fontStyle: FontStyle.semibold,
                      ),
                      AppConstants.kSpacingItem8,
                      CommonTextFormField(
                        boxDecoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(
                              0xFF355B3E,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                      AppConstants.kSpacingItem24,
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFF029664,
                                  ),
                                  padding: const EdgeInsets.all(16)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const HomePage()));
                              },
                              child: const CommonText(
                                'Login',
                                textColor: Colors.white,
                                fontStyle: FontStyle.semibold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 24.w,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(
                                      0xFF029664,
                                    ),
                                  ),
                                ),
                                padding: REdgeInsets.all(
                                  16,
                                ),
                              ),
                              onPressed: () {},
                              child: const CommonText(
                                'Sign Up',
                              ),
                            ),
                          )
                        ],
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
