import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatpmmobil/widgets/style.dart';
import 'package:tatpmmobil/widgets/custum_textfield.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crypto/crypto.dart';
import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final user = GetStorage();
  final fav = GetStorage('fav');
  final userController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyles.title,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Register Your Account', style: TextStyles.title.copyWith(fontSize: 24.0),),
              const SizedBox(height: 24.0),
              CustomTextField(
                controller: userController,
                hint: 'Username or Email',
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: passController,
                hint: 'Password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                controller: passConfirmController,
                hint: 'Confirm Password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 50.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                    )
                ),
                onPressed: (){
                  String text = "";
                  if(!user.hasData(userController.text) && passConfirmController.text == passController.text) {
                    user.write(userController.text, passController.text);
                    fav.write(userController.text, []);
                    text = "Sign Up Success";
                  } else if(passConfirmController.text != passController.text) {
                    text = "Password Not Identical";
                  } else {
                    text = "Username is Taken";
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return LoginScreen();
                  }));

                  SnackBar snackBar = SnackBar(content: Text(text));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Confirm',
                    style: TextStyles.title.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _hashPassword(String password) {
    List<int> bytes = utf8.encode(password);
    Digest sha256Result = sha256.convert(bytes);
    return sha256Result.toString();
  }

  bool validatePassword(String password) {
    // Minimum length of 8 characters
    if (password.length < 8) {
      return false;
    }
    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return false;
    }
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return false;
    }
    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return false;
    }
    // Check for at least one special character
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      return false;
    }
    // All checks passed, the password is strong
    return true;
  }
}
