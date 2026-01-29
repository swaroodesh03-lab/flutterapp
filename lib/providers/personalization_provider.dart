import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalizationState {
  final String name;
  final String gender;
  final String skinTone;
  final String hairStyle;
  final String hairColor;
  final bool hasGlasses;
  final String dedication;

  PersonalizationState({
    this.name = '',
    this.gender = 'Boy',
    this.skinTone = 'Light',
    this.hairStyle = 'Short',
    this.hairColor = 'Black',
    this.hasGlasses = false,
    this.dedication = '',
  });

  PersonalizationState copyWith({
    String? name,
    String? gender,
    String? skinTone,
    String? hairStyle,
    String? hairColor,
    bool? hasGlasses,
    String? dedication,
  }) {
    return PersonalizationState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      skinTone: skinTone ?? this.skinTone,
      hairStyle: hairStyle ?? this.hairStyle,
      hairColor: hairColor ?? this.hairColor,
      hasGlasses: hasGlasses ?? this.hasGlasses,
      dedication: dedication ?? this.dedication,
    );
  }
}

class PersonalizationNotifier extends StateNotifier<PersonalizationState> {
  PersonalizationNotifier() : super(PersonalizationState());

  void setName(String name) => state = state.copyWith(name: name);
  void setGender(String gender) => state = state.copyWith(gender: gender);
  void setSkinTone(String skinTone) => state = state.copyWith(skinTone: skinTone);
  void setHairStyle(String hairStyle) => state = state.copyWith(hairStyle: hairStyle);
  void setHairColor(String hairColor) => state = state.copyWith(hairColor: hairColor);
  void setHasGlasses(bool hasGlasses) => state = state.copyWith(hasGlasses: hasGlasses);
  void setDedication(String dedication) => state = state.copyWith(dedication: dedication);
}

final personalizationProvider = StateNotifierProvider<PersonalizationNotifier, PersonalizationState>((ref) {
  return PersonalizationNotifier();
});
