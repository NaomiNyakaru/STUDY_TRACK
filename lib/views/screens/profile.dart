import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
 const Profile({super.key});

 @override
 State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
 // Initial profile data
 String profilePicture = 'assets/images/v791-tang-17.jpg';
 String name = "Naomi Nyakaru";
 String email = "naomin@gmail.com"; 
 String phone = "+ 567 8900";

 // Helper function to open an edit dialog
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
             Get.offAndToNamed("/login");
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
             // Profile Picture with edit button
             Stack(
               children: [
                 Container(
                   width: 120,
                   height: 120,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(
                       color: Colors.blue,
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
                 Positioned(
                   bottom: 0,
                   right: 0,
                   child: Container(
                     decoration: const BoxDecoration(
                       color: Colors.blue,
                       shape: BoxShape.circle,
                     ),
                     child: IconButton(
                       icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                       onPressed: () {
                         // Handle image edit (you can add an image picker here)
                         setState(() {
                           profilePicture = 'assets/images/v791-tang-17.jpg'; // Example new asset path
                         });
                       },
                     ),
                   ),
                 ),
               ],
             ),
             const SizedBox(height: 24),
             // Name with edit button
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
                 IconButton(
                   icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                   onPressed: () {
                     openEditDialog("Name", name, (newName) {
                       setState(() {
                         name = newName;
                       });
                     });
                   },
                 ),
               ],
             ),
             const SizedBox(height: 16),
             // Email with edit button
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
                 onPressed: () {
                   openEditDialog("Email", email, (newEmail) {
                     setState(() {
                       email = newEmail;
                     });
                   });
                 },
               ),
             ),
             // Phone with edit button
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
                 onPressed: () {
                   openEditDialog("Phone", phone, (newPhone) {
                     setState(() {
                       phone = newPhone;
                     });
                   });
                 },
               ),
             ),
             // Member Since (Static)
             const ListTile(
               leading: Icon(Icons.date_range, color: Colors.blue),
               title: Text(
                 "Member Since",
                 style: TextStyle(fontSize: 14, color: Colors.grey),
               ),
               subtitle: Text(
                 "January 2024",
                 style: TextStyle(fontSize: 16, color: Colors.black),
               ),
             ),
             const SizedBox(height: 24),
             // Account Management Button
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 onPressed: () {
                   // Handle account management
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.red,
                   padding: const EdgeInsets.symmetric(vertical: 12),
                 ),
                 child: const Text(
                   "Delete Account",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 16,
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
     ),
   );
 }
}