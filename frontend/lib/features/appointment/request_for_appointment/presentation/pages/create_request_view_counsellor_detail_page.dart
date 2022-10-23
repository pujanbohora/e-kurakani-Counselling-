// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/widgets/time_grid_widget.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/features/profiles/data/model/counsellor_profile_model.dart';
import 'package:frontend/features/report/domain/entities/counsellor_feedback_entities.dart';
import 'package:frontend/features/report/domain/entities/report_entity.dart';
import 'package:frontend/features/report/presentation/bloc/feedback_bloc/counsellor_feedback_bloc.dart';
import 'package:frontend/features/report/presentation/bloc/report_bloc/report_bloc.dart';
import 'package:frontend/injectable.dart';
import 'package:rating_dialog/rating_dialog.dart';

class CreateRequestViewCounsellorDetailScreen extends StatefulWidget {
  final CounsellorProfileModel? counsellorData;

  CreateRequestViewCounsellorDetailScreen({Key? key, this.counsellorData})
      : super(key: key);

  @override
  State<CreateRequestViewCounsellorDetailScreen> createState() =>
      _CreateRequestViewCounsellorDetailScreenState();
}

class _CreateRequestViewCounsellorDetailScreenState
    extends State<CreateRequestViewCounsellorDetailScreen> {
  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  void _showRatingDialog() {
    final _dialog = RatingDialog(
      initialRating: 1.0,
      title: const Text(
        'How was your experience?',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: Image.asset("assets/images/LOGO.png"),
      submitButtonText: 'Submit',
      commentHint: 'Give us your feedback.',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        BlocProvider.of<CounsellorFeedbackBloc>(context).add(
          SaveCounsellorFeedbackEvent(
            counsellorData: CounsellorFeedbackEntities(
                counsellor:
                    CounsellorProfileModel(id: widget.counsellorData!.id),
                feedback_for: "counsellor",
                star: response.rating,
                message: response.comment),
          ),
        );
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _dialog,
    );
  }

  final TextEditingController _reportTitleController = TextEditingController();
  final TextEditingController _reportDesController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 300,
              height: 170,
              child: Column(children: [
                CustomTextField(
                  textController: _reportTitleController,
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
                    labelText: 'Title',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  // attribute: 'name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  maxLines: 4,
                  textController: _reportDesController,
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
                    labelText: 'Description',
                    contentPadding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                  ),
                  // attribute: 'name',
                ),
              ]),
            ),
            title: Text('Report'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                  _reportTitleController.clear();
                  _reportDesController.clear();
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () async {
                  BlocProvider.of<ReportBloc>(context).add(
                    AddCounsellorReportEvent(
                      reportEntity: ReportEntity(
                          counsellor: CounsellorProfileModel(
                              id: widget.counsellorData!.id),
                          report_for: 'counsellor',
                          title: _reportTitleController.text,
                          description: _reportDesController.text),
                    ),
                  );
                  _reportTitleController.clear();
                  _reportDesController.clear();

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CounsellorFeedbackBloc, CounsellorFeedbackState>(
      listener: (context, state) {
        // if (state is CounsellorFeedbackLoadedState) {
        //   const SnackBar(
        //     content: Text(
        //       'Feedback has beed submited',
        //     ),
        //     duration: Duration(seconds: 1),
        //   );
        // } else if (state is CounsellorFeedbackFailedState) {
        //   const SnackBar(
        //     content: Text(
        //       'Error!! Please try again',
        //     ),
        //     duration: Duration(seconds: 1),
        //   );
        // }

        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: const Color(0xffE4F2F7),
            appBar: appBar(
                noBackButton: false,
                navTitle: 'Counsellor Detail',
                appBarBackgroupColor: CustomColors.white,
                textColor: CustomColors.black,
                iconColor: CustomColors.primaryBlue,
                backNavigate: () {
                  Navigator.pop(context);
                }),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: (size.height * 0.3)),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: CustomColors.white,
                            ),
                            borderRadius: BorderRadius.circular(
                              8,
                            )),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: widget.counsellorData!.user!
                                                  .details!.profile_image !=
                                              null
                                          ? NetworkImage(widget.counsellorData!
                                              .user!.details!.profile_image!)
                                          : const AssetImage(
                                                  "assets/images/i.png")
                                              as ImageProvider,
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.counsellorData!.name != null
                                                ? widget.counsellorData!.name!
                                                : "No name",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: CustomColors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        "blackTextSemiBold"),
                                          ),
                                        ),
                                        PopupMenuButton(
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () {
                                                        _showRatingDialog();
                                                      },
                                                      child: const Text(
                                                        'Feedbacks',
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    child: InkWell(
                                                      onTap: () {
                                                        _displayTextInputDialog(
                                                            context);
                                                      },
                                                      child: const Text(
                                                        'Report',
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    // RatingBar.builder(
                                    //   itemSize: 20,
                                    //   initialRating: 2,
                                    //   minRating: 1,
                                    //   direction: Axis.horizontal,
                                    //   allowHalfRating: true,
                                    //   itemCount: 4,
                                    //   itemPadding: const EdgeInsets.symmetric(
                                    //       horizontal: 1.0),
                                    //   itemBuilder: (context, _) => const Icon(
                                    //     Icons.star,
                                    //     color: Colors.amber,
                                    //   ),
                                    //   onRatingUpdate: (rating) {
                                    //     print(rating);
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        widget.counsellorData!.user!.email!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: "blackTextLight"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    // SizedBox(
                                    //   child: Text(
                                    //     "ENT specialist Harvard College Hospital",
                                    //     maxLines: 2,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     softWrap: false,
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .headline2!
                                    //         .copyWith(
                                    //             color: Colors.black,
                                    //             fontSize: 13,
                                    //             fontFamily: "blackTextLight"),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.0001,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About Counsellor",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 18,
                                        color: CustomColors.black)),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              widget.counsellorData!.user!.details!.bio ??
                                  "N/A",
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: const Color.fromARGB(
                                        255, 165, 162, 157),
                                    fontSize: 14,
                                  ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.0),
                              child: Text(
                                'Available Times',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 18,
                                        color: CustomColors.black),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            TimeGrid(
                                timeTableModel:
                                    widget.counsellorData!.available_times,
                                counsellorId: widget.counsellorData!.id!,
                                requested_by:
                                    widget.counsellorData!.user!.details!.id!,
                                price: widget.counsellorData!.price ?? 0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
