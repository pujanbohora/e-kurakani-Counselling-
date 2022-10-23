import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/profiles/domain/entities/profile_attachment.dart';
import 'package:frontend/features/profiles/presentation/bloc/counsellor_bloc/counsellor_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CounsellorAttachmentUploadScreen extends StatefulWidget {
  final String? counsellorId;
  const CounsellorAttachmentUploadScreen({Key? key, required this.counsellorId})
      : super(key: key);

  @override
  State<CounsellorAttachmentUploadScreen> createState() =>
      _CounsellorAttachmentUploadScreenState();
}

class _CounsellorAttachmentUploadScreenState
    extends State<CounsellorAttachmentUploadScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  String fileName = '';
  File? file;

  // Future pickImage() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();

  //     if (result != null) {
  //       file = File(result.files.single.path!);
  //       print(file);
  //       print("this is the type of file");
  //     } else {
  //       // User canceled the picker
  //     }
  //   } on PlatformException catch (e) {
  //     print("Failed to pick image $e");
  //   }
  // }

  // void _openFileExplorer() async {
  //   if (_pickingType != FileType.custom || _hasValidMine) {
  //     setState(() => _loadingPath = true);
  //     try {
  //       if (_multiPick) {
  //         _path = null;
  //         _paths = await FilePicker.platform
  //             .pickFiles(allowMultiple: true, type: _pickingType);
  //       }
  //     } catch (e) {}
  //   }
  // }

  // clearTextField() {
  //   file!.writeAsString("");
  //   _nameController.clear();
  //   _remarksController.clear();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<CounsellorBloc, CounsellorState>(
        listener: (context, state) {
          if (state is CounsellorAttachmentLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Attachment Submitted!'),
                duration: Duration(seconds: 1),
              ),
            );
            Navigator.pushNamed(context, Routes.APPLY_COUNSELLOR_BUTTON);
          }
          if (state is CounsellorAttachmentFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error!'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
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

                          Text("Label",
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
                          Text("Remarks",
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            height: size.height * 0.01,
                          ),

                          CustomTextField(
                            textController: _remarksController,
                            maxLines: 7,
                            borderColor: CustomColors.black,
                            validator: FormBuilderValidators.required(
                                errorText: 'Reason for request is required'),
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
                            attribute: 'text',
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),

                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                file = File(result.files.single.path!);
                                print(result.files.first.name);
                                setState(() {
                                  fileName = result.files.first.name;
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
                          Text(fileName),

                          //Button
                          const SizedBox(
                            height: 20,
                          ),

                          ActionButton(
                              background: CustomColors.primaryBlue,
                              width: size.width,
                              height: 50,
                              borderRadius: 10,
                              text: Text(
                                "Apply for Verification",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              onPressed: () async {
                                print(file);
                                print(_nameController.text);
                                print(_remarksController.text);
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<CounsellorBloc>(context).add(
                                    AddCounsellorAttachmentEvent(
                                      attachmentEntity: ProfileAttachments(
                                        label: _nameController.text,
                                        remarks: _remarksController.text,
                                        fileData: file,
                                        counsellor_profile:
                                            CounsellorProfileModel(
                                          id: widget.counsellorId,
                                        ),
                                      ),
                                    ),
                                  );
                                  // clearTextField();

                                  // Navigator.pushNamed(
                                  //     context,
                                  //     Routes
                                  //         .CREATE_REQUEST_REQUEST_FOR_APPOINTMENT_VIEW_SCREEN);
                                }
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
