<h1 align="center">Styles</h1>

<div align="center">
  <strong>Styling framework that works</strong>
</div>
<div align="center">
  A declarative and type-safe framework for beautiful applications
</div>

<br />

<div align="center">
  <!-- Version -->
  <a href="http://cocoapods.org/pods/Styles">
    <img src="https://img.shields.io/cocoapods/v/Styles.svg?style=flat"
      alt="Version" />
  </a>
  <!-- License -->
  <a href="http://cocoapods.org/pods/Styles">
    <img src="https://img.shields.io/cocoapods/l/Styles.svg?style=flat"
      alt="License" />
  </a>
  <!-- Platform -->
  <a href="http://cocoapods.org/pods/Styles">
    <img src="https://img.shields.io/cocoapods/p/Styles.svg?style=flat"
      alt="Platform" />
  </a>
  <!-- Swift version -->
  <a href="http://cocoapods.org/pods/Styles">
    <img src="https://img.shields.io/badge/swift-4-orange.svg"
      alt="Swift version" />
  </a>
</div>

## Table of Contents
- [Features](#features)
- [Example](#example)
  - [TextStyle](#textstyle)
  - [LayerStyle](#layerstyle)
  - [ColorStyle](#colorstyle)
- [Installation](#installation)
- [Contributions](#contributions)

## Features
- __declarative__: You describe the style, framework will do the rest
- __type-safe__: Type system will help you describe your style
- __plays nice with UIAppearance__: In fact its designed for it.
- __supports UIControl states and UITextField editing__: You're gonna ❤︎ it.
- __saves you from the `NSAttributedString`<sup><sup>[1](#soso)</sup></sup>__: Just work with `String`s.
- __text, color and layer properties__: Custom line height, letter spacing, corners? Me gusta.

<sub><sub><a name="soso">1</a>: In some cases.</sub></sub>

## Example

### TextStyle
```swift
let h1 = TextStyle(
     .font(.preferredFont(forTextStyle: .largeTitle)),
     .foregroundColor(.black),
     .backgroundColor(.yellow),
     .paragraphStyle([
          .alignment(.center),
          .lineHeight(2.5)
     ])
)

UILabel.appearance().textStyle = h1
UIButton.appearance().setTextStyle(h1, for: .normal)
```

### LayerStyle
```swift
let pill = LayerStyle(
     .cornerRadius(10),
     .borderWidth(3),
     .borderColor(.red),
     .opacity(0.8)
)

UILabel.appearance().layerStyle = pill  
```
```swift
let red = LayerStyle(
    .borderColor(.red),
    .borderWidth(0.5)
)

let blue = LayerStyle (
    .borderColor(.blue),
    .borderWidth(0.5)
)

UITextField.appearance().setLayerStyle(red, for: .editing)
UITextField.appearance().setLayerStyle(blue, for: .inactive)
```

### ColorStyle

```swift
let themeColors = ColorStyle(
    .backgroundColor(.gray),
    .tintColor(.blue)
)

UIView.appearance().colorStyle = themeColors
```

## Installation

Styles is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Styles', :git => 'https://github.com/inloop/Styles.git'
```

## Contributions

ARE WELCOME! 🖖

## Authors

|<div align="center"><img src="https://avatars2.githubusercontent.com/u/14109333?s=400&v=4" width="40px;"/><br />[Radim Halfar](https://github.com/radimhalfar)</div>|<div align="center"><img src="https://avatars1.githubusercontent.com/u/560958?s=400&v=4" width="40px;"><br />[Jakub Petrik](https://github.com/jakubpetrik)</div>|
| :---: | :---: |

<sub>Built with ❤︎ at [Inloop](http://www.inloop.eu)</sub>

## License

Styles is available under the MIT license. See the LICENSE file for more info.
