import 'dart:convert';
import 'dart:io' as Io;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal1_app/bolcs/category_bloc/category_cubit.dart';
import '../widgets/category_widget_items.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode1 = FocusNode();
  final myController1 = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  // Pick an image
  late XFile? image;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        CategoryCubit cubit = CategoryCubit.get(context);
        return Scaffold(
          body: GridView(

            padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 60),
            children: cubit.categories
                .map((catData) =>
                CategoryItem(
                  catData.id,
                  catData.title,
                  catData.image,
                ))
                .toList(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.playlist_add),
            backgroundColor: Colors.amber,
            key: const Key("Add category"),
            label: const Text("Add Category"),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    image = null;
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(
                            right: -30.0,
                            top: -30.0,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  child: Icon(Icons.close),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  "New Category",
                                  style: TextStyle(fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  focusNode: myFocusNode1,
                                  controller: myController1,
                                  style: const TextStyle(fontSize: 15),
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    labelText: "Category Name",
                                    labelStyle: TextStyle(
                                        color: myFocusNode1.hasFocus
                                            ? Colors.yellow[800]
                                            : Colors.grey),
                                    hintText: "Enter the Category name here",
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey[400]),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  textInputAction:
                                  TextInputAction.next, // Moves focus to next.
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    image = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                  },
                                  child: const Text(
                                      "Pick Category Image\n       From Gallery"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ElevatedButton(
                                    child: const Text("Add"),
                                    onPressed: () {
                                      Widget okButton = TextButton(
                                        child: const Text("OK"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                      if (myController1.text.isEmpty) {
                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: const Text(
                                              "You have to enter Category Name!"),
                                          actions: [
                                            okButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      } else if (cubit.categories
                                          .where((category) =>
                                      category.title ==
                                          myController1.text)
                                          .isEmpty) {
                                        if (image != null) {
                                          List<int> imageBytes =
                                          Io.File(image!.path)
                                              .readAsBytesSync();
                                          String base64Image =
                                          base64Encode(imageBytes);
                                          cubit.addCategoryToDatabase(myController1.text,  base64Image);
                                          myController1.clear();
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushReplacementNamed('homee');
                                        } else {
                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            title: const Text(
                                                "You have to pick an Image!!"),
                                            actions: [
                                              okButton,
                                            ],
                                          );

                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }
                                      } else if (cubit.categories
                                          .where((category) =>
                                      category.title ==
                                          myController1.text)
                                          .isNotEmpty) {
                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: const Text(
                                              "This Category Name Is Already There!"),
                                          content: const Text(
                                              "Try to change category name then press Add."),
                                          actions: [
                                            okButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        );
      },
    );
  }
}
