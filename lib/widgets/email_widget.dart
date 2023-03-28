
import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

import '../pages/form.dart';

class EmailWidget extends StatelessWidget{
  
  final TextEditingController emailController;
   final Function(FormValid,bool) changeBool;
const EmailWidget ({super.key,required this.emailController,required this.changeBool});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(left:20,bottom: 20,right: 20),
      
      
      child: TextFormField(
        
        controller: emailController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration:  const InputDecoration(
          hintText: 'Email',
        
          
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        validator: (email){
            if(!EmailValidator.validate(email!)){
               WidgetsBinding.instance.addPostFrameCallback((_) {
               changeBool(FormValid.email,false);
       });
                return "Enter a valid email";
            }
            else{
             WidgetsBinding.instance.addPostFrameCallback((_) {
               changeBool(FormValid.email,true);
       });
              return null;
            }
        },
      ),
    );
  }
}