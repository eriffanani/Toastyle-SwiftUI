# Toastyle-SwiftUI
Create a toast message quickly and customize it to what you want.

## Screenshot
<img src="https://github.com/eriffanani/Toastyle-SwiftUI/assets/26743731/0def5943-d7f3-4298-84f5-c01d7e483e27" width="300"/> <img src="https://github.com/eriffanani/Toastyle-SwiftUI/assets/26743731/c177e970-f7dc-4d44-88ba-c0a015724d91" width="300"/>

## Installation
### Cocoapods
```ruby
pod 'Toastyle-SwiftUI'
```

### XCode Package
XCode -> `File` -> `Add Packages...` -> Paste `https://github.com/eriffanani/Toastyle-SwiftUI` on Search Bar -> Select `Up To Next Minor Version` -> `Add Package` -> Done 

## How To Use

### Basic
```kotlin
import Toastyle

struct ContentView: View {
    var body: some View {
        ZStack { // Parent
          Toastyle(text: "Basic Toast", show: $show)
        }
    }
}
```

### Text Color
```swift
Toastyle(text: "Text Color Toast", show: $show)
    .textColor(Color.yellow)
```

### Icon Left
```swift
Toastyle(text: "Icon Left Toast", icon: "info.circle.fill", show: $show)
```

### Icon Right
```swift
Toastyle(text: "Icon Right Toast", image: "iconExample", show: $show4)
    .iconColor(Color.yellow)
    .iconPosition(.right)
```

### Border / Stroke
```swift
Toastyle(text: "Bordered Toast Message", show: $show5)
    .border(3, color: Color.orange)
```

### Corner
```swift
Toastyle(text: "Toast Corner Radius", show: $show6)
    .corner(22)
```

### Corner Custom
```swift
Toastyle(text: "Custom Corner Radius", show: $show7)
    .corners(15, corners: [.topRight, .bottomLeft])
    .border(3, color: Color.pink)
```

### Background
```swift
Toastyle(text: "Backgrund Color", show: $show8)
    .corners(15, corners: [.topRight, .bottomLeft])
    .border(3, color: Color.yellow)
    .backgroundColor(Color.red)
```

### Font
```swift
Toastyle(text: "Custom Font Family", show: $show9)
    .corner(10)
    .font(font: .custom("Sunlit Memories", size: 20).bold())
```

### State
```swift
Toastyle(text: "Success State Toast", show: $show10)
    .state(.success)
```

### Shadow
```swift
Toastyle(text: "Shadow Warning State", show: $show11)
    .state(.warning)
    .shadow(true)
```

### Position
```swift
Toastyle(text: "Custom Position", show: $show12)
    .state(.info)
    .shadow(true)
    .position(position: .top)
    .padding(.top, 10)
```
