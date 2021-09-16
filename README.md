# EC 463 MiniProject
--------------------
## Application Name

Food Scanner v1.1

-------------------
## Team Members
1) Taehyon Paik (U)
 - Back-End development
 - Barcode scanner plugins
 - REST API
 - Firebase Flutter system link
 - Storing API data to DB 
 - get list from DB 

2. Jungin Chang (U07196971)
 - Front-End development
 - Firebase email authentication
 - UI design 
 - Icon / Splash / loading screen
 - Github maintenance
--------------------
## Main Features 
1) Sign-In
 - lib/authenticate/sign_in.dart, lib/services/auth.dart, lib/authenticate/authenticate.dart
 - Request valid email address
 - Request more than 6 characters for password
 - Check if user information is same with firebase user data

<img src="https://user-images.githubusercontent.com/60164571/133667322-e8a0dce1-55f6-46f7-bab3-9e312fcb48e6.png"  width="300" height="500">

2) Sign-Up
 - lib/authenticate/register.dart, lib/services/auth.dart, lib/authenticate/authenticate.dart
 - Request valid email address
 - Request more than 6 characters for password
 - Store user information to firebase

Debug/Problem Documentation:

09/13: 
Certain Barcodes don't store in firebase storage.
Can't delete entire collection. Can only delete field in the document.


