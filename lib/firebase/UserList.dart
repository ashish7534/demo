import 'package:demoproject/firebase/update.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersListPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _deleteUser(String userId) async {
    try {
      await firestore.collection('users').doc(userId).delete();
      // Show a confirmation message
      print("User deleted successfully");
    } catch (e) {
      print("Failed to delete user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No users found."));
          }

          // If there are documents in the users collection
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // Get the individual document (user)
              var userDoc = snapshot.data!.docs[index];
              var userData = userDoc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(userData['name'] ?? 'No Name'),
                subtitle: Text('Email: ${userData['email'] ?? 'Unknown'}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to UpdateForm with the user's ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateForm(userId: userDoc.id),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Confirm deletion
                        bool confirmDelete = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete User"),
                            content: Text("Are you sure you want to delete this user?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text("Delete", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ) ?? false;

                        if (confirmDelete) {
                          await _deleteUser(userDoc.id);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
