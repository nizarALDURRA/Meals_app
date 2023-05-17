import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal1_app/bolcs/meal_bloc/meal_cubit.dart';
import 'dart:io' as Io;
import '../models/meal.dart';

class AddMeal extends StatefulWidget {
  static const routName = 'add_meal';

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  late String categoryId;
  late String categoryTitle;
  late final List<String> categories;
  late Complexity complexity = Complexity.Simple;
  late Affordability affordability = Affordability.Affordable;
  late bool isGlutenFree = false;
  late bool isLactoseFree = false;
  late bool isVegan = false;
  late bool isVegetarian = false;

  FocusNode myFocusNode1 = FocusNode();
  final myController1 = TextEditingController();
  FocusNode myFocusNode2 = FocusNode();
  final myController2 = TextEditingController();
  FocusNode myFocusNode3 = FocusNode();
  final myController3 = TextEditingController();
  FocusNode myFocusNode4 = FocusNode();
  final myController4 = TextEditingController();
  FocusNode myFocusNode5 = FocusNode();
  final myController5 = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  // Pick an image
  late XFile? image;

  String affordabilityValue = 'Affordable';
  String complexityValue = 'Simple';
  List affordabilityList = [
    'Affordable',
    'Pricey',
    'Luxurious',
  ];
  List complexityList = [
    'Simple',
    'Challenging',
    'Hard',
  ];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final routArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    categoryId = routArgs['id'] as String;
    categoryTitle = routArgs['title'] as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealCubit, MealState>(
      builder: (context, state) {
        MealCubit cubit = MealCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Add Meal'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: TextField(
                    focusNode: myFocusNode1,
                    controller: myController1,
                    style: const TextStyle(fontSize: 15),
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Meal Name",
                      labelStyle: TextStyle(
                          color: myFocusNode1.hasFocus
                              ? Colors.yellow[800]
                              : Colors.grey),
                      hintText: "Enter the Meal name here",
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    textInputAction:
                        TextInputAction.next, // Moves focus to next.
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: TextField(
                    focusNode: myFocusNode2,
                    controller: myController2,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      focusColor: Colors.blue,
                      ///////////////////////////////////////////////////////////////////////////
                      labelText: "Meal Description",
                      labelStyle: TextStyle(
                          color: myFocusNode2.hasFocus
                              ? Colors.yellow[800]
                              : Colors.grey),
                      hintText: "Enter the Meal Description here",
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    textInputAction:
                        TextInputAction.next, // Moves focus to next.
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  onPressed: () async {
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                  },
                  child: const Text("Pick Meal Image\n       From Gallery"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Each line is an Ingredient'),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: TextField(
                    focusNode: myFocusNode3,
                    controller: myController3,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    maxLines: null,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      focusColor: Colors.blue,
                      ///////////////////////////////////////////////////////////////////////////
                      labelText: "Ingredients",
                      labelStyle: TextStyle(
                          color: myFocusNode3.hasFocus
                              ? Colors.yellow[800]
                              : Colors.grey),
                      hintText: "Enter the ingredients here",
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Each line is a step'),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: TextField(
                    focusNode: myFocusNode4,
                    controller: myController4,
                    keyboardType: TextInputType.multiline,
                    autofocus: true,
                    maxLines: null,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      focusColor: Colors.blue,
                      ///////////////////////////////////////////////////////////////////////////
                      labelText: "Steps",
                      labelStyle: TextStyle(
                          color: myFocusNode4.hasFocus
                              ? Colors.yellow[800]
                              : Colors.grey),
                      hintText: "Enter the steps here",
                      hintStyle:
                          TextStyle(fontSize: 15.0, color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 70.0, left: 70),
                  child: TextField(
                    focusNode: myFocusNode5,
                    controller: myController5,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 25),
                    autofocus: true,
                    decoration: InputDecoration(
                      ///////////////////////////////////////////////////////////////////////////
                      labelText: "Duration",
                      labelStyle: TextStyle(
                          color: myFocusNode3.hasFocus
                              ? Colors.yellow[800]
                              : Colors.grey),
                      hintText: "Duration by minutes",
                      hintStyle:
                          TextStyle(fontSize: 25.0, color: Colors.grey[400]),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: affordabilityValue,
                  items: affordabilityList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      affordabilityValue = newValue as String;
                      switch (newValue) {
                        case 'Affordable':
                          affordability = Affordability.Affordable;
                          break;
                        case 'Pricey':
                          affordability = Affordability.Pricey;
                          break;
                        case 'Luxurious':
                          affordability = Affordability.Luxurious;
                          break;
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: complexityValue,
                  items: complexityList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      complexityValue = newValue as String;
                      switch (newValue) {
                        case 'Simple':
                          complexity = Complexity.Simple;
                          break;
                        case 'Challenging':
                          complexity = Complexity.Challenging;
                          break;
                        case 'Hard':
                          complexity = Complexity.Hard;
                          break;
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildSwitchListTile(
                  'Gluten-free',
                  'only include gluten-free meals',
                  isGlutenFree,
                  (newValue) {
                    setState(() {
                      isGlutenFree = newValue!;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'only include Lactose-free meals',
                  isLactoseFree,
                  (newValue) {
                    setState(() {
                      isLactoseFree = newValue!;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan-free',
                  'only include Vegan-free meals',
                  isVegan,
                  (newValue) {
                    setState(() {
                      isVegan = newValue!;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian-free',
                  'only include Vegetarian-free meals',
                  isVegetarian,
                  (newValue) {
                    setState(() {
                      isVegetarian = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.playlist_add),
            backgroundColor: Colors.amber,
            key: const Key("Add Meal"),
            label: const Text("Add Meal"),
            onPressed: () {
              Widget okButton = TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
              if (myController1.text.isEmpty ||
                  myController2.text.isEmpty ||
                  myController3.text.isEmpty ||
                  myController4.text.isEmpty ||
                  myController5.text.isEmpty) {
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("You have to fill the all the fields !"),
                  actions: [
                    okButton,
                  ],
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
              if (image != null) {
                List<int> imageBytes = Io.File(image!.path).readAsBytesSync();
                String base64Image = base64Encode(imageBytes);
                cubit.addMealToDatabase(
                  myController1.text,
                  base64Image,
                  affordability,
                  categoryId,
                  complexity,
                  myController5.text.toString(),
                  myController3.text,
                  isGlutenFree,
                  isLactoseFree,
                  isVegan,
                  isVegetarian,
                  myController4.text,
                );

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${myController1.text} meal Created in $categoryTitle Category"),
                  duration: const Duration(seconds: 6),

                ));
                myController1.clear();
                myController2.clear();
                myController3.clear();
                myController4.clear();
                myController5.clear();
              } else {
                print('you have to pick an image');
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool?) updateValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(
          description,
        ),
        onChanged: updateValue);
  }
}
