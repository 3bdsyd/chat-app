class TextUtils {
  static const String appName = 'PLUTO MOVIE';
  static const String splashScreen = '/';
  static const String signUpScreen = '/SignUpScreen';
  static const String loginScreen = '/LoginScreen';
  static const String homeScreen = '/HomeScreen';
  static const String detailsScreen = '/DetailsScreen';
  static const String signIn = 'sign In';
  static const String login = 'Login';
  static const String signUp = 'Sign Up';

  static const String register = 'Register';
  static const String rememberMe = 'Remember Me';
  static const String nameValid = r'^[a-z A-Z]+$';
  static const String emailValid =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String passwordValid =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String baseUrlImage = 'https://image.tmdb.org/t/p/w500/';
  static const String loginKey = 'loginKey';
}
