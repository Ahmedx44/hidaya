import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
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
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String? imagePath;
  ImagePicker imagePicker = ImagePicker();

  // Add a state variable to track the selected radio button
  String _selectedGender = 'male'; // Default value

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  // Show loading dialog function as before
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
    return BlocProvider(
      create: (context) => EditProfileCubit(sl<GetUserUsecase>())..getUser(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
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

                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(Icons.arrow_back_ios_new,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary)),
                                ),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                ),
                                IconButton(
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
                                  icon: Icon(Icons.check,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                )
                              ],
                            ),
                            ProfilePic(
                              image: imagePath ?? userData?['imageUrl'] ?? '',
                              imageUploadBtnPress: () async {
                                final pickedImage = await imagePicker.pickImage(
                                    source: ImageSource.gallery);

                                if (pickedImage != null) {
                                  File image = File(pickedImage.path);
                                  Uint8List imageByte =
                                      await image.readAsBytes();

                                  setState(() {
                                    imageData = imageByte;
                                  });

                                  var editedImage = await Navigator.push(
                                      context, MaterialPageRoute(
                                    builder: (context) {
                                      return ImageCropper(
                                        image: imageByte,
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
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                    child: ListTile(
                                      title: const Text(
                                        'Male',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                      leading: Radio<String>(
                                        value:
                                            'male', // Value for the male option
                                        groupValue:
                                            _selectedGender, // Track the selected value
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedGender =
                                                value!; // Update selected value
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary, // Container background color
                                    ),
                                    child: ListTile(
                                      title: const Text(
                                        'Female',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                      leading: Radio<String>(
                                        value: 'female',
                                        groupValue: _selectedGender,
                                        onChanged: (String? value) {
                                          setState(() {
                                            _selectedGender = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _textfieldinput('Name', _nameController),
                            _textfieldinput('Email', _emailController),
                            _textfieldinput('Phone', _phoneController)
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(child: Text("No user data available"));
                },
              );
            }
            return const Center(child: Text("State not handled"));
          },
        ),
      ),
    );
  }

  Widget _textfieldinput(String nameofinput, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameofinput,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            controller: controller,
          )
        ],
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
          ClipOval(
            child: ExtendedImage(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              image: image.startsWith('http')
                  ? ExtendedNetworkImageProvider(image)
                  : FileImage(File(image)) as ImageProvider,
              loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.extendedImageLoadState ==
                    LoadState.completed) {
                  return null;
                } else {
                  return Image.asset(AppImage.profile);
                }
              },
            ),
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
