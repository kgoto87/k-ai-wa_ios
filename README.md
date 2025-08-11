# K-AI-WA Memo iOS App

This repository contains the iOS application for the K-AI-WA Memo project.

## Prerequisites

*   **Xcode:** You'll need Xcode to build and run the iOS app. You can download it from the Mac App Store.
*   **Firebase CLI:** The Firebase CLI is required to run the emulators and interact with your Firebase project.
    *   **Installation:** If you don't have it, you can install it with `curl -sL https://firebase.tools | bash`.
    *   **Login:** Before using the CLI, you need to log in to your Google account by running `firebase login`.
*   **XcodeGen:** This project uses XcodeGen to generate the project file. You can install it with `brew install xcodegen`.

## Project Generation

This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) to generate the `KAIWAMemo.xcodeproj` file from the `project.yml` specification. The `project.yml` file is the single source of truth for the project structure, dependencies, and settings.

If you need to make changes to the project structure, such as adding new source files or changing dependencies, you should edit the `project.yml` file and then run the following command from the `k-ai-wa_ios` directory to regenerate the project file:

```bash
xcodegen
```

## First-Time Setup

If you are setting up this project for the first time, you need to create a Firebase configuration file.

The app needs a `GoogleService-Info.plist` file to start. For local development with the emulator, you can use a file with placeholder values. Create a file at `KAiWaMemo/config/development/GoogleService-Info.plist` with the following content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PROJECT_ID</key>
    <string>k-ai-wa-memo-local</string>
    <key>GCM_SENDER_ID</key>
    <string>1234567890</string>
    <key>IS_GCM_ENABLED</key>
    <true/>
    <key>IS_SIGNIN_ENABLED</key>
    <true/>
    <key>GOOGLE_APP_ID</key>
    <string>1:1234567890:ios:abcdef1234567890</string>
</dict>
</plist>
```

After creating this file, run `xcodegen` again to ensure it's included in the project.

## Running the App

Once you have completed the first-time setup, you can run the app.

### 1. Start the Firebase Emulator

From the root of this repository, run:
```bash
firebase emulators:start
```

### 2. Run the app in Xcode

*   Open the `KAIWAMemo.xcodeproj` file in Xcode.
*   Select a simulator and run the app.
*   Click the "Write to Firestore" button. You should see a "Document successfully written!" message, confirming the connection to the local emulator.
