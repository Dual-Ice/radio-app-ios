# Radio - DevRush Marathon XII Challenge #3

![iOS](https://img.shields.io/badge/iOS-15.0-lightblue)  ![Swift](https://img.shields.io/badge/Swift-blue)  ![UIKit](https://img.shields.io/badge/UIKit-rebeccapurple) ![MVP+R](https://img.shields.io/badge/MVP+R-deeppink)

![iphone](https://www.dropbox.com/scl/fi/ibb15nccxt7hzkkzhx4b7/appBanner.jpeg?rlkey=mrhe7kr9qjpybc3rjaydi5814&st=4hbi9a0d&raw=1)

 ### Project created by:
<p align="left"> 
<a href="https://github.com/Dual-Ice">
<img src="https://img.shields.io/badge/Dual Ice (TeamLead)-blue"/></a>
<a href="https://github.com/michaelbolgar">
<img src="https://img.shields.io/badge/MichaelBolgar-red"/></a>
<a href="https://github.com/nikmosyl">
<img src="https://img.shields.io/badge/Nikmosyl-yellow"/></a>
<a href="https://github.com/ValentinaPopovaA">
<img src="https://img.shields.io/badge/ValentinaPopovaA-deeppink"/></a>
<a href="https://github.com/Sahadov">
<img src="https://img.shields.io/badge/Sahadov-orange"/></a>
<a href="https://github.com/AZavershinskiy">
<img src="https://img.shields.io/badge/AZavershinskiy-green"/></a>
<a href="https://github.com/MaksimIsAvailable">
<img src="https://img.shields.io/badge/MaksimIsAvailable-purple"/></a>
  
##
**Radio** is a mobile application for listening to radio stations from around the world. The app provides users with access to hundreds of radio stations across various genres and allows them to create their own favorite station lists and manage playback.

## Key Features:

- **MVP+R Architecture:**
  This approach allows for maintaining and scaling the application by minimizing the coupling between components and providing flexibility in navigation.

- **RESTful API:** 
  We used a RESTful API to fetch radio station data, ensuring fast and reliable access to hundreds of stations worldwide.

- **User Defaults:** 
  User preferences and settings are stored using UserDefaults, allowing settings to persist even after the app is restarted.

- **Kingfisher:** 
  Kingfisher was used for downloading and caching radio station images, which improved app performance and enhanced the user experience.

- **Firebase:** 
  We integrated Firebase for user authentication via email and Google, as well as for managing the user database.

- **Core Data:** 
  Core Data was utilized for local storage of favorite radio stations, enabling users to save their preferences without requiring a constant network connection.

## Main Screens of the Application:

1. **Onboarding:** A brief introduction to the app's features.
2. **Authentication (Sign In, Sign Up):** Login and registration via email or Google, with the option to recover the password.
3. **Popular Stations:** View and manage popular stations with the ability to vote.
4. **Favorites:** Store and manage favorite radio stations.
5. **All Stations:** Search and filter through all available radio stations.
6. **Station Details:** Detailed information about the current radio station with animation and an equalizer.
7. **Profile:** Manage personal data and settings.

### Additional Features:

- **Vertical Tab Bar:** A unique navigation design with vertically arranged tabs.
- **Localization:** Support for English and Russian languages.
