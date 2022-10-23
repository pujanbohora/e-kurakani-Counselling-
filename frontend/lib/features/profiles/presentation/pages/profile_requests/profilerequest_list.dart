import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/routes/app_navigation.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/features/profiles/presentation/bloc/profile_request/profile_request_bloc.dart';
import 'package:frontend/features/profiles/presentation/pages/profile_requests/displayBusiness_verification.dart';
import 'package:frontend/features/profiles/presentation/pages/profile_requests/displayCounsellor_verification.dart';

class ProfilerequestList extends StatefulWidget {
  const ProfilerequestList({Key? key}) : super(key: key);

  @override
  State<ProfilerequestList> createState() => _ProfilerequestListState();
}

class _ProfilerequestListState extends State<ProfilerequestList> {
  @override
  void initState() {
    BlocProvider.of<ProfileRequestBloc>(context)
        .add(GetCounsellorProfileRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: true,
          navTitle: "Display Profile Request",
          backNavigate: () {}),
      //  AppBar(
      //   title: const Text("Display Profile Request"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: (size.height * 0.1), left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ActionButton(
                        background: CustomColors.black,
                        width: size.width,
                        height: 40,
                        borderRadius: 10,
                        text: Text(
                          "Counsellor Profiles",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ProfileRequestBloc>(context)
                              .add(GetCounsellorProfileRequestEvent());
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
                          "Business Profiles",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ProfileRequestBloc>(context)
                              .add(GetBusinessProfileRequestEvent());
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                width: double.infinity,
                child: BlocBuilder<ProfileRequestBloc, ProfileRequestState>(
                  builder: (context, state) {
                    if (state is GetCounsellorProfileRequestLoadedState) {
                      return buildCounsellorProfileRequests(context, state);
                    } else if (state is CounsellorProfileRequestFailedState) {
                      return const Center(
                        child: Text("Couldn't fetch counsellor profiles"),
                      );
                    } else if (state is GetBusinessProfileRequestFailedState) {
                      return const Center(
                        child: Text("Couldn't fetch business profiles"),
                      );
                    } else if (state is GetBusinessProfileRequestLoadedState) {
                      return buildBusinessProfileRequests(context, state);
                    } else {
                      return AppLoadingWidget();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCounsellorProfileRequests(context, state) {
    return Column(
      children: List.generate(
        state.counsellorProfileRequestsData.length,
        (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayCounsellorVerificationRequest(
                    counsellorProfileData:
                        state.counsellorProfileRequestsData[index],
                  ),
                ),
              );
              // Navigator.pushNamed(
              //     context, Routes.Display_CounsellorVerification);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            state.counsellorProfileRequestsData[index].name !=
                                    null
                                ? state
                                    .counsellorProfileRequestsData[index].name!
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
                      SizedBox(
                        height: 5,
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
                            state.counsellorProfileRequestsData[index].email !=
                                    null
                                ? state
                                    .counsellorProfileRequestsData[index].email!
                                : "N/A",
                            style: const TextStyle(
                                color: CustomColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
                            state.counsellorProfileRequestsData[index].status !=
                                    null
                                ? state.counsellorProfileRequestsData[index]
                                    .status!
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
                        height: 18,
                      ),
                      ActionButton(
                        text: const Text(
                          'Show Details',
                          style: TextStyle(
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DisplayCounsellorVerificationRequest(
                                counsellorProfileData:
                                    state.counsellorProfileRequestsData[index],
                              ),
                            ),
                          );
                        },
                        background: CustomColors.primaryBlue,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildBusinessProfileRequests(context, state) {
    return Column(
      children: List.generate(
        state.businessProfileRequestsData.length,
        (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayBusinessVerificationRequest(
                    businessProfileData:
                        state.businessProfileRequestsData[index],
                  ),
                ),
              );
              // Navigator.pushNamed(
              //     context, Routes.Display_CounsellorVerification);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Name:",
                            style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            state.businessProfileRequestsData[index].name !=
                                    null
                                ? state.businessProfileRequestsData[index].name!
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
                      SizedBox(
                        height: 5,
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
                            state.businessProfileRequestsData[index].email !=
                                    null
                                ? state
                                    .businessProfileRequestsData[index].email!
                                : "N/A",
                            style: const TextStyle(
                                color: CustomColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
                            state.businessProfileRequestsData[index].status !=
                                    null
                                ? state
                                    .businessProfileRequestsData[index].status!
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
                        height: 18,
                      ),
                      ActionButton(
                        text: const Text(
                          'Show Details',
                          style: TextStyle(
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DisplayBusinessVerificationRequest(
                                businessProfileData:
                                    state.businessProfileRequestsData[index] ??
                                        0,
                              ),
                            ),
                          );
                        },
                        background: CustomColors.primaryBlue,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
