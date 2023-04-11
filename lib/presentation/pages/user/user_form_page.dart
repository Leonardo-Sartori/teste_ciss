import 'package:flutter/material.dart';
import 'package:teste_ciss/shared/components/app_textfield.dart';
import 'package:teste_ciss/shared/utils/ui_info/strings_ui_info.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({ Key? key }) : super(key: key);

  @override
  UserFormPageState createState() => UserFormPageState();
}

class UserFormPageState extends State<UserFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSize _appBar(){
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: AppBar(
        title: const Text("Usuário"),
      ),
    );
  }

  Widget _body(){
    return SafeArea(child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AppTextfield(
              "Nome: *", 
              required: true,
              TextCapitalization.sentences,
              inputType: TextInputType.name,
            ),
            AppTextfield(
              "Username: *", 
              required: true,
              TextCapitalization.sentences,
              inputType: TextInputType.name,
            ),
            AppTextfield(
              "Email: *", 
              TextCapitalization.sentences,
              inputType: TextInputType.emailAddress,
              required: true,
              validator: (value){
                if(!value!.contains("@") || !value.contains(".com")){
                  return StringsUiInfo.requiredField;
                }

                return null;
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}