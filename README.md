# zerohedge

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


1. flutter build appbundle
2. java -jar ~/Downloads/bundletool-all-0.12.0.jar build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=build/app/outputs/bundle/release/app.apks --ks=key.jks --ks-pass=pass:password --ks-key-alias=key --key-pass=pass:password --mode=universal --overwrite
3. unzip app.apks -d apks
4. check version: ~/Library/Android/sdk/build-tools/29.0.2/aapt dump badging build/app/outputs/bundle/release/apks/universal.apk
