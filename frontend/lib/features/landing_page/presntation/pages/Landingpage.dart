// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../bloc/landing_bloc.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final parentCategoryList = [
    'Admin Dashboard',
    'General Dashboard',
    'Counsellor Dashboard',
    'Business Dashboard',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Landing'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemBuilder: (context, index) {
                final parentCat = parentCategoryList[index];
                return BlocBuilder<LandingToggleBloc,
                    LandingToggleModelForBloc>(
                  builder: (context, landingToggle) {
                    return ElevatedButton(
                      onPressed: () => context.read<LandingToggleBloc>().emit(
                            LandingToggleModelForBloc(position: index),
                          ),
                      style: landingToggle.position == index
                          ? ElevatedButton.styleFrom(primary: Colors.blueGrey)
                          : ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                            ),
                      child: Text(parentCat),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: parentCategoryList.length,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: BlocBuilder<LandingToggleBloc, LandingToggleModelForBloc>(
              builder: (context, landingToggle) {
                Widget widget = adminDashboard();
                if (landingToggle.position == 0) {
                  widget = adminDashboard();
                } else if (landingToggle.position == 1) {
                  widget = generalDashboard();
                } else if (landingToggle.position == 2) {
                  widget = counsellorDashboard();
                } else if (landingToggle.position == 3) {
                  widget = businessDashboard();
                }
                return Center(
                  child: widget,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

adminDashboard() {
  return const Text('This is Admin Dashboard ');
}

generalDashboard() {
  return const Text('This is General Dashboard ');
}

counsellorDashboard() {
  return const Text('This is Counsellor Dashboard ');
}

businessDashboard() {
  return const Text('This is Business Dashboard ');
}
