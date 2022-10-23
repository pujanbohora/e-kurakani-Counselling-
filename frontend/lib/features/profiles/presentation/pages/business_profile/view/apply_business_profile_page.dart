import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:frontend/features/profiles/data/model/business_profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:frontend/features/profiles/domain/entities/business_profile.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/presentation/bloc/business_bloc/business_bloc.dart';
import 'package:frontend/features/profiles/presentation/bloc/counsellor_bloc/counsellor_bloc.dart';
import 'package:frontend/injectable.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ApplyBusinessProfileScreen extends StatefulWidget {
  final String? userId;
  const ApplyBusinessProfileScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<ApplyBusinessProfileScreen> createState() =>
      _ApplyBusinessProfileScreenState();
}

class _ApplyBusinessProfileScreenState
    extends State<ApplyBusinessProfileScreen> {
  // var getCategoryUsecase = getIt<GetCategoryUsecase>();
  // var getCounsellorProfileUsecase = getIt<GetCounsellorProfileUsecase>();
  // var applyCounsellorUsecase = getIt<ApplyCounsellorProfileUsecase>();
  // var signUpLocalDataSource = getIt<SignUpLocalDataSource>();

  BusinessProfile? profileData;
  bool applied = false;

  List itemsValue = ["Error loading"];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  String? name;
  String dobOnChangeValue = "";
  String fileName = '';
  File? file;
  String imageName = '';
  File? image;

  bool basicState = true;
  bool attachmentState = false;
  bool editBasicState = false;
  bool addAttachmentState = false;

  FocusNode nameFocusNode = FocusNode();

  String? dropDownValue;
  final _formKey = GlobalKey<FormBuilderState>();
  final _editFormKey = GlobalKey<FormBuilderState>();
  final _attachmentUploadKey = GlobalKey<FormBuilderState>();

  List<AddCategoryEntity>? subCategory;

  List<Map<String, dynamic>> attachments = [
    {"label": "", "fileName": "", "file": "", "remarks": ""}
  ];

  clearTextFiled() {
    _nameController.clear();
    _emailController.clear();
    _contactController.clear();
  }

  @override
  void initState() {
    BlocProvider.of<BusinessBloc>(context)
        .add(GetBusinessEvent(userId: widget.userId!));
    // BlocProvider.of<CategoryBloc>(context).add(GetSubCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      body: BlocConsumer<BusinessBloc, BusinessState>(
        listener: (context, state) {
          // print(state);
          if (state is BusinessLoadedState) {
            // print(state);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Applied for verification!'),
              duration: Duration(seconds: 1),
            ));
          }
          if (state is EditBusinessProfileLoadedState) {
            // print(state);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Profile Edited!'),
              duration: Duration(seconds: 1),
            ));
            setState(() {
              editBasicState = false;
            });
          }
          if (state is BusinessAttachmentLoadedState) {
            // print(state);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Attachment Added!'),
              duration: Duration(seconds: 1),
            ));
            setState(() {
              addAttachmentState = false;
            });
          }
          if (state is BusinessAttachmentDeletedState) {
            // print(state);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Attachment Deleted!'),
              duration: Duration(seconds: 1),
            ));
          }
          if (state is BusinessFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Error!'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        builder: (context, state) {
          if (state is GetBusinessLoadedState) {
            profileData = state.businessProfileData;
            applied = state.businessProfileData.apply_for_verification == true;
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: (size.height * 0.1)),
                child: applied
                    ? viewApplication(context, profileData)
                    : applyForm(context, state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget applyForm(BuildContext context, state) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),

                Text("Name of the organization",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: size.height * 0.01,
                ),

                CustomTextField(
                  textController: _nameController,
                  validator: FormBuilderValidators.required(
                      errorText: 'Name is required'),
                  decoration: customFormFieldDecoration.copyWith(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    labelText: 'John Doe',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  attribute: 'name',
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),

                Text(
                  "Organization email",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),

                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  textController: _emailController,
                  validator: FormBuilderValidators.required(
                    errorText: 'Email is required',
                  ),
                  decoration: customFormFieldDecoration.copyWith(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    labelText: 'john.doe@email.com',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  attribute: 'email',
                ),

                SizedBox(
                  height: size.height * 0.03,
                ),

                Text("Organization contact number",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: size.height * 0.01,
                ),

                CustomTextField(
                  keyboardType: TextInputType.number,
                  inputType: TextInputType.number,
                  textController: _contactController,
                  validator: FormBuilderValidators.required(
                      errorText: 'Contact number is required'),
                  decoration: customFormFieldDecoration.copyWith(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        )),
                    labelText: '9898989898',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  // keyboardType: ,
                  attribute: 'number',
                ),

                //time
                SizedBox(
                  height: size.height * 0.03,
                ),

                Text("Select category",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: size.height * 0.01,
                ),

                BlocBuilder<SubCategoryBloc, CategoryState>(
                  builder: (context, state) {
                    (state is GetSubCategoryLoadedState)
                        ? subCategory = state.getCategoryData
                        : '';
                    return DropdownSearch<String>(
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      items: (subCategory != null)
                          ? subCategory!.map((item) => item.name!).toList()
                          : [],
                      // dropdownSearchDecoration: const InputDecoration(
                      //   hintText: "Choose category",
                      // ),
                      onChanged: (value) {
                        setState(() {
                          int index = subCategory!
                              .indexWhere((element) => element.name == value!);
                          dropDownValue = subCategory![index].id;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                Text("Organization Logo",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: size.height * 0.01,
                ),
                InkWell(
                  onTap: () async {
                    ImagePicker picker = ImagePicker();
                    final imageResult =
                        await picker.pickImage(source: ImageSource.camera);

                    if (imageResult != null) {
                      final imageTemporary = File(imageResult.path);

                      setState(() => {
                            image = imageTemporary,
                            imageName = imageResult.name,
                          });
                    } else {
                      return;
                      // User canceled the picker
                    }

                    //open single file
                    // final file = result.files
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CustomColors.black,
                    ),
                    child: const Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(imageName),

                //time
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 18,
                ),

                const Text(
                  "Add Attachments",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.black),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      attachments.add({
                        "label": "",
                        "fileName": "",
                        "file": "",
                        "remarks": ""
                      });
                      print(attachments);
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Another File"),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemCount: attachments.length,
                    itemBuilder: (context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Label",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          CustomTextField(
                            onChange: (value) {
                              setState(() {
                                attachments[index]["label"] = value;
                              });
                            },
                            // initialValue: attachments[index]
                            //     ["label"],
                            validator: FormBuilderValidators.required(
                                errorText: 'File label is required'),
                            decoration: customFormFieldDecoration.copyWith(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Registered Document',
                              contentPadding: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                              ),
                            ),
                            attribute: "label$index",
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text("Remarks",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          CustomTextField(
                            onChange: (value) {
                              setState(() {
                                attachments[index]["remarks"] = value;
                              });
                            },
                            // initialValue: attachments[index]
                            //     ["remarks"],
                            maxLines: 4,
                            borderColor: CustomColors.black,
                            // validator: FormBuilderValidators.required(
                            //     errorText:
                            //         'Remarks is required'),
                            decoration: customFormFieldDecoration.copyWith(
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              hintText: 'Remarks',
                              contentPadding: const EdgeInsets.only(
                                bottom: 10,
                                left: 12,
                                right: 12,
                              ),
                            ),
                            attribute: "remarks$index",
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                // file = File(
                                //     result.files.single.path!);
                                print(result.files.first.name);
                                setState(() {
                                  attachments[index]["fileName"] =
                                      result.files.first.name;
                                  attachments[index]["file"] =
                                      File(result.files.single.path!);
                                });
                              } else {
                                return;
                                // User canceled the picker
                              }

                              //open single file
                              // final file = result.files
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.black,
                              ),
                              child: const Center(
                                child: Text(
                                  'Upload',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(attachments[index]["fileName"]),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (attachments.length > 1) {
                                setState(() {
                                  attachments.removeAt(index);
                                });
                              }
                            },
                            icon: Icon(Icons.delete),
                            label: Text("Remove"),
                          ),
                        ],
                      );
                    }),

                //Button
                const SizedBox(
                  height: 20,
                ),

                ActionButton(
                  background: CustomColors.primaryBlue,
                  width: size.width,
                  height: 50,
                  borderRadius: 10,
                  isLoading: state is CounsellorLoadedState ? true : false,
                  text: Text(
                    "Apply for Verification",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool validated = true;
                      for (Map<String, dynamic> att_data in attachments) {
                        if (att_data["label"] == "" || att_data["file"] == "") {
                          validated = false;
                          break;
                        }
                      }
                      if (imageName == '') {
                        validated = false;
                      }
                      if (validated) {
                        List<ProfileAttachments> paList = [];
                        for (Map<String, dynamic> att_data in attachments) {
                          ProfileAttachments pa = ProfileAttachments(
                            label: att_data["label"],
                            remarks: att_data["remarks"],
                            fileData: att_data["file"],
                          );
                          paList.add(pa);
                        }

                        BlocProvider.of<BusinessBloc>(context).add(
                          ApplyBusinessEvent(
                            businessProfileEntity: BusinessProfile(
                              id: profileData!.id,
                              name: _nameController.text,
                              email: _emailController.text,
                              contact_number: _contactController.text,
                              category: AddCategoryModel(id: dropDownValue),
                              profile_attachments: paList,
                              logoData: image,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter all the fields!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }

                      // clearTextFiled();

                      // Navigator.pushNamed(
                      //     context,
                      //     Routes
                      //         .CREATE_REQUEST_REQUEST_FOR_APPOINTMENT_VIEW_SCREEN);
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget viewApplication(BuildContext context, profileData) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: (size.height * 0.1)),
        child: SizedBox(
          // margin: const EdgeInsets.only(top: 30, left: 40),
          // height: MediaQuery.of(context).size.height * 0.40,
          width: double.infinity,

          // padding: const EdgeInsets.symmetric(
          //   horizontal: 30,
          //   vertical: 20
          // ),
          child: Column(
            children: [
              Wrap(
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ActionButton(
                                  background: CustomColors.black,
                                  width: size.width,
                                  height: 40,
                                  borderRadius: 10,
                                  text: Text(
                                    "Basic Details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      basicState = true;
                                      attachmentState = false;
                                    });
                                    // BlocProvider.of<ProfileRequestBloc>(context)
                                    //     .add(GetCounsellorProfileRequestEvent());
                                  }),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ActionButton(
                                background: CustomColors.black,
                                width: size.width,
                                height: 40,
                                borderRadius: 10,
                                text: Text(
                                  "Attachments",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    basicState = false;
                                    attachmentState = true;
                                  });
                                  // BlocProvider.of<ProfileRequestBloc>(context)
                                  //     .add(GetBusinessProfileRequestEvent());
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        basicState
                            ? viewBasicDetails(context, profileData)
                            : attachmentState
                                ? viewAttachments(context, profileData)
                                : SizedBox(),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget viewBasicDetails(BuildContext context, profileData) {
    Size size = MediaQuery.of(context).size;
    _nameController.text = profileData!.name;
    _emailController.text = profileData!.email;
    _contactController.text = profileData!.contact_number;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        const Center(
          child: Text(
            "Basic Info",
            style: TextStyle(
              color: CustomColors.primaryBlue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: profileData!.logo != null
                ? NetworkImage(
                    profileData!.logo!,
                  )
                : const AssetImage(
                    "assets/images/counsellor_profile_image.jpeg",
                  ) as ImageProvider,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Name:",
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              profileData!.name != null
                  ? profileData!.name!.toUpperCase()
                  : "N/A",
              style: const TextStyle(
                color: CustomColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Email:",
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              profileData!.email != null ? profileData!.email! : "N/A",
              style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Contact Number:",
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              profileData!.contact_number != null
                  ? profileData!.contact_number!
                  : "N/A",
              style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Category:",
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              profileData!.category != null
                  ? profileData!.category!.name!
                  : "N/A",
              style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "User Role:",
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              profileData!.user != null
                  ? profileData!.user!.user_role!
                  : "Business",
              style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            const Text(
              "Status:",
              style: TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              profileData!.status != null
                  ? profileData!.status!.toUpperCase()
                  : "N/A",
              style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ActionButton(
          background: CustomColors.black,
          width: size.width,
          height: 40,
          borderRadius: 10,
          text: Text(
            "Edit",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          onPressed: () {
            if (profileData!.status != 'approved' &&
                profileData!.status != 'declined') {
              setState(() {
                editBasicState = true;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Your application is already ${profileData!.status}! Please contact us to update.'),
                duration: Duration(seconds: 1),
              ));
            }
          },
        ),
        editBasicState
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormBuilder(
                  key: _editFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              editBasicState = false;
                            });
                          },
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      Text("Name of the organization",
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        height: size.height * 0.01,
                      ),

                      CustomTextField(
                        textController: _nameController,
                        validator: FormBuilderValidators.required(
                            errorText: 'Name is required'),
                        decoration: customFormFieldDecoration.copyWith(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'John Doe',
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                          ),
                        ),
                        attribute: 'name',
                      ),

                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      Text(
                        "Organization email",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),

                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        textController: _emailController,
                        validator: FormBuilderValidators.required(
                          errorText: 'Email is required',
                        ),
                        decoration: customFormFieldDecoration.copyWith(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          labelText: 'john.doe@email.com',
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                          ),
                        ),
                        attribute: 'email',
                      ),

                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      Text("Organization contact number",
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        height: size.height * 0.01,
                      ),

                      CustomTextField(
                        keyboardType: TextInputType.number,
                        inputType: TextInputType.number,
                        textController: _contactController,
                        validator: FormBuilderValidators.required(
                            errorText: 'Contact number is required'),
                        decoration: customFormFieldDecoration.copyWith(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          labelText: '9898989898',
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                          ),
                        ),
                        // keyboardType: ,
                        attribute: 'number',
                      ),

                      //time
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      Text("Select category",
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        height: size.height * 0.01,
                      ),

                      BlocBuilder<SubCategoryBloc, CategoryState>(
                        builder: (context, state) {
                          (state is GetSubCategoryLoadedState)
                              ? subCategory = state.getCategoryData
                              : '';
                          return DropdownSearch<String>(
                            selectedItem: profileData!.category!.name,
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                            ),
                            items: (subCategory != null)
                                ? subCategory!
                                    .map((item) => item.name!)
                                    .toList()
                                : [],
                            // dropdownSearchDecoration: const InputDecoration(
                            //   hintText: "Choose category",
                            // ),
                            onChanged: (value) {
                              setState(() {
                                int index = subCategory!.indexWhere(
                                    (element) => element.name == value!);
                                dropDownValue = subCategory![index].id;
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text("Organization Logo",
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      InkWell(
                        onTap: () async {
                          ImagePicker picker = ImagePicker();
                          final imageResult = await picker.pickImage(
                              source: ImageSource.camera);

                          if (imageResult != null) {
                            final imageTemporary = File(imageResult.path);

                            setState(() => {
                                  image = imageTemporary,
                                  imageName = imageResult.name,
                                });
                          } else {
                            return;
                            // User canceled the picker
                          }

                          //open single file
                          // final file = result.files
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.black,
                          ),
                          child: const Center(
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(imageName),

                      ActionButton(
                        background: CustomColors.primaryBlue,
                        width: size.width,
                        height: 50,
                        borderRadius: 10,
                        text: Text(
                          "Edit Details",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () async {
                          if (_editFormKey.currentState!.validate()) {
                            BlocProvider.of<BusinessBloc>(context).add(
                              EditBusinessProfileEvent(
                                businessProfileEntity: BusinessProfile(
                                  id: profileData!.id,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  contact_number: _contactController.text,
                                  category: AddCategoryModel(id: dropDownValue),
                                  logoData: image,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget viewAttachments(BuildContext context, profileData) {
    Size size = MediaQuery.of(context).size;
    Future<void> _launchInBrowser(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            "Attachments",
            textScaleFactor: 1.5,
            style: TextStyle(
              color: CustomColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        addAttachmentState
            ? Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addAttachmentState = false;
                    });
                  },
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                ),
              )
            : ActionButton(
                background: CustomColors.black,
                width: size.width,
                height: 40,
                borderRadius: 10,
                text: Text(
                  "Add Attachment",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: () {
                  if (profileData!.status != 'approved' &&
                      profileData!.status != 'declined') {
                    setState(() {
                      addAttachmentState = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Your application is already ${profileData!.status}! Please contact us to update.'),
                      duration: Duration(seconds: 1),
                    ));
                  }
                },
              ),
        addAttachmentState
            ? FormBuilder(
                key: _attachmentUploadKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text("Label", style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    CustomTextField(
                      textController: _labelController,
                      // initialValue: attachments[index]
                      //     ["label"],
                      validator: FormBuilderValidators.required(
                          errorText: 'File label is required'),
                      decoration: customFormFieldDecoration.copyWith(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: 'Registered Document',
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                      ),
                      attribute: "label",
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text("Remarks",
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    CustomTextField(
                      textController: _remarksController,
                      // initialValue: attachments[index]
                      //     ["remarks"],
                      maxLines: 4,
                      borderColor: CustomColors.black,
                      decoration: customFormFieldDecoration.copyWith(
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        hintText: 'Remarks',
                        contentPadding: const EdgeInsets.only(
                          bottom: 10,
                          left: 12,
                          right: 12,
                        ),
                      ),
                      attribute: "remarks",
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    InkWell(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            fileName = result.files.first.name;
                            file = File(result.files.single.path!);
                          });
                        } else {
                          return;
                          // User canceled the picker
                        }

                        //open single file
                        // final file = result.files
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.black,
                        ),
                        child: const Center(
                          child: Text(
                            'File Upload',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(fileName),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    ActionButton(
                      background: CustomColors.primaryBlue,
                      width: size.width,
                      height: 50,
                      borderRadius: 10,
                      text: Text(
                        "Add Attachment",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () async {
                        if (_attachmentUploadKey.currentState!.validate()) {
                          bool validated = true;
                          if (fileName == '') {
                            validated = false;
                          }
                          if (validated) {
                            BlocProvider.of<BusinessBloc>(context).add(
                              AddBusinessAttachmentEvent(
                                  attachmentEntity: ProfileAttachments(
                                business_profile: BusinessProfileModel(
                                  id: profileData!.id,
                                ),
                                label: _labelController.text,
                                remarks: _remarksController.text,
                                fileData: file,
                              )),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Please select a file!'),
                              duration: Duration(seconds: 1),
                            ));
                          }
                        }
                      },
                    ),
                  ],
                ),
              )
            : SizedBox(),
        const SizedBox(
          height: 15,
        ),
        Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: profileData!.attachments!.isNotEmpty
                ? Column(
                    children: List.generate(
                      profileData!.attachments!.length,
                      (index) {
                        return InkWell(
                          onTap: () async {
                            //image show in browser
                            Uri uri = Uri.parse(
                                profileData!.attachments![index].file != null
                                    ? profileData!.attachments![index].file!
                                    : "");
                            _launchInBrowser(uri);
                          },
                          child: Column(
                            children: [
                              const Icon(
                                Icons.file_copy,
                                size: 90,
                                color: CustomColors.primaryBlue,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Name:",
                                    style: TextStyle(
                                        color: CustomColors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    profileData!.attachments![index].label !=
                                            null
                                        ? profileData!
                                            .attachments![index].label!
                                        : "N/A",
                                    style: const TextStyle(
                                      color: CustomColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Remarks:",
                                    style: TextStyle(
                                        color: CustomColors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    profileData!.attachments![index].remarks !=
                                            null
                                        ? profileData!
                                            .attachments![index].remarks!
                                        : "N/A",
                                    style: const TextStyle(
                                      color: CustomColors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  if (profileData!.status != 'approved' &&
                                      profileData!.status != 'declined') {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            'Are you sure you want to remove this attachment?'),
                                        content: SingleChildScrollView(
                                          child: Row(
                                            children: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<BusinessBloc>(
                                                          context)
                                                      .add(
                                                    DeleteBusinessAttachmentEvent(
                                                      id: profileData!
                                                          .attachments![index]
                                                          .id,
                                                    ),
                                                  );
                                                  Navigator.pop(context, 'Ok');
                                                },
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Your application is already ${profileData!.status}! Please contact us to update.'),
                                      duration: Duration(seconds: 1),
                                    ));
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.white,
                                ),
                                label: Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                              ),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: const Icon(
                              //     Icons.delete_forever_rounded,
                              //     color: Colors.redAccent,
                              //   ),
                              // ),
                              const SizedBox(height: 20),
                              const Divider(
                                color: Colors.black,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text(
                      "No attachment submitted",
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
