# ReduxUI
Swiftly manage and structure your SwiftUI application state with the Redux design pattern.

## Introduction
Redux SwiftUI Library is a robust framework designed to help developers manage app-wide state more predictably. By leveraging a single source of truth and a unidirectional flow of data, this library promotes more maintainable, debuggable, and scalable SwiftUI apps.

<img width="50%" alt="ReduxUI Flow" src="https://github.com/kimnordin/ReduxUI/assets/12212744/233f882c-41df-4de9-88b2-e47b9e5d4a32">

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
1. **Define your App States:**
```swift
// Main State of your App, containing all other States
struct AppState: StateType {
    var dataState: DataState = DataState()
}

struct UserState: StateType {
    var name: String
}
```

2. **Set up your Actions:**
```swift
struct UpdateUserName: Action {
    let name: String
}
```

3. **Create the Reducers:**
```swift
// Main Reducer handling Actions, updating the AppState accordingly
func appReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? AppState()
    
    return AppState(userState: userReducer(action: action, state: state.userState))
}

func userReducer(action: Action, state: UserState?) -> UserState {
    var state = state ?? UserState()
    
    switch action {
    case let action as UpdateUserName:
        state.name = action.name
    default: break
    }
    
    return state
}
```

4. **Create a Store:**
```swift
let store = Store<AppState>(state: AppState(), reducer: appReducer)
```

5. **Use within SwiftUI:**
```swift
@EnvironmentObject private var store: Store<AppState>
```

6. **Dispatch Actions to modify the State:**
```swift
store.dispatch(UpdateUserName(name: "Kim"))
```

### Advanced Usage
- **Middleware**: Extend your store with custom functionalities.
- **Thunks**: Dispatch async actions and handle complex operations.

## Examples
- The [TestReduxUI](https://github.com/kimnordin/TestReduxUI) Repository provides a simple Counter App made with the ReduxUI library.
- The [WalkApp](https://github.com/kimnordin/WalkApp) Repository highlights a more complex Step Counting App relying heavily on the ReduxUI library.
