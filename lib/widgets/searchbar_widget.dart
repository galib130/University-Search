import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../models/university.dart';
import '../pages/form.dart';
class SearchBarWidget extends StatelessWidget{

  final List<University?>Function(String query) getSearchData;
  final TextEditingController searchController;
  final Function(FormValid,bool) changeBool;
  const SearchBarWidget ({super.key, required this.getSearchData,required this.searchController,required this.changeBool});
  @override
  Widget build(BuildContext context) {
    
    return  Container(
      padding: const EdgeInsets.only(left:20,bottom: 20,right: 20),
    
      child: TypeAheadFormField<University?>(
            hideOnLoading: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textFieldConfiguration: TextFieldConfiguration(
                controller:searchController, 
            ),
            
            noItemsFoundBuilder: (context) => Container(

                color: Theme.of(context).primaryColor,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'No Universities Found.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            suggestionsCallback: getSearchData,
            itemBuilder: (context,University? suggestion){
              final user =suggestion!;
              return ListTile(title: Text(user.name),tileColor:Theme.of(context).primaryColor,);
            },
            onSuggestionSelected: (University? suggestion){
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