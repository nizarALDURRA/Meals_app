import './models/category.dart';
import './models/meal.dart';

class DummyData {
  String _getImagePath(String categoryImage) {
    return categoryImage;
  }

  List<Category> getDummyCategories() {
    List<Category> categories = [];
    for (int i = 0; i < _categoryNames.length; i++) {
      categories.add(Category(
        id: (i + 1).toString(),
        title: _categoryNames[i],
        image: _getImagePath(_categoryImages[i]),
      ));
    }
    return categories;
  }

  List<Meal> getDummyMeals() {
    List<Meal> meals = [];
    for (int i = 0; i < _mealNames.length; i++) {
      meals.add(Meal(
        id: (i + 1).toString(),
        title: _mealNames[i],
        image: _mealImages[i],
        affordability: _mealAffordability[i],
        categories: _mealCategories[i],
        complexity: _mealComplexity[i],
        duration: _mealDurations[i].toString(),
        ingredients: _mealIngredients[i],
        isGlutenFree: _mealIsGlutenFree[i],
        isLactoseFree: _mealIsLactoseFree[i],
        isVegan: _mealIsVegan[i],
        isVegetarian: _mealIsVegetarian[i],
        steps: _mealSteps[i],
      ));
    }
    return meals;
  }
}

String _assetsPathCategories = 'assets/images/categories/';
String _assetsPathMeals = 'assets/images/meals/';
List<String> _categoryNames = [
  'Italian',
  'Quick & Easy',
  'Hamburgers',
  'German',
  'Light & Lovely',
  'Exotic',
  'Breakfast',
  'Asian',
  'French',
  'Summer',
];
List<String> _mealNames = [
  'Spaghetti with Tomato Sauce',
  'Toast Hawaii',
  'Classic Hamburger',
  'Wiener Schnitzel',
  'Salad with Smoked Salmon',
  'Delicious Orange Mousse',
  'Pancakes',
  'Creamy Indian Chicken Curry',
  'Chocolate Souffle',
  'Asparagus Salad with Cherry Tomatoes',
];
List<String> _categoryImages = [
  _assetsPathCategories + 'Italian.jpg',
  _assetsPathCategories + 'Quick-Meals.jpg',
  _assetsPathCategories + 'hamburger.jpg',
  _assetsPathCategories + 'german.jpg',
  _assetsPathCategories + 'light & lovely.jpg',
  _assetsPathCategories + 'Exotic.jpg',
  _assetsPathCategories + 'breakfast.jpg',
  _assetsPathCategories + 'asian.jpg',
  _assetsPathCategories + 'French.jpg',
  _assetsPathCategories + 'summer.jpg',
];

