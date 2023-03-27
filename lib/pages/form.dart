import 'package:fetch_api/Services/remote_services.dart';
import 'package:fetch_api/models/university.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
class FormPage extends StatefulWidget {
  const FormPage({super.key});
  

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final TextEditingController _searchController=TextEditingController();
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

  List<Welcome>getSearchData(String query){
      return welcome!.where((element) {
       final nameLower=element.name.toLowerCase();
      final queryLower=query.toLowerCase();

      return nameLower.contains(queryLower);
      }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("University Search"),
      ),
      body: Visibility(
        visible: isLoaded,
         replacement:  const CircularProgressIndicator(),
        child: TypeAheadField<Welcome?>(
          
          textFieldConfiguration: TextFieldConfiguration(
              controller:_searchController
          ),
          
          noItemsFoundBuilder: (context) => Container(
                height: 100,
                child: const Center(
                  child: Text(
                    'No Users Found.',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
          suggestionsCallback: getSearchData,
          itemBuilder: (context,Welcome? suggestion){
            final user =suggestion!;
            return ListTile(title: Text(user.name),);
          },
          onSuggestionSelected: (Welcome? suggestion){
            _searchController.text=suggestion!.name.toString();
          },
        ),


      )
      , 
    );
  }
}