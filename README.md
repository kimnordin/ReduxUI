# ReduxUI

Swiftly manage and structure your SwiftUI application state with the Redux design pattern.

## Introduction

Redux SwiftUI Library is a robust and type-safe framework designed to help developers manage app-wide state more predictably. By leveraging a single source of truth and a unidirectional flow of data, this library promotes more maintainable, debuggable, and scalable SwiftUI apps.

## Features

- **Single Source of Truth**: All of your app's state is stored in a single store, making debugging and state observation easier.
- **Type Safety**: Built with Swift's type system in mind, ensuring errors are caught at compile-time.
- **Middleware Support**: Enhance your store with custom middleware to handle side effects or introduce advanced logging and debugging tools.
- **Thunks**: Asynchronous actions are simplified with the use of thunks.
- **Observable Store**: Seamless integration with SwiftUI by making the store an observable object.

## Getting Started

### Installation

ReduxUI can be installed using Swift Package Manager.

1. **Open Your Project in Xcode:**
Start by opening your Swift project in Xcode.
2. **Add Package Dependency:**  
  •	Go to File → Swift Packages → Add Package Dependency.  
  •	Paste the URL of the ReduxUI GitHub repository: https://github.com/kimnordin/ReduxUI.git.
3. **Specify the Version:**
Choose the version of the ReduxUI package you want to add. You can specify a version number, a branch, or a commit.
4. **Add to Your Target:**
After Xcode loads the package and its dependencies, select the ReduxUI library, and add it to your project’s target(s).

### Basic Usage

1. **Define your app state:**
```swift
struct AppState: StateType {
    // Your app-specific state properties
}
```

2. **Create a store:**
```swift
let store = Store<AppState>(state: initialAppState, reducer: appReducer)
```

3. **Use within SwiftUI:**
```swift
@EnvironmentObject var store: Store<AppState>
```

4. **Dispatch actions to modify the state:**
```swift
store.dispatch(RefreshAction())
```

### Advanced Usage

- **Middleware**: Extend your store with custom functionalities.
- **Thunks**: Dispatch async actions and handle complex operations.
