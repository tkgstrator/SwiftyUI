# SwiftyUI

## Installation

### Swift Package Manager

Add the following line to the `dependencies` in your `package.swift` file:

```
.package(url: "https://github.com/tkgstrator/SwiftyUI", .upToNextMajor(from: "1.0.2"))
```

Next, add `SwiftyUI` as a dependency for your target:

```
.target(name: "MyTarget", dependencies: ["SwiftyUI"])
```

Your completed description may look like this:

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/tkgstrator/SwiftyUI", .upToNextMajor(from: "1.0.2"))
    ],
    targets: [
        .target(name: "MyTarget", dependencies: ["SwifyUI"])
    ]
)
```

### Xcode

Select File > Swift Packages > Add Package Dependency, then enter the following URL:

https://github.com/tkgstrator/SwiftyUI

For more details, see [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app).

## ModalView

```swift
struct ContentView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: { isPresented.toggle() }, label: { Text("Open") })
            .present(isPresented: $isPresented, transitionStyle: .coverVertical, presentationStyle: .pageSheet)
    }
}
```

### TransitionStyle 

#### CoverVertical

![](https://raw.githubusercontent.com/tkgstrator/SwiftyUI/master/Docs/GIF/01.gif)

#### FlipHorizontal

![](https://github.com/tkgstrator/SwiftyUI/raw/master/Docs/GIF/02.gif)

#### CrossDissolve

![](https://github.com/tkgstrator/SwiftyUI/raw/master/Docs/GIF/03.gif)

### PresentationStyle

#### PageSheet

![](https://github.com/tkgstrator/SwiftyUI/raw/master/Docs/PresentationStyle/01.png)

#### FormSheet

![](https://github.com/tkgstrator/SwiftyUI/raw/master/Docs/PresentationStyle/02.png) 

#### FullScreen

![](https://github.com/tkgstrator/SwiftyUI/raw/master/Docs/PresentationStyle/03.png)

## onDidLoad/onWillAppear/onWillDisappear

```swift
Content
.onDidLoad {
    // viewDidLoad
}
.onAppear {
    // viewDidAppear
}
.onWillAppear {
    // viewWillAppear
}
.onDisappear {
    // viewDidDisappear
}
.onWillDisappear {
    // viewWillDisappear
}
```

### Priority

1. Initializer
   - called on `init()`
2. `onDidLoad`
   - at the same time `viewDidLoad` for `ViewerController`
3. `onWillAppear`
   - at the same time `viewWillAppear` for `ViewerController`
4. `onAppear`
   - at the same time `viewDidAppear` for `ViewerController`

> Reference
>
> [【SwiftUI】viewWillAppear と viewWillDisappear に対応する](https://www.yururiwork.net/%E3%80%90swiftui%E3%80%91viewwillappear-%E3%81%A8-viewwilldisappear-%E3%81%AB%E5%AF%BE%E5%BF%9C%E3%81%99%E3%82%8B/)
>
> [Is there a SwiftUI equivalent for viewWillDisappear(\_:) or detect when a view is about to be removed?](https://stackoverflow.com/questions/59745663/is-there-a-swiftui-equivalent-for-viewwilldisappear-or-detect-when-a-view-is)

## SplitNavigationViewStyle

`NavigationViewStyle` has a specific style named `DoubleColumnNavigationViewStyle` but does not effect for the portrait on iPad.

```swift
NavigationView {
    Text("Primary")
    Text("Secondary")
}
.navigationViewStyle(SplitNavigationViewStyle())
```

![](https://raw.githubusercontent.com/tkgstrator/SwiftyUI/master/Docs/splitnavigationview.png)

> Reference
>
> [カスタム NavigationViewStyle 例](https://qiita.com/tom-u/items/57c0aec0fcc88bc16435)

## Known Issues

- `SplitNavigationViewStyle` does not work on using with following custom methods called after the view controllers `.onDidLoad`, `.onWillAppear` and `.onWillDisappear`.

```swift
NavigationView {
    Text("Primary")
    Text("Secondary")
}
.navigationViewStyle(SplitNavigationViewStyle()) // Does not work
.onWillAppear {
}
```

- `ModalWindow` could not dismiss by pulldown gesture/tap outside of modal(crash)

> [Cusom modal window on SwiftUI](https://stackoverflow.com/questions/68770436/cusom-modal-window-on-swiftui)
