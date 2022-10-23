// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/appointment/request_for_appointment/presentation/pages/create_request_sub_category_view_page.dart';
import 'package:frontend/features/category/presentation/bloc/category_bloc/category_bloc.dart';

class CreateRequestCategoryViewScreen extends StatefulWidget {
  const CreateRequestCategoryViewScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestCategoryViewScreen> createState() =>
      _CreateRequestCategoryViewScreenState();
}

class _CreateRequestCategoryViewScreenState
    extends State<CreateRequestCategoryViewScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: true,
          navTitle: 'Services',
          appBarBackgroupColor: CustomColors.white,
          textColor: CustomColors.black,
          iconColor: CustomColors.primaryBlue,
          settingIcon: Icon(Icons.abc_rounded),
          backNavigate: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              // print();
              if (state is GetcategoryLoadedState) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: (size.height * 0.1), left: 20, right: 20),
                      child: GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.getCategoryData.length,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateRequestSubCategoryViewScreen(
                                            subCategoryListData: state
                                                .getCategoryData[index]
                                                .children!,
                                          )),
                                );
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
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: state
                                                              .getCategoryData[
                                                                  index]
                                                              .image !=
                                                          null
                                                      ? Image.network(
                                                          state
                                                              .getCategoryData[
                                                                  index]
                                                              .image!,
                                                          width: 100,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/counsellor_profile_image.jpeg",
                                                          width: 100,
                                                        ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    state.getCategoryData[index]
                                                        .name!,
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
                                                                    .ellipsis),
                                                  ),
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
                          }),
                    ),
                  ],
                );
              } else if (state is GetcategoryFailedState) {
                return const Center(
                  child: Text('No Category Found'),
                );
              } else {
                return AppLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
