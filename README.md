# flutter_simple_app

## Getting Started

This application has been developed for a technical test in a job application.

This app will search for an author by name using an API.For each of the author, you should see such information as the author name, his/her birth date/death date and the author's top work.By clicking with the author, a new page should be opened with a list of his/hers works.  

This project has been developed on macOS and tested with ios simulator.

## Prerequisites

Make sure you have Flutter installed on your machine. If not, follow the instructions on the official Flutter website: [Install Flutter](https://flutter.dev/docs/get-started/install)

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/HarumiaStar/flutter_simple_app.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```bash
flutter pub get 
```

**Step 3:**

Start an emulator or connect an iPhone using the following command:

```bash
open -a Simulator
```

**Step 4:**

To launch the application, run the following command:

```bash
flutter run
```

## Project structure

```bash
/flutter_simple_app
    /lib
        main.dart
        /pages
            details.dart
            home.dart
        /models
            author_model_api.dart
            author_model.dart
            work_model_api.dart
            work_model.dart
    /test
    /ios
```

## Video example

