import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../models/university.dart';
import '../pages/form.dart';
class SearchBarWidget extends StatelessWidget{

  final List<Welcome?>Function(String query) getSearchData;
  final TextEditingController searchController;
  final Function(FormValid,bool) changeBool;
  const SearchBarWidget ({super.key, required this.getSearchData,required this.searchController,required this.changeBool});
  @override
  Widget build(BuildContext context) {
    
    return  Container(
      padding: const EdgeInsets.all(20),
      child: TypeAheadFormField<Welcome?>(
            
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textFieldConfiguration: TextFieldConfiguration(
                controller:searchController,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(20),
                border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)))
                
            ),
            
            noItemsFoundBuilder: (context) => Container(
                  height: 50,
                  child: const Center(
                    child: Text(
                      'No Users Found.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            suggestionsCallback: getSearchData,
            itemBuilder: (context,Welcome? suggestion){
              final user =suggestion!;
              return ListTile(title: Text(user.name),);
            },
            onSuggestionSelected: (Welcome? suggestion){
              searchController.text=suggestion!.name.toString();
            },
      
              validator: (value) {
      if (value == null || value.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
      changeBool(FormValid.search,false);
       });
      
        return 'Please enter some text';
      }
      else{
        WidgetsBinding.instance.addPostFrameCallback((_) {
      changeBool(FormValid.search,true);
       });
      }
      
      return null;
      
      },
          ),
    );
  }
}