import 'package:flutter/material.dart';
import 'package:flutter_application/AppUser.dart';
import 'package:flutter_application/shared_preference.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // get user from shared_preference
  Future<AppUser> getLogginData() => UserPreferences.getToken();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder(
          future: getLogginData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return (snapshot.data.authToken != null)
                      ? DashboardPage()
                      : LoginPage();
                }
                return Container(); // error view
              default:
                return Container(); // error view
            }
          },
        ));
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// once user login, you may set-up token or any key to determine the user state
    UserPreferences.setToken("authToken");
    return Container(
      color: Colors.amber,
    );
  }
}
