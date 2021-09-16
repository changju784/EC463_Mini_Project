# EC 463 MiniProject
--------------------
## Application Name

Food Scanner v2.0

-------------------
## Team Members
1) **Taehyon Paik (U58182574)**
 - Back-End development
 - Barcode scanner plugins
 - REST API
 - Firebase Flutter system link
 - Storing API data to DB 
 - get list from DB 

2) **Jungin Chang (U07196971)**
 - Front-End development
 - Firebase email authentication
 - UI design 
 - Icon / Splash / loading screen
 - Github maintenance
--------------------
## Design Decisions and Features
1) Sign-In
 - lib/authenticate/sign_in.dart, lib/services/auth.dart, lib/authenticate/authenticate.dart
 - Request valid email address
 - Request more than 6 characters for password
 - Check if user information is same with firebase user data

Design Decisions: We decided to put the sign in page in the first page, which enables only logged in, (email authenticated) users to access the features of the application. 

<img src="https://user-images.githubusercontent.com/60164571/133667322-e8a0dce1-55f6-46f7-bab3-9e312fcb48e6.png"  width="300" height="500">


2) Sign-Up
 - lib/authenticate/register.dart, lib/services/auth.dart, lib/authenticate/authenticate.dart
 - Request valid email address
 - Request more than 6 characters for password
 - Store user information to firebase

Design Decisions: We decided this as the 2nd page, if you don't have an ID, you go to the sign-up page, where you can enter a valid email address and password to continue with using the app. 

<img src="https://user-images.githubusercontent.com/60164571/133668635-2c5025b3-fd3e-4395-88f4-2d02b0b60fe2.png"  width="300" height="500">


3) Home Screen 
 - lib/home/home.dart
 - Two main features of this application: Update Recipe / Import Recipe 
 - logout button navigates back to sign-in screen 
 - Update Recipe navigates to Update Recipe screen
 - Import Recipe navigates to Import Recipe screen
 
 Design Decisions: For the 3rd page, the Home Screen needed to show a screen that can allow the user to choose which features to use. Therefore we decided to have two buttons that navigate users to their desired feature of the application.
 
<img src="https://user-images.githubusercontent.com/60164571/133670041-bc1a8641-92be-448f-8ea2-b45e045edf51.png"  width="300" height="500">


4) Update Recipe 
 - lib/home/update_recipe.dart
 - Enter name of a new recipe and press send button on the right 
 - Enter number of servings and press send button on the right 
 - Press scan barcode button on the top right corner to open your camera and scan food barcode
 - Barcode information including barcode, nutritient, calories appears in the center
 - Press Update button on the bottom to send and finalize new recipe information to database

Design Decisions: We decided that for updating a recipe, only some of all our features are needed. So we enabled entering a recipe name, servings, scanning barcode, and finally a button to update recipe information to the database.

 <img src="https://user-images.githubusercontent.com/60164571/133670267-3f749c83-c267-4935-9250-cd075d40fe16.png"  width="300" height="500">


5) Import Recipe 
 - lib/home/import_recipe.dart
 - Enter name of recipe that you want to import and press send button on the right 
 - Press import recipe on the bottom 2 times to get recipe information from database (initialize / fetch)
 - Recipe information includes product name, servings, and calories
 - Press clear screen to clear all recipe information on screen

Design Decisions: We decided that for importing a recipe, only some of all our features are needed. So we enabled entering a recipe name, a button to import data from the database, and finally a button to clear the screen to later on import other information on other recipes.

 <img src="https://user-images.githubusercontent.com/60164571/133671191-e58673b7-43c8-4c3b-b5ae-252f39fb9337.png"  width="300" height="500">
 
 
 
Debug/Problem Documentation:

09/10:
Can not get correct API data.
Resolved 09/11

09/11:
Can not use the barcode scan feature because of sound_null_safety.
Resolved after trying another method 09/11

09/13: 
Certain Barcodes don't store in firebase storage.
Can't delete entire collection. Can only delete field in the document.
Modified: Used clear screen feature instead of delete method. Some barcodes just don't seem to work.

09/15:
Can not clear screen right away, have to press clear, and then import.
Resolved 09/16

09/16:
Can not make API_KEY secret from github.

