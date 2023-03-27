import 'package:flutter/material.dart';

import '../pages/form.dart';

class PasswordWidget extends StatelessWidget{

final TextEditingController passwordController;
final Function(FormValid,bool) changeBool;
PasswordWidget({super.key, required this.passwordController,required this.changeBool});
final RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
bool validatePassword(String pass){
  String _password=pass.trim();
  if(pass_valid.hasMatch(_password)){
    return true;
  }
  else{
    return false;
  }
}

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextFormField(controller: passwordController,obscureText: true,enableSuggestions: false,autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(hintText: 'Password',border: OutlineInputBorder(borderRadius:BorderRadius.circular(20))),
      validator: (value){
        
        if(value!.isEmpty){
              WidgetsBinding.instance.addPostFrameCallback((_) {
               changeBool(FormValid.password,false);
       });
          return "Please enter Password";
        }
        
        else{
          bool result=validatePassword(value);
          if(result){
                WidgetsBinding.instance.addPostFrameCallback((_) {
               changeBool(FormValid.password,true);
       });
            return null;
          }
          else{
                WidgetsBinding.instance.addPostFrameCallback((_) {
               changeBool(FormValid.password,false);
       });
            return "Needs to contain Capital letter,Small letter,Number and Special Character";
          }
          
        }
        
        
      },
      ),
    );
  }
}