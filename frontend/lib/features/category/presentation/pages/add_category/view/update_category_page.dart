// Flutter imports:
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frontend/core/network_services/interceptor.dart';
import 'package:frontend/core/network_services/urls/network_info.dart';

// Project imports:
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/utils/validators.dart';
import 'package:frontend/core/widgets/custom_appbar_widget.dart';
import 'package:frontend/core/widgets/custom_button_widget.dart';
import 'package:frontend/core/widgets/custom_form_field_decoration.dart';
import 'package:frontend/core/widgets/custom_text_field.dart';
import 'package:frontend/features/auth/sign_up/presentation/pages/sign_up/widgets/input_field_widget.dart';
import 'package:frontend/features/category/data/model/add_category_model.dart';
import 'package:frontend/features/category/domain/entities/add_category_entities.dart';
import 'package:frontend/features/category/domain/usecases/add_category_usecase.dart';
import 'package:frontend/features/category/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:frontend/injectable.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final String categoryId;
  const UpdateCategoryScreen({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  var addCategoryUsecase = getIt<AddcategoryUsecase>();
  var getCategoryUsecase = getIt<GetCategoryUsecase>();
  final TextEditingController _imageController = TextEditingController();
  Dio dio = Dio();
  File? image;
  // Pick an image
  Future pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      final tempImage = await picker.pickImage(source: ImageSource.camera);
      if (tempImage == null) return;
      final imageTemporary = File(tempImage.path);

      setState(() => {
            image = imageTemporary,
            _imageController.text = tempImage.name,
          });
    } catch (e) {
      print("Failed to pick image $e");
    }
  }

  List<AddCategoryEntity>? parentCategory;

  List itemsValue = ["Error loading"];

  TextEditingController nameController = TextEditingController();
  String? name;

  FocusNode nameFocusNode = FocusNode();

  String? dropDownValue;

  clearTextFiled() {
    nameController.clear();
    _imageController.clear();
  }

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
    super.initState();
  }

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffE4F2F7),
      appBar: AppBar(
        title: const Text(
          "Add Category",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffE4F2F7),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          (state is GetcategoryLoadedState)
              ? parentCategory = state.getCategoryData
              : '';
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: size.height * 0.07, left: 15, right: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    textController: nameController,
                    validator: FormBuilderValidators.required(
                        errorText: 'Category name is required'),
                    decoration: customFormFieldDecoration.copyWith(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                      labelText: 'Business',
                      contentPadding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                      ),
                    ),
                    onChange: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    // keyboardType: ,
                    attribute: 'number',
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                      showSelectedItems: true,
                    ),
                    items: (parentCategory != null)
                        ? parentCategory!.map((item) => item.name!).toList()
                        : [],
                    // dropdownDecoratorProps: const InputDecoration(
                    //   hintText: "Select one",
                    // ),
                    onChanged: (value) {
                      setState(() {
                        int index = parentCategory!
                            .indexWhere((element) => element.name == value!);
                        dropDownValue = parentCategory![index].id;
                      });
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Stack(
                    children: [
                      CustomTextField(
                        enable: false,
                        textController: _imageController,
                        // validator: FormBuilderValidators.required(
                        //     errorText: 'Category name is required'),
                        decoration: customFormFieldDecoration.copyWith(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          labelText: 'Image',
                          hintText: _imageController.text,
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                          ),
                        ),
                        // onChange: (value) {
                        //   setState(() {
                        //     name = value;
                        //   });
                        // },
                        // keyboardType: ,
                        attribute: 'number',
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ActionButton(
                            background: Color(0xFFd5d7db),
                            height: 47,
                            borderRadius: 7,
                            text: const Text(
                              'Upload Image',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: pickImage),
                      ),
                    ],
                  ),

                  // ActionButton(
                  //     text: const Text('Upload Image'), onPressed: pickImage),
                  // Text(_imageController.text),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  // const Spacer(),
                  ActionButton(
                      background: CustomColors.primaryBlue,
                      width: size.width,
                      height: 55,
                      borderRadius: 10,
                      isLoading: isLoading,
                      text: Text(
                        "Update",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        var upateCateogry = AddCategoryEntity(
                          name: nameController.text,
                          parent: dropDownValue,
                          imageData: image,
                        );
                        saveCategory(upateCateogry);
                        clearTextFiled();
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void saveCategory(AddCategoryEntity upateCateogry) async {
    setState(() {
      isLoading = true;
    });

    AddCategoryModel categoryModel = AddCategoryModel(
        name: upateCateogry.name,
        // image: upateCateogry.image,
        parent: upateCateogry.parent);

    var cateogoryToJson = categoryModel.toJson();

    cateogoryToJson.removeWhere((key, value) => value == null);

    var data = jsonEncode(cateogoryToJson);

    final response = await dioClient.patch(
      Urls.ADD_CATEGORY + widget.categoryId + "/",
      data: data,
    );
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Updated!'),
        duration: Duration(seconds: 1),
      ));
      BlocProvider.of<CategoryBloc>(context).add(GetCategoryEvent());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error!'),
        duration: Duration(seconds: 1),
      ));
    }
    setState(() {
      isLoading = false;
    });
  }


}
