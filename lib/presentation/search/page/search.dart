import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _allUsers = [];
  List<DocumentSnapshot> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchAllUsers();
  }

  Future<void> _fetchAllUsers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('User').get();
    setState(() {
      _allUsers = snapshot.docs;
    });
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.length >= 2) {
        _filteredUsers = _allUsers.where((user) {
          final fullName = user['fullName'].toString().toLowerCase();
          final searchText = _searchController.text.toLowerCase();
          return fullName.contains(searchText);
        }).toList();
      } else {
        _filteredUsers = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _searchController.text.length < 3
                  ? Center(child: Text('Type to search'))
                  : _filteredUsers.isEmpty
                      ? Center(child: Text('No results found'))
                      : ListView.builder(
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return ListTile(
                              title: Text(user['fullName']),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
