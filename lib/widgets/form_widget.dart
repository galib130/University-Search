import 'dart:math';

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
    
   return Container(
    //color: Color.fromARGB(255,255,240,141),
     child: Center(
      
       child: Column(
         children: [
           SizedBox(height: MediaQuery.of(context).size.height*0.05
           ,),
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
     
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.06,
                      child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        
                        onPressed: readyForSubmit?(){
                         FocusScopeNode currentFocus = FocusScope.of(context);
                        
                                     if (!currentFocus.hasPrimaryFocus) {
                                     currentFocus.unfocus();
                                    }
                          submission();
                      }:null, child: const Text("Submit")),
                    )
                    
                ],) ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                 alignment: Alignment.bottomLeft ,child: Text("Email:  $username",style:const TextStyle(fontSize: 20))),
                if(university!=null)
                if(university!.name!="not found")
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
   
                          Text("${university!.name.toString()}",style:TextStyle(fontSize: 28)),
                          Text("Country: ${university!.country.toString()}",style: const TextStyle(fontSize:20,),),
                          if(university!.stateProvince.toString()!="null")
                          Text("State Province: ${university!.stateProvince.toString()}",style: const TextStyle(fontSize:20,),)
                          else
                          const Text("State Province: Not found",style: const TextStyle(fontSize:20,),),
                          ListView.builder(
                            shrinkWrap: true,
                          
                            itemCount: university!.domains.length,
                            itemBuilder:(context, index) {
                              if(index==0) {
                                return Text("Domains: ${university!.domains[index].toString()}",style: const TextStyle(fontSize:20,));
                              } else {
                                return Text(university!.domains[index].toString(),style: const TextStyle(fontSize:20,));
                              }
                            },),
   
                        ListView.builder(
                            shrinkWrap: true,
                          
                            itemCount: university!.webPages.length,
                            itemBuilder:(context, index) {
                              if(index==0) {
                                return Text("Web Pages: ${university!.webPages[index].toString()}",style: const TextStyle(fontSize:20,));
                              } else {
                                return Text(university!.webPages[index].toString(),style: const TextStyle(fontSize:20,));
                              }
                            },),
   
   
                    ],
                  ))
                else if(university==null)
                const Text("Invalid University name given")
                else
                const Text("Cannot find University")
                
         ],
       ),
     ),
   );
  }
}