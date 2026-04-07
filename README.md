# App Publishing & Maintaining — Fastlane Demo

This repository is the course example for the **App Publishing & Maintaining** lecture at FH OOE. It demonstrates how to automate Android app delivery to Google Play using **Fastlane**.

The Flutter app itself is intentionally minimal — the focus is entirely on the deployment pipeline.

## Project Structure

```
.
├── android/
│   ├── app/build.gradle.kts      # signing config (reads from key.properties)
│   ├── key.properties            # NOT committed — contains keystore credentials
│   └── upload-keystore.jks       # NOT committed — your upload signing key
├── fastlane/
│   ├── Appfile                   # package name + path to Google Play key
│   ├── Fastfile                  # lane definitions (analyze, test, deploy)
│   ├── google-play-key.json      # NOT committed — Google Play service account key
│   └── google-play-key.json.template  # committed — shows required key structure
├── lib/
│   └── main.dart
└── Gemfile                       # fastlane gem
```

---

## Prerequisites

- Flutter SDK installed
- Ruby + Bundler installed (`gem install bundler`)
- A Google Play Console account with the app created
- A Google Cloud service account with Play Console access

---

## Setup

### 1. Install Fastlane

```bash
bundle install
```

### 2. Create the upload keystore

```bash
keytool -genkey -v -keystore android/upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

### 3. Create `android/key.properties`

```properties
storePassword=your-keystore-password
keyPassword=your-key-password
keyAlias=upload
storeFile=../upload-keystore.jks
```

### 4. Add the Google Play service account key

- Go to **Google Play Console** → Setup → API access
- Link a Google Cloud project and create a service account
- Download the JSON key
- Copy it to `fastlane/google-play-key.json` (use the `.template` file as reference)

---

## Fastlane Lanes

| Lane | Command | Description |
|------|---------|-------------|
| `analyze` | `bundle exec fastlane analyze` | Runs `flutter analyze` |
| `test` | `bundle exec fastlane test` | Runs `flutter test` |
| `deploy` | `bundle exec fastlane deploy` | analyze → test → build AAB → upload to Play Store (Internal Testing, draft) |

### Deploy

```bash
bundle exec fastlane deploy
```

This single command:
1. Runs static analysis
2. Runs unit tests
3. Builds a signed release AAB
4. Uploads it to the **Internal Testing** track on Google Play as a draft

---

## Security — What Is NOT Committed

The following files contain secrets and are excluded via `.gitignore`:

| File | Why |
|------|-----|
| `android/upload-keystore.jks` | Upload signing key |
| `android/key.properties` | Keystore passwords |
| `fastlane/google-play-key.json` | Google Play API credentials |

Never commit these files to a public repository.
