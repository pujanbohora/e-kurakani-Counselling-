// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_search_widget.dart';

class CreateRequestGridViewWidget extends StatelessWidget {
  const CreateRequestGridViewWidget(
      {Key? key,
      required this.size,
      this.image,
      required this.title,
      required this.itemCount,
      required this.routeToNavigate,
      required this.index,
      this.searchWidget})
      : super(key: key);

  final Size size;
  final int index;
  final String title;
  final String? image;
  final int itemCount;
  final String routeToNavigate;
  final Widget? searchWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: searchWidget,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: itemCount,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 14,
                crossAxisSpacing: 18,
                crossAxisCount: 2,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, routeToNavigate);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: CustomColors.primaryBlue,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   width: MediaQuery.of(context).size.width - 50 / 2,
                        //   height:
                        //       ((MediaQuery.of(context).size.width - 50) / 2) *
                        //           1,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(6),
                        //       image: DecorationImage(
                        //           image: NetworkImage(image),
                        //           fit: BoxFit.cover)),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(title,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  fontSize: 10,
                                                  color:
                                                      CustomColors.whiteShade,
                                                  overflow:
                                                      TextOverflow.ellipsis)),
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
  }
}
