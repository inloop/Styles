![alt text](https://imgur.com/download/rvaWqH3 "Styles - A declarative and type-safe framework for beautiful applications")
<sup>Artwork: <a href="https://www.webumenia.sk/dielo/SVK:SNG.K_8572">Josef Čapek - 7. Povídání o pejskovi a kočičce (7/43)</a></sup>
<h1 align="center">Styles</h1>

<div align="center">
  <strong>Styling framework that works</strong>
</div>
<div align="center">
  A declarative and type-safe framework for beautiful applications
</div>

<br />

<div align="center">
    <!-- Travis-CI -->
    <a href="https://travis-ci.org/inloop/Styles">
        <img src="https://travis-ci.org/inloop/Styles.svg?branch=master"
          alt="Travis-CI" />
    </a>
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
- [Requirements](#requirements)
- [Examples](#examples)
  - [TextStyle](#textstyle)
    - [Updating TextStyle](#updating-textstyle)
    - [TextEffects](#texteffects)
  - [ViewStyle](#viewstyle)
    - [Updating ViewStyle](#updating-viewstyle)
- [Installation](#installation)
- [Contributions](#contributions)
- [License](#license)
- [Authors](#authors)

## Features
- __declarative__: You describe the style, framework will do the rest
- __type-safe__: Type system will help you describe your style
- __plays nice with UIAppearance__: In fact its designed for it.
- __usable as settable property__:  Not only works as UIAppearance proxy, but also as settable property
- __supports UIControl states and UITextField editing__: You're gonna ❤︎ it.
- __saves you from the `NSAttributedString`<sup><sup>[1](#soso)</sup></sup>__: Just work with `String`s.
- __text, color and layer properties__: Custom line height, letter spacing, corners? Me gusta.
- __supports Styles updating__: Design base style for you app and update it on the fly as needed.

<sub><sub><a name="soso">1</a>: In some cases.</sub></sub>

## Requirements
- iOS 10.0+
- Xcode 9.2+
- Swift 4.1+

## Examples

### TextStyle

```swift
let h1 = TextStyle(
    .font(.preferredFont(forTextStyle: .largeTitle)),
    .foregroundColor(.black),
    .backgroundColor(.yellow),
    .letterSpacing(1.5),
    .paragraphStyle([
        .alignment(.natural),
        .lineHeight(2.5)
    ]),
    .strikethrought(TextDecoration(
        style: .thick,
        pattern: .dash
    )),
    .underline(TextDecoration(
        style: .single,
        pattern: .dashDotDot,
        byWord: true,
        color: .red
    ))
)

UILabel.appearance().textStyle = h1
UIButton.appearance().setTextStyle(h1, for: .normal)
```
```swift
let h1 = TextStyle(
    .font(.preferredFont(forTextStyle: .largeTitle)),
    .foregroundColor(.black),
    .backgroundColor(.yellow)
)

myLabel.textStyle = h1
```
#### Updating TextStyle

```swift
let footnote = TextStyle(
    .font(.preferredFont(forTextStyle: .footnote))
)

let blueFootnote = footnote.updating(.foregroundColor(.blue))

myLabel.textStyle = blueFootnote
```

```swift
let blueFootnote = TextStyle(
    .font(.preferredFont(forTextStyle: .footnote))
    .foregroundColor(.blue)
)

let redFootnote = blueFootnote.updating(.foregroundColor(.red))

myLabel.textStyle = redFootnote
```

#### Combining TextStyle

```swift
let blueFootnote = TextStyle(
    .font(.preferredFont(forTextStyle: .footnote))
    .foregroundColor(.blue)
)

let yellowBackground = TextStyle(
    .backgroundColor(.yellow)
)

myLabel.textStyle = blueFootnote + yellowBackground
```

```swift
let h1 = TextStyle(
    .font(.preferredFont(forTextStyle: .largeTitle)),
    .letterSpacing(1.5),
    .paragraphStyle([
        .alignment(.natural),
        .lineHeight(2.5)
    ]),
    .strikethrought(TextDecoration(
        style: .thick,
        pattern: .dash
    )),
    .underline(TextDecoration(
        style: .single,
        pattern: .dashDotDot,
        byWord: true,
        color: .red
    ))
)

let blue = TextStyle(
    .foregroundColor(.blue)
)

let yellowBackground = TextStyle(
    .backgroundColor(.yellow)
)

let secret = TextStyle(
    .writingDirectionOverrides([
        .rightToLeftOverride
    ])
)

let title = h1 + blue + yellowBackground

myLabel.textStyle = title
secretMessageLabel.textStyle = h1 + secret
```

#### TextEffects

```swift

let bigRed: TextStyle = ...
let bigGreen: TextStyle = ...
let smallCyan: TextStyle = ...

let bigRedFirstWord = TextEffect(
    style: bigRed,
    matching: First(occurenceOf: "Styles")
)

let bigGreenLastWord = TextEffect(
    style: bigGreen,
    matching: Block { $0.range(of: "awesome") }
)

let everyOtherTildaCyan = TextEffect(
    style: smallCyan,
    matching: Regex("~.*?(~)")
)

let tint = TextStyle(
    .foregroundColor(.red)
)

let logo: UIImage = ...
let logoBeforeCompanyName = TextEffect(image: logo, style: tint, matching: First(occurenceOf: "Inloop"))

let styleWithEffects = TextStyle(
    .font(.preferredFont(forTextStyle: .body)),
    .backgroundColor(.yellow),
    effects: [
        bigRedFirstWord,
        bigGreenLastWord,
        everyOtherTildaCyan,
        logoBeforeCompanyName
    ]
)

```

### ViewStyle

```swift

let pill = ViewStyle(
     .cornerRadius(10),
     .borderWidth(3),
     .borderColor(.red),
     .opacity(0.8),
)

UILabel.appearance().viewStyle = pill
```
```swift
let red = ViewStyle(
    .backgroundColor(.red),
    .tintColor(.red),
    .borderColor(.red),
    .borderWidth(0.5),
    .shadow(Shadow(
        color: .red,
        offset: UIOffset(horizontal: 0, vertical: 8),
        radius: 16
    ))
)

let blue = ViewStyle(
    .borderColor(.blue),
    .borderWidth(0.5),
    .shadow(.none)
)

UITextField.appearance().setViewStyle(red, for: .editing)
UITextField.appearance().setViewStyle(blue, for: .inactive)
UITextView.appearance().setViewStyle(red, for: .editing)
UITextView.appearance().setViewStyle(blue, for: .inactive)
```
```swift
let blue = ViewStyle(
    .borderColor(.blue),
    .borderWidth(0.5),
    .cornerRadius(10)
)

myButton.viewStyle = blue
```

#### Updating ViewStyle

```swift
let app = ViewStyle(
    .borderWidth(0.5),
    .cornerRadius(10)
)

let blue = app.updating(.borderColor(.blue))
```
```swift
let app = ViewStyle(
    .borderWidth(0.5),
    .cornerRadius(radius: 10)
)

let thick = app.updating(.borderWidth(3))
```

#### Combining ViewStyle

```swift
let app = ViewStyle(
    .borderWidth(0.5),
    .cornerRadius(10)
)

let semiVisible = ViewStyle(
    .opacity(0.5)
)

myLabel.viewStyle = app + semiVisible
```

```swift
let app = ViewStyle(
    .borderWidth(0.5),
    .cornerRadius(10)
)

let semiVisible = ViewStyle(
    .opacity(0.5)
)

let blue = ViewStyle(
    .backgroundColor(.blue)
)

let labelStyle = app + semiVisible + blue

myLabel.viewStyle = labelStyle
```

## Installation

Styles is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Styles', :git => 'https://github.com/inloop/Styles.git'
```

## Contributions

ARE WELCOME! 🖖

## License

Styles is available under the MIT license. See the LICENSE file for more info.

## Authors

|<div align="center"><img src="https://avatars2.githubusercontent.com/u/14109333?s=400&v=4" width="40px;"/><br />[Radim Halfar](https://github.com/radimhalfar)</div>|<div align="center"><img src="https://avatars1.githubusercontent.com/u/560958?s=400&v=4" width="40px;"><br />[Jakub Petrik](https://github.com/jakubpetrik)</div>|<div align="center"><img src="https://avatars1.githubusercontent.com/u/25616123?s=400&v=4" width="40px;"><br />[Matěj Děcký](https://github.com/matejdecky)</div>|
| :---: | :---: | :---: | 

<div align="center">
<sub>Built with ❤︎ at <a href="http://www.inloopx.com" alt="Inloop">Inloop</a></sub>
</div>
