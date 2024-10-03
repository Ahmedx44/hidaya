import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/data/model/user/userModel.dart';
import 'package:hidaya/domain/usecase/user/get_user_usecase.dart';
import 'package:hidaya/domain/usecase/user/update_user.dart';
import 'package:hidaya/presentation/profile/bloc/edit_profile_bloc/edit_profile_cubit.dart';
import 'package:hidaya/presentation/profile/bloc/edit_profile_bloc/edit_profile_state.dart';
import 'package:hidaya/service_locator.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageData;
    ImagePicker imagePicker = ImagePicker();
    XFile imagefile;

    return BlocProvider(
      create: (context) => EditProfileCubit(sl<GetUserUsecase>())..getUser(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text("Edit Profile"),
        ),
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is EditProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is EditProfileLoaded) {
              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: state.user.get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading user data"));
                  }
                  if (snapshot.hasData && snapshot.data != null) {
                    final userData = snapshot.data!.data();
                    if (userData != null) {
                      _nameController.text = userData['fullName'] ?? '';
                      _emailController.text = userData['email'] ?? '';
                      _phoneController.text = userData['phone'] ?? '';
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          ProfilePic(
                            image: imagePath ?? userData?['imageUrl'] ?? '',
                            imageUploadBtnPress: () async {
                              final pickedImage = await imagePicker.pickImage(
                                  source: ImageSource.gallery);

                              File image = File(pickedImage!.path);
                              Uint8List imageByte = await image.readAsBytes();

                              setState(() {
                                imageData = imageByte;
                              });

                              var editedImage = await Navigator.push(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return ImageEditor(
                                    image: imageData,
                                  );
                                },
                              ));

                              if (editedImage != null) {
                                final tempFile = File(pickedImage.path);
                                await tempFile.writeAsBytes(editedImage);

                                setState(() {
                                  imagePath = tempFile.path;
                                });
                              }
                            },
                          ),
                          Form(
                            child: Column(
                              children: [
                                UserInfoEditField(
                                  text: 'Name',
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16.0 * 1.5,
                                              vertical: 16.0),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                  ),
                                ),
                                UserInfoEditField(
                                  text: "Email",
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16.0 * 1.5,
                                              vertical: 16.0),
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                  ),
                                ),
                                UserInfoEditField(
                                  text: "Phone",
                                  child: TextFormField(
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0 * 1.5,
                                          vertical: 16.0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Cancel action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.tertiary,
                                    foregroundColor: Colors.white,
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: const StadiumBorder(),
                                  ),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              SizedBox(
                                width: 160,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    minimumSize:
                                        const Size(double.infinity, 48),
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () async {
                                    showLoadingDialog(context);
                                    try {
                                      String? imageUrl = '';

                                      if (imagePath != null) {
                                        // Create a reference to the location you want to upload the image to
                                        final storageRef = FirebaseStorage
                                            .instance
                                            .ref()
                                            .child(
                                                'profile_images/${FirebaseAuth.instance.currentUser!.uid}.jpg');

                                        // Upload the file to Firebase Storage
                                        await storageRef
                                            .putFile(File(imagePath!));

                                        // Get the download URL
                                        imageUrl =
                                            await storageRef.getDownloadURL();
                                      }
                                      await sl<UpdateUser>().call(Usermodel(
                                          email: _emailController.text,
                                          fullName: _nameController.text,
                                          phoneNumber: _phoneController.text,
                                          imageUrl: imageUrl));
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Profile updated successfully"),
                                        ),
                                      );
                                    } catch (e) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Failed to update profile"),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Save Update"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text("No user data found"));
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: image.startsWith('http')
                ? CachedNetworkImageProvider(image)
                : FileImage(File(image)) as ImageProvider,
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            child: child,
          ),
        ],
      ),
    );
  }
}
