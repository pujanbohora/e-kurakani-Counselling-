// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/appointment/request_for_appointment/domain/entities/category_counsellor_response.dart';

import 'create_request_view_counsellor_detail_page.dart';

class CreateRequestViewCounsellorScreen extends StatelessWidget {
  final CategoryCounsellorResponse? categoryCounsellorResponse;
  const CreateRequestViewCounsellorScreen(
      {Key? key, this.categoryCounsellorResponse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false,
          navTitle: 'Counsellors',
          appBarBackgroupColor: CustomColors.white,
          textColor: CustomColors.black,
          iconColor: CustomColors.primaryBlue,
          backNavigate: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: (size.height * 0.1), left: 20, right: 20),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryCounsellorResponse!.counsellors!.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: categoryCounsellorResponse!
                                                .counsellors![index]
                                                .user!
                                                .details!
                                                .profile_image !=
                                            null
                                        ? NetworkImage(
                                            categoryCounsellorResponse!
                                                .counsellors![index]
                                                .user!
                                                .details!
                                                .profile_image!)
                                        : const AssetImage(
                                                "assets/images/i.png")
                                            as ImageProvider,
                                    fit: BoxFit.cover)),
                          ),
                          // CircleAvatar(
                          //   radius: 35,
                          //   backgroundImage: AssetImage(categoryCounsellorResponse!
                          //               .counsellors![index]
                          //               .user!
                          //               .details!
                          //               .profile_image !=
                          //           null
                          //       ? categoryCounsellorResponse!
                          //           .counsellors![index]
                          //           .user!
                          //           .details!
                          //           .profile_image!
                          //       : "assets/images/counsellor_profile_image.jpeg"),
                          // ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                        categoryCounsellorResponse!
                                                    .counsellors![index].name !=
                                                null
                                            ? categoryCounsellorResponse!
                                                .counsellors![index].name!
                                            : "N/A",
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                fontSize: 16,
                                                color: CustomColors.black,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                        categoryCounsellorResponse!
                                            .counsellors![index].user!.email!,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                fontSize: 13,
                                                color: CustomColors.black,
                                                overflow:
                                                    TextOverflow.ellipsis)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ActionButton(
                                        background: CustomColors.black,
                                        width: size.width,
                                        height: 40,
                                        borderRadius: 10,
                                        text: Text(
                                          "Details",
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateRequestViewCounsellorDetailScreen(
                                                counsellorData:
                                                    categoryCounsellorResponse!
                                                        .counsellors![index],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
