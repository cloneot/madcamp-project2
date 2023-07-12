# madcamp_project2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# About Project
Project Title: WORDART

Team Member: HYU 22 junseo Kim, KAIST 22 mingyu Kim

Detail: This app is chatting based game. English word you chat is translated to number. 

By adding all alpabets by A is 1, B is 2, ... , and Z is 26.

Ex) apple -> 1+16+16+12+5 = 50

If you start game server tell target number and your goal is to find English word whose translated number is as close as target number.

Score is abs(translated number - target numeber). Smaller score is good.

Game end when someone find matching word or timeover.

When timeover, user who has the smallest score win.
