import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_track/controllers/registercontroller.dart';
import 'package:study_track/views/widgets/mytextfield.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController fnameInput = TextEditingController();
  TextEditingController snameInput = TextEditingController();
  TextEditingController phonenumberInput = TextEditingController();
  TextEditingController email = TextEditingController();

  Registercontroller registercontroller = Get.put(Registercontroller());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(children: [
          myTextField(controller: fnameInput, icon:Icons.person, hint: 'Enter first name'),
          SizedBox(
            height: 10,),
          myTextField(controller: snameInput, icon:Icons.person, hint: 'Enter second name'),
          SizedBox(
            height: 10,),
          myTextField(controller: phonenumberInput, icon:Icons.phone_android, hint: 'Enter phone_number'),
          SizedBox(
            height: 10,),
          myTextField(controller: email, icon:Icons.email, hint: 'Enter user email'),
          SizedBox(
            height: 10,),
          ElevatedButton(onPressed: (){
            registercontroller.fname.value = fnameInput.text;
            registercontroller.sname.value = snameInput.text;
            registercontroller.phonenumber.value = phonenumberInput.text;
            registercontroller.email.value = email.text;

            Get.toNamed('/');


          }, child: const Text('Register'))
        ],)
      )
    );
  }
}