List<String> _mealImages = [
  _assetsPathMeals +'spaghetti with tomato.jpg',
  _assetsPathMeals +'toast hawaii.jpg',
  _assetsPathMeals +'hamburg.jpeg',
  _assetsPathMeals +'wiener schnitzel.jpg',
  _assetsPathMeals +'salad with smoked salmon.jpg',
  _assetsPathMeals +'orange-mousse.jpeg',
  _assetsPathMeals +'pancake.jpg',
  _assetsPathMeals +'creamy indian.jpg',
  _assetsPathMeals +'chocolate-souffle.jpg',
  _assetsPathMeals +'asparagus salad.jpg',
];
List<List<String>> _mealIngredients = [
  [
    '4 Tomatoes',
    '1 Tablespoon of Olive Oil',
    '1 Onion',
    '250g Spaghetti',
    'Spices',
    'Cheese (optional)'
  ],
  [
    '1 Slice White Bread',
    '1 Slice Ham',
    '1 Slice Pineapple',
    '1-2 Slices of Cheese',
    'Butter'
  ],
  [
    '300g Cattle Hack',
    '1 Tomato',
    '1 Cucumber',
    '1 Onion',
    'Ketchup',
    '2 Burger Buns'
  ],
  [
    '8 Veal Cutlets',
    '4 Eggs',
    '200g Bread Crumbs',
    '100g Flour',
    '300ml Butter',
    '100g Vegetable Oil',
    'Salt',
    'Lemon Slices'
  ],
  [
    'Arugula',
    'Lamb\'s Lettuce',
    'Parsley',
    'Fennel',
    '200g Smoked Salmon',
    'Mustard',
    'Balsamic Vinegar',
    'Olive Oil',
    'Salt and Pepper'
  ],
  [
    '4 Sheets of Gelatine',
    '150ml Orange Juice',
    '80g Sugar',
    '300g Yoghurt',
    '200g Cream',
    'Orange Peel',
  ],
  [
    '1 1/2 Cups all-purpose Flour',
    '3 1/2 Teaspoons Baking Powder',
    '1 Teaspoon Salt',
    '1 Tablespoon White Sugar',
    '1 1/4 cups Milk',
    '1 Egg',
    '3 Tablespoons Butter, melted',
  ],
  [
    '4 Chicken Breasts',
    '1 Onion',
    '2 Cloves of Garlic',
    '1 Piece of Ginger',
    '4 Tablespoons Almonds',
    '1 Teaspoon Cayenne Pepper',
    '500ml Coconut Milk',
  ],
  [
    '1 Teaspoon melted Butter',
    '2 Tablespoons white Sugar',
    '2 Ounces 70% dark Chocolate, broken into pieces',
    '1 Tablespoon Butter',
    '1 Tablespoon all-purpose Flour',
    '4 1/3 tablespoons cold Milk',
    '1 Pinch Salt',
    '1 Pinch Cayenne Pepper',
    '1 Large Egg Yolk',
    '2 Large Egg Whites',
    '1 Pinch Cream of Tartar',
    '1 Tablespoon white Sugar',
  ],
  [
    'White and Green Asparagus',
    '30g Pine Nuts',
    '300g Cherry Tomatoes',
    'Salad',
    'Salt, Pepper and Olive Oil'
  ],
];
List<List<String>> _mealCategories = [
  ['1', '2'],
  [
    '2',
  ],
  [
    '2',
    '3',
  ],
  [
    '4',
  ],
  [
    '2'
        '5',
    '10',
  ],
  [
    '6',
    '10',
  ],
  [
    '7',
  ],
  [
    '8',
  ],
  [
    '9',
  ],
  [
    '2',
    '5',
    '10',
  ],
];
List<Affordability> _mealAffordability = [
  Affordability.Affordable,
  Affordability.Affordable,
  Affordability.Pricey,
  Affordability.Luxurious,
  Affordability.Luxurious,
  Affordability.Affordable,
  Affordability.Affordable,
  Affordability.Pricey,
  Affordability.Affordable,
  Affordability.Luxurious,
];
List<Complexity> _mealComplexity = [
  Complexity.Simple,
  Complexity.Simple,
  Complexity.Simple,
  Complexity.Challenging,
  Complexity.Simple,
  Complexity.Hard,
  Complexity.Simple,
  Complexity.Challenging,
  Complexity.Hard,
  Complexity.Simple,
];
List<int> _mealDurations = [
  20,
  10,
  45,
  60,
  15,
  240,
  20,
  35,
  45,
  30,
];
List<List<String>> _mealSteps = [
  [
    'Cut the tomatoes and the onion into small pieces.',
    'Boil some water - add salt to it once it boils.',
    'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
    'In the meantime, heaten up some olive oil and add the cut onion.',
    'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
    'The sauce will be done once the spaghetti are.',
    'Feel free to add some cheese on top of the finished dish.'
  ],
  [
    'Butter one side of the white bread',
    'Layer ham, the pineapple and cheese on the white bread',
    'Bake the toast for round about 10 minutes in the oven at 200°C'
  ],
  [
    'Form 2 patties',
    'Fry the patties for c. 4 minutes on each side',
    'Quickly fry the buns for c. 1 minute on each side',
    'Bruch buns with ketchup',
    'Serve burger with tomato, cucumber and onion'
  ],
  [
    'Tenderize the veal to about 2–4mm, and salt on both sides.',
    'On a flat plate, stir the eggs briefly with a fork.',
    'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
    'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
    'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
    'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
    'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
  ],
  [
    'Wash and cut salad and herbs',
    'Dice the salmon',
    'Process mustard, vinegar and olive oil into a dessing',
    'Prepare the salad',
    'Add salmon cubes and dressing'
  ],
  [
    'Dissolve gelatine in pot',
    'Add orange juice and sugar',
    'Take pot off the stove',
    'Add 2 tablespoons of yoghurt',
    'Stir gelatin under remaining yoghurt',
    'Cool everything down in the refrigerator',
    'Whip the cream and lift it under die orange mass',
    'Cool down again for at least 4 hours',
    'Serve with orange peel',
  ],
  [
    'In a large bowl, sift together the flour, baking powder, salt and sugar.',
    'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
    'Heat a lightly oiled griddle or frying pan over medium high heat.',
    'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'
  ],
  [
    'Slice and fry the chicken breast',
    'Process onion, garlic and ginger into paste and sauté everything',
    'Add spices and stir fry',
    'Add chicken breast + 250ml of water and cook everything for 10 minutes',
    'Add coconut milk',
    'Serve with rice'
  ],
  [
    'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
    'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
    'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
    'Place chocolate pieces in a metal mixing bowl.',
    'Place bowl over a pan of about 3 cups hot water over low heat.',
    'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
    'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
    'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
    'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
    'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
    'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
    'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
    'Transfer a little less than half of egg whites to chocolate.',
    'Mix until egg whites are thoroughly incorporated into the chocolate.',
    'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
    'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
    'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
  ],
  [
    'Wash, peel and cut the asparagus',
    'Cook in salted water',
    'Salt and pepper the asparagus',
    'Roast the pine nuts',
    'Halve the tomatoes',
    'Mix with asparagus, salad and dressing',
    'Serve with Baguette'
  ],
];
List<bool> _mealIsGlutenFree = [
  false,
  false,
  false,
  false,
  true,
  true,
  true,
  true,
  true,
  true,
];
List<bool> _mealIsVegan = [
  true,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  true,
];
List<bool> _mealIsVegetarian = [
  true,
  false,
  false,
  false,
  true,
  true,
  true,
  false,
  true,
  true
];
List<bool> _mealIsLactoseFree = [
  true,
  false,
  true,
  false,
  true,
  false,
  false,
  true,
  false,
  true,
];

