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

ModalView is a componentfor displaying another view in a style not provided by SwiftUI.


### ModalPresentationStyle

| ModalPresentationStyle | SwiftUI         | SwiftyUI  | 
| :--------------------: | :-------------: | :-------: | 
| fullScreen             | fullScreenCover | Supported | 
| pageSheet              | sheet           | Supported | 
| formSheet              | No              | Supported | 
| currentContext         | No              | Supported | 
| overFullScreen         | No              | Supported | 
| overCurrentContext     | No              | Supported | 

### ModalTransitionStyle

| ModalTransitionStyle | SwiftUI   | SwiftyUI  | 
| :------------------: | :-------: | :-------: | 
| coverVertical        | Supported | Supported | 
| crossDissolve        | No        | Supported | 
| flipHorizontal       | No        | Supported | 
| partialCurl          | No        | No        | 

## HalfModalView

## EnvironmentValues

### PopToRootViewController

```swift

