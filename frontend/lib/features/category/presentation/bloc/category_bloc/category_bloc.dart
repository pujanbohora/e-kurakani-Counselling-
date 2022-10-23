// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frontend/features/category/data/data_source/delete_category_remote_data_source.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:frontend/core/error/errors.dart';
import 'package:frontend/core/use_cases/use_cases.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/usecases/add_category_usecase.dart';
import 'package:frontend/injectable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  var addCategoryUsecase = getIt<AddcategoryUsecase>();

  var getCategoryUsecase = getIt<GetCategoryUsecase>();
  var getSubCategoryUsecase = getIt<GetSubCategoryUsecase>();

  CategoryBloc(this.addCategoryUsecase, this.getCategoryUsecase)
      : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddCategoryEvent>(
      (event, emit) async {
        print('object');
        emit(AddCategoryLoadingState());
        final isSuccessful =
            await addCategoryUsecase.call(event.addCategoryEntity);

        print("thi is Unhandled Exception: UnimplementedError");

        print(isSuccessful);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(AddcategoryFailedState());
          } else if (l is CacheFailure) {
            emit(AddcategoryFailedState());
          }
        }, (r) {
          emit(AddcategoryLoadedState());
        });
        // emit(CategorMiddleState());
      },
    );

    on<GetCategoryEvent>(
      (event, emit) async {
        print('object');
        emit(GetCategoryLoadingState());
        final isSuccessful = await getCategoryUsecase.call(NoParams());
        // addCategoryUsecase.call(event.addCategoryEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetcategoryFailedState());
          } else if (l is CacheFailure) {
            emit(GetcategoryFailedState());
          }
        }, (r) {
          emit(GetcategoryLoadedState(getCategoryData: r));
        });
        // emit(CategorMiddleState());
      },
    );

    on<GetSubCategoryEvent>(
      (event, emit) async {
        emit(GetSubCategoryLoadingState());
        final isSuccessful = await getSubCategoryUsecase.call(NoParams());
        // addCategoryUsecase.call(event.addCategoryEntity);

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetSubCategoryFailedState());
          } else if (l is CacheFailure) {
            emit(GetSubCategoryFailedState());
          }
        }, (r) {
          emit(GetSubCategoryLoadedState(getCategoryData: r));
        });
        // emit(CategorMiddleState());
      },
    );
  }
}

class SubCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  var getSubCategoryUsecase = getIt<GetSubCategoryUsecase>();

  SubCategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetSubCategoryEvent>(
      (event, emit) async {
        emit(GetSubCategoryLoadingState());
        final isSuccessful = await getSubCategoryUsecase.call(NoParams());

        isSuccessful.fold((l) {
          if (l is ServerFailure) {
            emit(GetSubCategoryFailedState());
          } else if (l is CacheFailure) {
            emit(GetSubCategoryFailedState());
          }
        }, (r) {
          emit(GetSubCategoryLoadedState(getCategoryData: r));
        });
        // emit(CategorMiddleState());
      },
    );
  }
}

class DeleteCategoryBloc
    extends Bloc<CategoryEvent, CategoryState> {
  var deleteCategoryRemoteDataSource = getIt<DeleteCategoryRemoteDataSource>();
  DeleteCategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<DeleteCategory>(
      (event, emit) async {
        try {
          print('object');
          emit(DeleteCategoryLoadingState());
          final isSuccessful =
              await deleteCategoryRemoteDataSource.deleteCategory(event.id);

          emit(DeleteCategoryLoadedState());
        } catch (e) {
          emit(DeleteCategoryFailedState());
        }
      },
    );
  }
}
