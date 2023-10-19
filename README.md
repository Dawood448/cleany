# cleany
Project Name: Cleany
Language: Flutter & Dart
Version:  Channel stable, 2.8.1,
Xcode: develop for iOS and macOS (Xcode 13.2.1)
Android SDK : Android SDK version 32.0.0


Project Details: 
State Management Method: Provider

Project Structure: 
1. API Calling: lib/apis/request_apis.dart

2. Authentication: 
  2.1: When a user does SignUp a token is returned form Api, That token is then saved in
   Shared Preference. Everytime a user opens the app,  shared preference is checked for
   token. If token is null, the user has to login form new token.
   location: lib/auth/auth.dart
   
3. Models: lib/models
   3.1: All the data from api is sent to map against the models.
   3.2: Models are created following null safety. The variables from the model is nullable.
   
4. Providers: lib/providers
   4.1: All the providers are declared in the folder.
   
5. Routes: lib/routes
   5.1: Class files are declared in the route file.
   
6. Screens: lib/screens 
   6.1: All the designs are implemented in stateful class and the files are 
   located in Screens folder.
   6.2: In the loading screen, the providers are initialized.
   
7. Widgets: lib/widgets 
   7.1: Some of the widgets from the screens are done in the widget folder. 
   the files are named according to the task they will perform.
   
8. App.Dart: All the providers are initialized in the app.dart file. whenever 
   a new provider is created, it has to be initialized here. 
   
