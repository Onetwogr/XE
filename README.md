XE , an iOS App for real estate

Creator

Created by: Ioannis Gkortsos
GitHub: https://github.com/Onetwogr
LinkedIn: https://www.linkedin.com/in/onetwogr

General

App Name: XE
Technologies Used: Swift, SwiftUI
Architecture: MVVM

Description

The XE iOS App is designed for a real estate ads platform that allows users to create property ads. The key feature of the app is the area selection, which integrates an autocomplete API that suggests locations as the user types in the address field. The app ensures that the location field is filled correctly before the user can submit the form.

Features
	•	Location Field:
Autocomplete suggestions appear as the user types, validating the input against the API.
	•	Title Field:
A mandatory free-text field for submitting an ad.
	•	Price Field:
A number-only field, not mandatory for submitting an ad.
	•	Description Text Editor:
A free-text field for additional information, not mandatory for submitting an ad.
	•	Submit Action:
When valid data is entered, a JSON object is created, displayed on the screen, and the fields are cleared for new entries.
	•	Clear Action:
Resets the form, allowing the user to start over.
	•	API Integration:
Fetches location data from a remote API based on user input.
	•	Responsive Design:
Optimized for both mobile and tablet devices to ensure a smooth experience across different screen sizes.

Setup Instructions
	1.	Clone the Repository: git clone https://github.com/Onetwogr/XE.git
	2.	Open the Project:
Open the .xcodeproj file in Xcode.
	3.	Change the Team in Xcode:
In Xcode, go to the Signing & Capabilities tab and select the appropriate Team for your Apple Developer account. If you’re running on a personal device, select your personal team.
	4.	Run the App:
Select a target device or simulator and click Run.
	5.	API Integration:
The app uses an autocomplete API to fetch location suggestions. An active internet connection is required for this feature to work.

Bonus Features
	•	Device-Level Caching:
The app minimizes the number of API calls by caching location data on the device.
  •	Scalable Architecture:
The app is designed with scalability in mind, using modular and reusable components that can easily be extended and maintained as the app grows.

License

This project is open-source and available under the MIT License.





