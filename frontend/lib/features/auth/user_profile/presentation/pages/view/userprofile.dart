import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/auth/sign_up/domain/entities/user_details.dart';
import 'package:frontend/features/auth/user_profile/presentation/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:frontend/features/auth/user_profile/presentation/pages/view/view_account_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EditProfilePage extends StatefulWidget {
  UserDetails? userDetails;
  EditProfilePage({Key? key, this.userDetails}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  File? image;

  Future pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() =>
          {this.image = imageTemporary, imageController.text = image.name});
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    fullNameController.text = widget.userDetails!.full_name != null
        ? widget.userDetails!.full_name!
        : '';
    contactNumberController.text = widget.userDetails!.contact_number != null
        ? widget.userDetails!.contact_number!
        : '';
    bioController.text =
        widget.userDetails!.bio != null ? widget.userDetails!.bio! : '';
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false, navTitle: "Edit Profile", backNavigate: () {}),
      body: SingleChildScrollView(
        child: BlocConsumer<EditUserProfileBloc, EditUserProfileState>(
          listener: (context, state) {
            if (state is EditUserProfileLoaded) {
              pushNewScreenWithRouteSettings(context,
                  screen: const ViewAccountScreen(),
                  settings:
                      const RouteSettings(name: Routes.VIEW_ACCOUNT_SCREEN));
            } else if (state is EditUserProfileFailed) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Error!! while updating'),
                duration: Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: (size.height * 0.15)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: widget.userDetails!.profile_image !=
                                            null
                                        ? NetworkImage(
                                            widget.userDetails!.profile_image!)
                                        : const AssetImage(
                                                "assets/images/i.png")
                                            as ImageProvider
                                    //  NetworkImage(
                                    //   widget.userDetails!.profile_image != null
                                    //       ? widget.userDetails!.profile_image!
                                    //       : "assets/images/counsellor_profile_image.jpeg",
                                    // ),
                                    )),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  pickImage();

                                  print("this is image");
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    buildTextField(
                      labelText: "Full Name",
                      placeholder: widget.userDetails!.full_name != null
                          ? widget.userDetails!.full_name!
                          : "Enter Full Name",
                      isPasswordTextField: false,
                      maxLines: 1,
                      controller: fullNameController,
                    ),
                    buildTextField(
                      labelText: "Contact",
                      placeholder: widget.userDetails!.contact_number != null
                          ? widget.userDetails!.contact_number!
                          : "Enter Contact Nunmber",
                      isPasswordTextField: false,
                      maxLines: 1,
                      controller: contactNumberController,
                    ),
                    buildTextField(
                      labelText: "Bio",
                      placeholder: widget.userDetails!.bio != null
                          ? widget.userDetails!.bio!
                          : "Enter Bio",
                      isPasswordTextField: false,
                      maxLines: 4,
                      controller: bioController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ActionButton(
                          background: CustomColors.primary,
                          width: size.width,
                          isLoading:
                              state is EditUserProfileLoading ? true : false,
                          height: 50,
                          borderRadius: 10,
                          text: Text(
                            "Save",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          onPressed: () {
                            print("button is clicked");
                            // pickImage();

                            print(image);
                            BlocProvider.of<EditUserProfileBloc>(context).add(
                                SaveUserProfileEvent(
                                    user: UserDetails(
                                        id: widget.userDetails!.id,
                                        fileData: image,
                                        // image: (imageFile != null) ? FileImage(imageFile!) as ImageProvider : AssetImage("assets/xxx.png")
                                        full_name: fullNameController.text != ""
                                            ? fullNameController.text
                                            : widget.userDetails!.full_name,
                                        contact_number:
                                            contactNumberController.text != ""
                                                ? contactNumberController.text
                                                : widget.userDetails!
                                                    .contact_number,
                                        bio: bioController.text != ""
                                            ? bioController.text
                                            : widget.userDetails!.bio)));
                          }),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextField({
    required String labelText,
    required String placeholder,
    required bool isPasswordTextField,
    int? maxLines,
    required TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,

        // maxLength: maxLines,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
