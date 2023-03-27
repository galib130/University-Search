import 'package:fetch_api/pages/form.dart';
import 'package:fetch_api/widgets/email_widget.dart';
import 'package:fetch_api/widgets/password_widget.dart';
import 'package:fetch_api/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';
import '../models/university.dart';

class FormWidget extends StatelessWidget{
  final GlobalKey<FormState> formKey;
  final TextEditingController searchController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final List<Welcome?>Function(String query) getSearchData;
  final Function(FormValid,bool) changeBool;
  final bool readyForSubmit;
  final String username;
  final Welcome? university;
  final Function submission;
   const FormWidget ({super.key, required this.getSearchData,required this.searchController,
   required this.emailController,required this.passwordController,required this.formKey,required this.readyForSubmit,required this.changeBool,
   required this.submission,required this.university,required this.username});
   
  @override
  Widget build(BuildContext context) {
    
   return Center(
     child: Column(
       children: [
        const SizedBox(height: 30,),
        Container(
           alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(20),
          child: const Text("UniSearch",style: TextStyle(fontSize: 28),)),
         Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child:Column(children: [
                  Container(
                     alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text("Enter a university name to get the details",style: TextStyle(fontSize: 18),)),
                  SearchBarWidget(getSearchData: getSearchData, searchController: searchController,changeBool:changeBool),
                  Container(
                     alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text("Enter an Email",style: TextStyle(fontSize: 18),)),
                  
                  EmailWidget(emailController: emailController,changeBool:changeBool),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text("Enter a password",style: TextStyle(fontSize: 18),)),
                  
                  PasswordWidget(passwordController: passwordController,changeBool:changeBool),
   
                  ElevatedButton(onPressed: readyForSubmit?(){
                      submission();
                  }:null, child: const Text("Submit"))
                  
              ],) ),
              Text("Email:  $username"),
              if(university!=null)
              if(university!.name!="not found")
              Text(university!.name.toString())
              else if(university==null)
              const Text("Invalid University name given")
              else
              const Text("Cannot find University")
              
       ],
     ),
   );
  }
}