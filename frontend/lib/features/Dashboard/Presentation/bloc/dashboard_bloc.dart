// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/features/Dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:frontend/features/Dashboard/data/model/business_dashboard_response_model.dart';
import 'package:frontend/features/Dashboard/data/model/counsellor_dashboard_response_model.dart';
import 'package:frontend/features/Dashboard/data/model/customer_dashboard_response_model.dart';
import 'package:frontend/features/category/data/data_source/delete_category_remote_data_source.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/usecases/add_category_usecase.dart';
import 'package:frontend/injectable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  var getDashboarData = getIt<DashboardRemoteDataSource>();
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetCustomerDashboardEvent>(
      (event, emit) async {
        try {
          emit(CustomerDashboardLoadingState());
          final isSuccessful = await getDashboarData.getCustomerDashboard();
          emit(
            CustomerDashboardLoadedState(
              customerDashboardData: isSuccessful,
            ),
          );
        } catch (e) {
          emit(CustomerDashboardFailedState());
        }
      },
    );
    on<GetBusinessDashboardEvent>(
      (event, emit) async {
        try {
          emit(BusinessDashboardLoadingState());
          final isSuccessful = await getDashboarData.getBusinessDashboard();
          print("Inside bloc $isSuccessful");
          emit(
            BusinessDashboardLoadedState(
              businessDashboardData: isSuccessful,
            ),
          );
        } catch (e) {
          print("ERROR ERROR $e");
          emit(BusinessDashboardFailedState());
        }
      },
    );
    on<GetCounsellorDashboardEvent>(
      (event, emit) async {
        try {
          emit(CounsellorDashboardLoadingState());
          final isSuccessful = await getDashboarData.getCounsellorDashboard();
          emit(
            CounsellorDashboardLoadedState(
              counsellorDashboardData: isSuccessful,
            ),
          );
        } catch (e) {
          emit(CounsellorDashboardFailedState());
        }
      },
    );
  }
}
