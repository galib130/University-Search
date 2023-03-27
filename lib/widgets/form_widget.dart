import 'package:fetch_api/pages/form.dart';
import 'package:fetch_api/widgets/email_widget.dart';
import 'package:fetch_api/widgets/password_widget.dart';
import 'package:fetch_api/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import '../models/university.dart';

class FormWidget extends StatelessWidget{
  final GlobalKey<FormState> formKey;
  final TextEditingController searchController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final List<Welcome?>Function(String query) getSearchData;
  final Function(FormValid,bool) changeBool;
  final bool readyForSubmit;
 
  final Welcome? university;
  final Function submission;
   FormWidget ({super.key, required this.getSearchData,required this.searchController,
   required this.emailController,required this.passwordController,required this.formKey,required this.readyForSubmit,required this.changeBool,
   required this.submission,required this.university});
   
  @override
  Widget build(BuildContext context) {
    
   return Column(
     children: [
       Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child:Column(children: [
                SearchBarWidget(getSearchData: getSearchData, searchController: searchController,changeBool:changeBool),
                EmailWidget(emailController: emailController,changeBool:changeBool),
                PasswordWidget(passwordController: passwordController,changeBool:changeBool),

                ElevatedButton(onPressed: readyForSubmit?(){
                    submission();
                }:null, child: const Text("Submit"))
                
            ],) ),
            if(university!.name!=null)
            Text(university!.name.toString())
            else if(university==null)
            const Text("Cannot find University")
     ],
   );
  }
}