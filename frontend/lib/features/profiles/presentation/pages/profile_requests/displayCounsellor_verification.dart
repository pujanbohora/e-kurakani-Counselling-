import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:frontend/features/profiles/domain/entities/counsellor_profile.dart';
import 'package:frontend/features/profiles/presentation/bloc/profile_request/profile_request_bloc.dart';
import 'package:frontend/features/profiles/presentation/pages/profile_requests/profilerequest_list.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher_web/url_launcher_web.dart';

class DisplayCounsellorVerificationRequest extends StatefulWidget {
  final CounsellorProfile? counsellorProfileData;
  const DisplayCounsellorVerificationRequest(
      {Key? key, required this.counsellorProfileData})
      : super(key: key);

  @override
  State<DisplayCounsellorVerificationRequest> createState() =>
      _DisplayCounsellorVerificationRequestState();
}

class _DisplayCounsellorVerificationRequestState
    extends State<DisplayCounsellorVerificationRequest> {
  String? dropDownValue;
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _remarksController = TextEditingController();

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false,
          navTitle: "Counsellor Verification",
          backNavigate: () {}),
      // AppBar(
      //   title: const Text("Counsellor Verification"),
      // ),
      body: BlocConsumer<ProfileRequestBloc, ProfileRequestState>(
          listener: (context, state) {
        // print(state);
        if (state is CounsellorProfileRequestLoadedState) {
          // print(state);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Status Changed!'),
            duration: Duration(seconds: 1),
          ));
          pushNewScreen(
            context,
            screen: ProfilerequestList(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
        if (state is CounsellorProfileRequestFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error!'),
            duration: Duration(seconds: 1),
          ));
        }
      }, builder: (context, state) {
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
                              height: 40,
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
                                  widget.counsellorProfileData!.name != null
                                      ? widget.counsellorProfileData!.name!
                                          .toUpperCase()
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
                                  widget.counsellorProfileData!.email != null
                                      ? widget.counsellorProfileData!.email!
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
                                  widget.counsellorProfileData!
                                              .contact_number !=
                                          null
                                      ? widget.counsellorProfileData!
                                          .contact_number!
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
                                  widget.counsellorProfileData!.category != null
                                      ? widget.counsellorProfileData!.category!
                                          .name!
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
                                  widget.counsellorProfileData!.user != null
                                      ? widget.counsellorProfileData!.user!
                                          .user_role!
                                      : "Counsellor",
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
                                  widget.counsellorProfileData!.status != null
                                      ? widget.counsellorProfileData!.status!
                                          .toUpperCase()
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
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Center(
                              child: Text(
                                "Attachments",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Card(
                              elevation: 12,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: widget.counsellorProfileData!
                                        .attachments!.isNotEmpty
                                    ? Column(
                                        children: List.generate(
                                          widget.counsellorProfileData!
                                              .attachments!.length,
                                          (index) {
                                            return InkWell(
                                              onTap: () async {
                                                //image show in browser
                                                Uri uri = Uri.parse(widget
                                                            .counsellorProfileData!
                                                            .attachments![index]
                                                            .file !=
                                                        null
                                                    ? widget
                                                        .counsellorProfileData!
                                                        .attachments![index]
                                                        .file!
                                                    : "");
                                                _launchInBrowser(uri);
                                              },
                                              child: Column(
                                                children: [
                                                  const Icon(
                                                    Icons.file_copy,
                                                    size: 90,
                                                    color: CustomColors
                                                        .primaryBlue,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Name:",
                                                        style: TextStyle(
                                                            color: CustomColors
                                                                .black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        widget
                                                                    .counsellorProfileData!
                                                                    .attachments![
                                                                        index]
                                                                    .label !=
                                                                null
                                                            ? widget
                                                                .counsellorProfileData!
                                                                .attachments![
                                                                    index]
                                                                .label!
                                                            : "N/A",
                                                        style: const TextStyle(
                                                          color: CustomColors
                                                              .black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Remarks:",
                                                        style: TextStyle(
                                                            color: CustomColors
                                                                .black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        widget
                                                                    .counsellorProfileData!
                                                                    .attachments![
                                                                        index]
                                                                    .remarks !=
                                                                null
                                                            ? widget
                                                                .counsellorProfileData!
                                                                .attachments![
                                                                    index]
                                                                .remarks!
                                                            : "N/A",
                                                        style: const TextStyle(
                                                          color: CustomColors
                                                              .black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 40),
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
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: ActionButton(
                                text: const Text(
                                  'Change Status',
                                  style: TextStyle(
                                    color: CustomColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                      context: context,
                                      builder:
                                          (BuildContext context) => AlertDialog(
                                                title:
                                                    const Text('Change Status'),
                                                content: SingleChildScrollView(
                                                    child: FormBuilder(
                                                  key: _formKey,
                                                  child: Column(
                                                    children: [
                                                      DropdownSearch<String>(
                                                        // popupProps: const PopupProps.menu(
                                                        //   showSearchBox: true,
                                                        //   showSelectedItems: true,
                                                        // ),
                                                        items: const [
                                                          "UNDER_REVIEW",
                                                          "APPROVED",
                                                          "DECLINED"
                                                        ],

                                                        // dropdownSearchDecoration:
                                                        //     const InputDecoration(
                                                        //   hintText: "Select Status",
                                                        // ),
                                                        selectedItem:
                                                            dropDownValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            dropDownValue = value!
                                                                .toLowerCase();
                                                          });
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            size.height * 0.03,
                                                      ),
                                                      dropDownValue ==
                                                              'under_review'
                                                          ? Column(children: [
                                                              Text("Remarks",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1),
                                                              SizedBox(
                                                                height:
                                                                    size.height *
                                                                        0.01,
                                                              ),
                                                              CustomTextField(
                                                                textController:
                                                                    _remarksController,
                                                                maxLines: 4,
                                                                borderColor:
                                                                    CustomColors
                                                                        .black,
                                                                // validator: FormBuilderValidators
                                                                //     .required(context,
                                                                //         errorText:
                                                                //             'Reason for request is required'),
                                                                decoration:
                                                                    customFormFieldDecoration
                                                                        .copyWith(
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.black),
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(10.0),
                                                                          )),
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.black),
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(10.0),
                                                                          )),
                                                                  hintText:
                                                                      'Remarks',
                                                                  contentPadding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    bottom: 10,
                                                                    left: 12,
                                                                    right: 12,
                                                                  ),
                                                                ),
                                                                attribute:
                                                                    'text',
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      size.height *
                                                                          0.01),
                                                            ])
                                                          : Container(),
                                                      Row(
                                                        children: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'Cancel'),
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                BlocProvider.of<
                                                                            ProfileRequestBloc>(
                                                                        context)
                                                                    .add(
                                                                  ChangeCounsellorProfileRequestEvent(
                                                                    counsellorProfileEntity:
                                                                        CounsellorProfile(
                                                                      id: widget
                                                                          .counsellorProfileData!
                                                                          .id,
                                                                      remarks:
                                                                          _remarksController
                                                                              .text,
                                                                      status:
                                                                          dropDownValue,
                                                                    ),
                                                                  ),
                                                                );
                                                                Navigator.pop(
                                                                    context,
                                                                    'Ok');

                                                                // Navigator.pushNamed(
                                                                //     context,
                                                                //     Routes
                                                                //         .ProfilerequestList);
                                                              }
                                                            },
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                              ));
                                },
                                background: CustomColors.primaryBlue,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
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
      }),
    );
  }
}
