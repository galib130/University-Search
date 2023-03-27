
import 'package:fetch_api/Services/remote_services.dart';
import 'package:fetch_api/models/university.dart';
import 'package:fetch_api/widgets/form_widget.dart';
import 'package:flutter/material.dart';

enum FormValid{
  search,
  email,
  password
}
enum Flag{
  True,
  False
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
String placeholder="";
Welcome? university;
bool searchValid=false;
bool emailValid=false;
bool readyForSubmit=false;
bool passwordValid=false;
final _formKey=GlobalKey<FormState>();

  List<Welcome>?welcome;
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
 
  
  List<Welcome>getSearchData(String query){
      return welcome!.where((element) {
       final nameLower=element.name.toLowerCase();
      final queryLower=query.toLowerCase();

      return nameLower.contains(queryLower);
      }).toList();
  }
  submission(){
    setState(() {
      placeholder="never";
      university=welcome!.firstWhere((element) {
        final nameLower=element.name.toLowerCase();
        final queryLower=_searchController.text.toLowerCase();
        return nameLower.contains(queryLower);
      }, orElse: (){
          return  Welcome(webPages: ['not found'], domains: ["not found"], alphaTwoCode: "not found", country: "not found", name: "not found");        
      });
      print(placeholder);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("University Search"),
      ),
      body:
      Visibility(
        visible: isLoaded,
         replacement:  const CircularProgressIndicator(),
       child:FormWidget(getSearchData: getSearchData, searchController: _searchController,
       emailController: _emailController,passwordController: _passwordController,formKey: _formKey,
        readyForSubmit:readyForSubmit,changeBool:changeBool,submission:submission,university:university))
      , 
    );
  }
}