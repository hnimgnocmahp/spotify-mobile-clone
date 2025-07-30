import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spotify/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify/common/widgets/button/basic_app_button.dart';
import 'package:flutter_spotify/core/configs/assets/app_images.dart';
import 'package:flutter_spotify/core/configs/assets/app_vectors.dart';
import 'package:flutter_spotify/domain/usecases/auth/signin.dart';
import 'package:flutter_spotify/presentation/auth/pages/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/input/custom_text_field.dart';
import '../../../data/models/auth/signing_user_reg.dart';
import '../../../service_locator.dart';
import '../../home/pages/home.dart';

class SignIn extends StatelessWidget{
  SignIn({super.key});
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          bottomNavigationBar: _redirectRegisterText(context),
          resizeToAvoidBottomInset: true,
          appBar: BasicAppBar(
            title: SvgPicture.asset(
              AppVectors.logo,
              height: 30,
              width: 30,
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsetsGeometry.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              children: [
                _signinText(),
                SizedBox(height: 20,),
                _supportText(),
                SizedBox(height: 30,),
                // _fullNameField(context),
                CustomTextField(controller: _email, hintText: 'Enter Username Or Email'),
                SizedBox(height: 10,),
                CustomTextField(controller: _password , hintText: 'Password', isPassword: true),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _recoveryPasswordText(),
                  ),
                ),
                SizedBox(height: 20,),
                BasicAppButton(
                    onPressed: () async {
                      var result = await sl<SignInUseCase>().call(
                          params: SigningUserReg(
                            email: _email.text.toString(),
                            password: _password.text.toString(),
                          )
                      );
                      result.fold(
                        (l){
                          var snackBar = SnackBar(
                            content: Text(
                              l,
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            padding: EdgeInsets.all(16),
                            elevation: 10,
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        (r){
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                                  (route) => false
                          );
                        }
                      );
                    },
                    title: 'Sign In'
                ),
                SizedBox(height: 20,),
                _line(),
                SizedBox(height: 40,),
                _loginIcon(),
              ],
            ),
          )
      ),
    );
  }

  Widget _signinText(){
    return Text(
      'Signin',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _supportText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'If You Need Any Support ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: (){},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Click Here',
            style: TextStyle(
              color: Color(0xff38B432),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _recoveryPasswordText(){
    return Text(
      'Recovery password',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _redirectRegisterText(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Not A Member ? ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )
          ),
          TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signup()));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
                'Register Now',
                style: TextStyle(
                  color: Color(0xff288CE9),
                )
            ),
          )
        ],
      ),
    );
  }

  Widget _line() {
    return Row(
      children: [
        Expanded(
          child: Image.asset(AppImages.line),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Or')
        ),
        Expanded(

          child: Image.asset(AppImages.line),
        ),
      ],
    );
  }

  Widget _loginIcon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(AppImages.googleIcon),
        SizedBox(width: 50,),
        Image.asset(AppImages.appleIcon),
      ]
    );
  }
}