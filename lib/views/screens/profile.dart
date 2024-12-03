import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:study_track/views/widgets/mysnackbar.dart';

final store = GetStorage();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  String profilePicture = 'assets/images/profile.png';
  late String name;
  late String email;
  late String phone;

  @override
  void initState() {
    super.initState();
    
    
    String firstname = store.read('firstname') ?? "First Name";
    String lastname = store.read('lastname') ?? "Last Name";
    name = "$firstname $lastname";
    email = store.read('email') ?? "Email not available";
    phone = store.read('phone') ?? "Phone not available";
  }

 
  void openEditDialog(String fieldName, String currentValue, Function(String) onSave) {
    final TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldName"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: fieldName,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text("Profile"),
      centerTitle: true,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed("/home");
          },
          icon: const Icon(Icons.home),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed("/login");
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      profilePicture,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.person, size: 60);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text(
                "Email",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Text(
                email,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: (){
                  openEditDialog("Email", email, (newEmail) async {
                      final response = await http.get(Uri.parse(
                        "http://192.168.39.125/study_track/register.php?action=update&user_id=${store.read("userid")}&firstname=${store.read("firstname")}&lastname=${store.read("lastname")}&phone=${store.read("phone")}&email=$newEmail"
                      ));
                      
                      if (response.statusCode == 200) {
                        var serverResponse = jsonDecode(response.body);
                        print('Response body: ${response.body}');

                        if (serverResponse["success"] == 1 && serverResponse["user_updated"] == 1) {
                          setState(() {
                            email = newEmail;
                          });
                          store.write('email', newEmail);

                          mysnackbar(
                            title: "Success",
                            message: "Email updated successfully", 
                            type: "success"
                          );
                        } else {
                          mysnackbar(
                            title: "Error", 
                            message: "Email update failed", 
                            type: "error"
                          );
                        }
                      }
                    });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: const Text(
                "Phone",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              subtitle: Text(
                phone,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: (){
                  openEditDialog("Phone", phone, (newPhone) async {
                      final response = await http.get(Uri.parse(
                        "http://192.168.39.125/study_track/register.php?action=update&user_id=${store.read("userid")}&firstname=${store.read("firstname")}&lastname=${store.read("lastname")}&email=${store.read("email")}&phone=$newPhone"
                      ));
                      
                      if (response.statusCode == 200) {
                        var serverResponse = jsonDecode(response.body);
                        print('Response body: ${response.body}');

                        if (serverResponse["success"] == 1 && serverResponse["user_updated"] == 1) {
                          setState(() {
                            phone = newPhone;
                          });
                          store.write('phone', newPhone);

                          mysnackbar(
                            title: "Success",
                            message: "Phone updated successfully", 
                            type: "success"
                          );
                        } else {
                          mysnackbar(
                            title: "Error", 
                            message: "Phone update failed", 
                            type: "error"
                          );
                        }
                      }
                    });
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete Account"),
                      content: const Text(
                          "Are you sure you want to delete your account? This action cannot be undone."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async{
                            final response = await http.get(Uri.parse("http://192.168.39.125/study_track/register.php?action=delete&user_id=${store.read("userid")}"));
                            if(response.statusCode == 200){
                              var serverResponse = jsonDecode(response.body);
                              print('Response body: ${response.body}');

                              if(serverResponse["success"]==1 && serverResponse["user_deleted"]==1){
                                mysnackbar(
                                  title: "Success",
                                  message: "account deleted successfully", 
                                  type: "success");
                              }else{
                                mysnackbar(
                                  title: "Error", 
                                  message: "account deletion failed", 
                                  type: "error");
                              }
                            }
                            Get.offAllNamed("/login");
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Delete Account"),
            ),
          ],
        ),
      ),
    ),
  );
}
}