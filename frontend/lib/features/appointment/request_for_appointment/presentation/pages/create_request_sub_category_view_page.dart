// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/bloc/create_request_bloc/create_request_bloc.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_view_counsellor_page.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';

class CreateRequestSubCategoryViewScreen extends StatelessWidget {
  final List<AddCategoryEntity>? subCategoryListData;
  const CreateRequestSubCategoryViewScreen({Key? key, this.subCategoryListData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: false,
          navTitle: 'Sub Category',
          appBarBackgroupColor: CustomColors.white,
          textColor: CustomColors.black,
          iconColor: CustomColors.primaryBlue,
          backNavigate: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocListener<CreateRequestBloc, CreateRequestState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetCounsellorsCategoryLoadedState) {
              //  Navigator.pushNamed( context,
              //                               Routes
              //                                   .CREATE_REQUEST_VIEW_COUNSELLOR_SCREEN);

              if (state.categoryCounsellorResponse.counsellors!.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateRequestViewCounsellorScreen(
                          categoryCounsellorResponse:
                              state.categoryCounsellorResponse)),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Counsellor found'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            } else if (state is GetCounsellorsCategoryFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  'Error! Try Again',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 1),
              ));
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: (size.height * 0.1), left: 20, right: 20, top: 20),
                child: subCategoryListData!.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: subCategoryListData!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 18,
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, int index) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<CreateRequestBloc>(context).add(
                                  GetCounsellorsCategoryEvent(
                                      subCategoryId:
                                          subCategoryListData![index].id!));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           CreateRequestSubCategoryViewScreen(
                              //             subCategoryListData: subCategoryListData.,
                              //           )),
                              // );
                              // Navigator.pushNamed(
                              //     context,
                              //     Routes
                              //         .CREATE_REQUEST_SUB_CATEGORY_VIEW_SCREEN);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: CustomColors.primaryBlue,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                    subCategoryListData![index]
                                                                .image !=
                                                            null
                                                        ? NetworkImage(
                                                            subCategoryListData![
                                                                    index]
                                                                .image!)
                                                        : const AssetImage(
                                                            "assets/images/counsellor_profile_image.jpeg",
                                                          ) as ImageProvider,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                    subCategoryListData![index]
                                                                .name !=
                                                            null
                                                        ? subCategoryListData![
                                                                index]
                                                            .name!
                                                        : "",
                                                    maxLines: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2!
                                                        .copyWith(
                                                            fontSize: 15,
                                                            color: CustomColors
                                                                .whiteShade,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: GridView.count(
                            crossAxisCount: 1,
                            childAspectRatio: 1,
                            children: <Widget>[
                              Center(
                                  child: Text(
                                'No Sub Category',
                                style: Theme.of(context).textTheme.bodyLarge,
                              )),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
