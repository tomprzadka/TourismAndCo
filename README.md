# testproject

Flutter project based on the following course: [See Nick Code Tutorials](https://fluttercrashcourse.seenickcode.com/courses/basics)

This project is a 2-view mobile application designed for android, built and developed on windows machine, using Visual Studio Code.
Was not tested on iOS devices (yet).


Most steps provided assume whoever uses this repo uses VS Code as their editor and has flutter environment already configured.


## Requirements

1. Java - openjdk 17.0.7 or later
2. Gradle - version 7.5 or later

## Setup

1. Clone the repository.
2. Run `flutter pub get` in the command line/ terminal of choice.


## App Launch

1. Make sure you have android physical device (or emulator) available and connected (run `adb devices` beforehand).
2. Navigate to `lib/app.dart` file.
3. Launch the app using one of the following: `F5` - Start Debugging; `Ctrl + F5` - Run Without Debugging; open `Run` menu and select either `Start Debugging` or `Run Without Debugging`.


## Known issues

1. App Bar is not yet styled.
2. Clicking `BOOK` button may throw an error if no email service is installed on the device/emulator.
3. Sticky `BOOK` container actually overlaps text partially (and isn't really sticky) it isn't a part of the tutorial I'm following, but I'm planning on rebuilding it anyway.
