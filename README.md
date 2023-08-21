# HabitTracker
This is a WIP iOS practice project built with SwiftUI.<br>
I am using this project to practice my mobile development skills and keep updating it as my skillset expands.<br>
Application is tested with XCode 13.<br>

## Video Example
https://github.com/IanGaplichnik/HabitTracker/assets/70972514/64fe1a3f-02fe-4812-9832-e33e4d6f6ecb

## Design
I've picked a fairly simple design for this project.<br>
Main data structure is Habit, which contains next fields:

```swift
struct Habit: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let labelColor: String
    var complete: Bool
    let goal: String
    let imageName: String?
}
```
All data is stored locally on the device and is saved each time there are changes introdced.<br>
At the startup data is decoded from JSON, saved on device internal memory.<br>

## Checklist
- [x] Onboarding
- [x] Screen with default habits, which can be skipped
- [x] List of saved habits
- [x] Empty list of habits
- [x] Habit deletion and edit
- [ ] Limit habit name length
- [ ] Reset completed habits every day
