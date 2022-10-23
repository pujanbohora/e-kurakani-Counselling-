import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/presentation/widgets/app_loading_widget.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/features/appointment/upcoming_appointment/data/model/upcoming_appointment_response_model.dart';
import 'package:frontend/features/appointment/upcoming_appointment/presentation/bloc/upcoming_appointment/upcoming_appointment_bloc.dart';
import 'package:frontend/features/auth/sign_up/data/data_sources/sign_up_local_data_sources.dart';
import 'package:frontend/features/auth/sign_up/data/model/user_model.dart';
import 'package:frontend/injectable.dart';
import 'appointment_details.dart';

class AppointmentsList extends StatefulWidget {
  UserModel? userModel;
  AppointmentsList({Key? key, this.userModel}) : super(key: key);

  @override
  State<AppointmentsList> createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  final approveSnackBar = SnackBar(
    content: const Text(
      'Hi, You have approved',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    backgroundColor: (Colors.white),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );

  @override
  void initState() {
    BlocProvider.of<UpcomingAppointmentBloc>(context)
        .add(GetUpcomingAppointmentEvent());
    super.initState();
  }

  var signUpLocalDataSource = getIt<SignUpLocalDataSource>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: appBar(
          noBackButton: true, navTitle: "Appointments", backNavigate: () {}),
      body: SingleChildScrollView(
        child: BlocBuilder<UpcomingAppointmentBloc, UpcomingAppointmentState>(
          builder: (context, state) {
            if (state is GetUpcomingAppointmentLoadedState) {
              return state.upcomingResponseData.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          bottom: (size.height * 0.1), left: 20, right: 20),
                      child: Column(
                        children: List.generate(
                          state.upcomingResponseData.length,
                          (index) {
                            return _buildAppointmentCard(
                              state.upcomingResponseData[index],
                            );
                          },
                        ),
                      ),
                    )
                  : const Center(child: Text('No Appointments Found'));
            } else if (state is GetUpcomingAppointmentFailedState) {
              return const Center(
                child: Text('No Appointments Found'),
              );
            } else {
              return AppLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(
      UpcomingAppointmentResponseModel appointmentData) {
    return GestureDetector(
      onTap: () async {
        UserModel? userInfo =
            await signUpLocalDataSource.getUserDataFromLocal();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AppointmentDetails(
            appointmentData: appointmentData,
            userData: userInfo,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        width: double.infinity,
        child: Card(
          shadowColor: Colors.black,
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/images/counsellor_profile_image.jpeg"),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointmentData.user!.details!.full_name != null
                          ? appointmentData.user!.details!.full_name!
                          : "N/A",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      appointmentData.time != null
                          ? appointmentData.time!
                          : "N/A",
                    ),
                    Text(
                      appointmentData.date != null
                          ? appointmentData.date!
                          : "N/A",
                    ),
                    Text(
                      appointmentData.user!.details!.contact_number != null
                          ? appointmentData.user!.details!.contact_number!
                          : "N/A",
                    ),
                    widget.userModel!.user_role == 'Business'
                        ? Text(
                            "Requested Counsellor: ${appointmentData.counsellor!.user!.details!.full_name}",
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
