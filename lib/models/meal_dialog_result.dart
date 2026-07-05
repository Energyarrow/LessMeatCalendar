import 'meal_type.dart';

enum MealDialogAction {
  select,
  delete,
  cancel,
}

class MealDialogResult {
  final MealDialogAction action;
  final MealType? mealType;

  const MealDialogResult.select(this.mealType)
      : action = MealDialogAction.select;

  const MealDialogResult.delete()
      : action = MealDialogAction.delete,
        mealType = null;

  const MealDialogResult.cancel()
      : action = MealDialogAction.cancel,
        mealType = null;
}