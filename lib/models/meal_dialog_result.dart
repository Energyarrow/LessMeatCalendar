import 'meal_type.dart';

enum MealDialogAction {
  select,
  delete,
  cancel,
}

class MealDialogResult {
  final MealDialogAction action;
  final List<MealType>? mealTypes;

  const MealDialogResult.select(this.mealTypes)
      : action = MealDialogAction.select;

  const MealDialogResult.delete()
      : action = MealDialogAction.delete,
        mealTypes = null;

  const MealDialogResult.cancel()
      : action = MealDialogAction.cancel,
        mealTypes = null;
}