import 'package:flutter/material.dart';
import 'package:flutter_spotify/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify/common/widgets/input/custom_text_field.dart';
import 'package:flutter_spotify/core/configs/assets/app_vectors.dart';
import 'package:flutter_spotify/presentation/auth/pages/signin.dart';
import 'package:flutter_spotify/presentation/home/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../data/models/auth/create_user_req.dart';
import '../../../domain/usecases/auth/signup.dart';
import '../../../service_locator.dart';

class Signup extends StatelessWidget{
  Signup({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: _redirectSignInText(context),
        resizeToAvoidBottomInset: true,
        appBar: BasicAppBar(
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 30,
            width: 30,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              _registerText(),
              SizedBox(height: 20,),
              _supportText(),
              SizedBox(height: 20,),
              CustomTextField(controller: _fullNameController, hintText: 'Full Name',),
              SizedBox(height: 10,),
              CustomTextField(controller: _emailController, hintText: 'Email', keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10,),
              CustomTextField(controller:_passwordController, hintText: 'Password', isPassword: true),
              SizedBox(height: 10,),
              CustomTextField(controller: _confirmPasswordController, hintText: 'Confirm Password', isPassword: true),
              SizedBox(height: 20,),
              BasicAppButton(
                onPressed: () async{
                  var result = await sl<SignupUseCase>().call(
                    params: CreateUserReg(
                      fullName: _fullNameController.text.toString(),
                      email: _emailController.text.toString(),
                      password: _passwordController.text.toString(),
                      confirmPassword: _confirmPasswordController.text.toString(),
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
                title: 'Create Account'
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _registerText(){
    return Text(
      'Register',
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

  Widget _redirectSignInText(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do You Have An Account? ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )
          ),
          TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Sign In',
              style: TextStyle(
                color: Color(0xff288CE9),
              )
            ),
          )
        ],
      ),
    );
  }

}