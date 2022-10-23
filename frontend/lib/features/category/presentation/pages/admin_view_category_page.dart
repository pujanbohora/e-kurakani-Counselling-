// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:frontend/features/category/presentation/pages/add_category/view/add_category_page.dart';
import 'package:frontend/features/category/presentation/pages/add_category/view/update_category_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ViewCategoryScreen extends StatefulWidget {
  const ViewCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ViewCategoryScreen> createState() => _ViewCategoryScreenState();
}

class _ViewCategoryScreenState extends State<ViewCategoryScreen> {
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
      appBar: AppBar(
        title: const Text(
          "Category",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color(0xffE4F2F7),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCategoryScreen()),
                );
              },
              child: const Icon(
                Icons.add_box_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        ],
      ),
      // appBar(
      //     noBackButton: true,
      //     navTitle: 'Category',
      //     appBarBackgroupColor: CustomColors.white,
      //     textColor: CustomColors.black,
      //     iconColor: CustomColors.primaryBlue,
      //     settingIcon: Icon(Icons.add_a_photo, size: 20,),
      //     backNavigate: () {
      //       Navigator.pop(context);
      //     }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              print("hello why not category");
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
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           CreateRequestSubCategoryViewScreen(
                                //             subCategoryListData: state
                                //                 .getCategoryData[index]
                                //                 .children!,
                                //           )),
                                // );
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
                                      child: Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: PopupMenuButton(
                                                  offset: Offset.zero,
                                                  // iconSize: 10,
                                                  itemBuilder: (context) => [
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            BlocProvider.of<
                                                                        DeleteCategoryBloc>(
                                                                    context)
                                                                .add(DeleteCategory(
                                                                    id: state
                                                                            .getCategoryData[index]
                                                                            .id ??
                                                                        ""));
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 1),
                                                                () {
                                                              BlocProvider.of<
                                                                          CategoryBloc>(
                                                                      context)
                                                                  .add(
                                                                      GetCategoryEvent());
                                                            });
                                                          },
                                                          child: Text("Delete"),
                                                          value: 1,
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () {
                                                            print(
                                                                "please navigate");
                                                            // pushNewScreen(
                                                            //   context,
                                                            //   screen:
                                                            //       UpdateCategoryScreen(),
                                                            //   withNavBar: true,
                                                            //   pageTransitionAnimation:
                                                            //       PageTransitionAnimation
                                                            //           .cupertino,
                                                            // );
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //       builder:
                                                            //           (context) =>
                                                            //               UpdateCategoryScreen()),
                                                            // );
                                                          },
                                                          // ignore: sort_child_properties_last
                                                          child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          UpdateCategoryScreen(
                                                                              categoryId: state.getCategoryData[index].id ?? "")),
                                                                );
                                                              },
                                                              child: const Text(
                                                                  "Update")),
                                                          value: 2,
                                                        )
                                                      ]),
                                            ),
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage: state
                                                          .getCategoryData[
                                                              index]
                                                          .image !=
                                                      null
                                                  ? NetworkImage(state
                                                      .getCategoryData[index]
                                                      .image!)
                                                  : const AssetImage(
                                                      "assets/images/counsellor_profile_image.jpeg",
                                                    ) as ImageProvider,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              ),
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
