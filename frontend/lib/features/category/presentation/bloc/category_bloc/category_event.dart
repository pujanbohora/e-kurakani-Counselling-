part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {}

class AddCategoryEvent extends CategoryEvent {
  final AddCategoryEntity addCategoryEntity;

  AddCategoryEvent({required this.addCategoryEntity});

  @override
  // TODO: implement props
  List<Object> get props => [addCategoryEntity];
}

class GetCategoryEvent extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSubCategoryEvent extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DeleteCategory extends CategoryEvent {
  final String id;

  DeleteCategory({required this.id});

  @override
  // TODO: implement props
  List<Object> get props => [id];
}

