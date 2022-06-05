import 'package:firebase_analytics/firebase_analytics.dart';

class LogAnalytic {
  static late FirebaseAnalytics instance;

  static Future initialize() async {
    instance = FirebaseAnalytics.instance;
  }

  void appOpen() {
    instance.logAppOpen();
  }

  void productLoad(String prodId) {
    instance.logScreenView(
      screenClass: 'Product Screen Load',
      screenName: prodId,
    );
  }

  void productComplete(String prodName) {
    instance.logScreenView(
      screenClass: 'Product Screen Complete',
      screenName: prodName,
    );
  }

  void search(String? text) {
    instance.logSearch(searchTerm: text ?? '');
  }

  void searchResult(String text) {
    instance.logViewSearchResults(searchTerm: text);
  }

  void homeScreen() {
    instance.logScreenView(
      screenClass: 'Home Screen',
      screenName: 'Home Screen',
    );
  }

  void categoryScreen1() {
    instance.logScreenView(
      screenClass: 'Category Screen 1',
    );
  }

  void categoryScreen2(String catName) {
    instance.logScreenView(
      screenClass: 'Category Screen 2',
      screenName: catName,
    );
  }

  void categoryScreen3(String catId) {
    instance.logScreenView(
      screenClass: 'Product in Category Screen',
      screenName: catId,
    );
  }

  void cartScreen1() {
    instance.logScreenView(screenClass: 'Cart', screenName: 'Cart Step 1');
    instance.logViewCart();
  }

  void cartScreen2() {}

  void beginCheckOut() {
    instance.logBeginCheckout();
  }

  void signUpScreen() {
    instance.logScreenView(screenClass: 'Panel', screenName: 'SignUp Screen');
  }

  void loginScreen() {
    instance.logScreenView(screenClass: 'Panel', screenName: 'Login Screen');
  }

  void signUp(String signMethod) {
    instance.logSignUp(signUpMethod: signMethod);
  }

  void login(String loginMethod) {
    instance.logLogin(loginMethod: loginMethod);
  }

  void sivanScreen() {
    instance.logScreenView(
      screenClass: 'My Sivan Screen',
      screenName: 'My Sivan Screen',
    );
  }

  void addToCart(
    String name,
    String id,
    int quantity,
    int price,
    String cat0,
    String cat1,
    String cat2,
  ) {
    instance.logAddToCart(
      items: [
        AnalyticsEventItem(
          itemName: name,
          itemId: id,
          quantity: quantity,
          price: price,
          itemCategory: cat0,
          itemCategory2: cat1,
          itemCategory3: cat2,
        ),
      ],
    );
  }

  void paymentSuccess() {}

  void paymentFail() {}
}
