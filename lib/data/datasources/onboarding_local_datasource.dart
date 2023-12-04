import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDatasource {
  Future<void> saveOnboadingPassed() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('onboarding_passed', true);
  }

  Future<bool> getOnboadingPassed() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('onboarding_passed') ?? false;
  }
}