part of 'category_bloc.dart';

@immutable
abstract class CategoryState extends Equatable {}

class CategoryInitial extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CategorMiddleState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddCategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddcategoryLoadedState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AddcategoryFailedState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetCategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetcategoryLoadedState extends CategoryState {
  final List<AddCategoryEntity> getCategoryData;

  GetcategoryLoadedState({required this.getCategoryData});
  @override
  // TODO: implement props
  List<Object> get props => [getCategoryData];
}

class GetcategoryFailedState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSubCategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSubCategoryLoadedState extends CategoryState {
  final List<AddCategoryEntity> getCategoryData;

  GetSubCategoryLoadedState({required this.getCategoryData});
  @override
  // TODO: implement props
  List<Object> get props => [getCategoryData];
}

class GetSubCategoryFailedState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class DeleteCategoryLoadedState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCategoryFailedState extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}