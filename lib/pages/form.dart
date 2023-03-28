
import 'package:fetch_api/Services/remote_services.dart';
import 'package:fetch_api/models/university.dart';
import 'package:fetch_api/widgets/form_widget.dart';
import 'package:flutter/material.dart';

enum FormValid{
  search,
  email,
  password
}


class FormPage extends StatefulWidget {
  const FormPage({super.key});
  

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
final TextEditingController _searchController= TextEditingController();
final TextEditingController _emailController= TextEditingController();
final TextEditingController _passwordController=TextEditingController();
String username="";
University? university;
bool searchValid=false;
bool emailValid=false;
bool readyForSubmit=false;
bool passwordValid=false;
final _formKey=GlobalKey<FormState>();

  List<University>?welcome;
  var isLoaded=false;
@override
  void initState(){
    super.initState();
    getData();

  }

  getData()async{
    welcome=await RemoteService().getWelcome();
    if(welcome!=null){
      setState(() {
        isLoaded=true;

      });

    }

  }
  
  changeBool(FormValid formValid,bool flag){
      setState(() {
      if(formValid==FormValid.search){
        
          searchValid=flag;
        
      }
      else if(formValid==FormValid.email){
       
          emailValid=flag;
     
      }
      else if(formValid==FormValid.password){
    
          passwordValid=flag;
        
      }

    if(passwordValid==true&&emailValid==true&&searchValid==true){
      readyForSubmit=true;
    }
    else{
      readyForSubmit=false;
    }
     
      });
      
  }
 
  
  List<University>getSearchData(String query){
      return welcome!.where((element) {
       final nameLower=element.name.toLowerCase();
      final queryLower=query.toLowerCase();

      return nameLower.contains(queryLower);
      }).toList();
  }
  submission(){
    setState(() {
      username=_emailController.text;
      university=welcome!.firstWhere((element) {
        final nameLower=element.name.toLowerCase();
        final queryLower=_searchController.text.toLowerCase();
        return nameLower.contains(queryLower);
      }, orElse: (){
          return  University(webPages: ['not found'], domains: ["not found"], alphaTwoCode: "not found", country: "not found", name: "not found");        
      });
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     //backgroundColor:const Color.fromARGB(255,255,240,141) ,
      body:
      SingleChildScrollView(
        child: Visibility(
          visible: isLoaded,
           replacement:   SizedBox(height: MediaQuery.of(context).size.height/1.3,child: const Center(child: CircularProgressIndicator()),),
         child:FormWidget(getSearchData: getSearchData, searchController: _searchController,
         emailController: _emailController,passwordController: _passwordController,formKey: _formKey,
          readyForSubmit:readyForSubmit,changeBool:changeBool,submission:submission,university:university,username:username)),
      )
      , 
    );
  }
}