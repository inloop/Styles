# Styles

[![Version](https://img.shields.io/cocoapods/v/Styles.svg?style=flat)](http://cocoapods.org/pods/Styles)
[![License](https://img.shields.io/cocoapods/l/Styles.svg?style=flat)](http://cocoapods.org/pods/Styles)
[![Platform](https://img.shields.io/cocoapods/p/Styles.svg?style=flat)](http://cocoapods.org/pods/Styles)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Styles is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Styles', :git => 'https://github.com/inloop/Styles.git'
```
## Usage
```swift
let h1 = TextStyle(
      .font(.preferredFont(forTextStyle: .largeTitle))
    , .foregroundColor(.black)
    , .backgroundColor(.yellow)
    , .paragraphStyle([
      .alignment(.center)
    ])
)
UILabel.appearance().textStyle = h1
```
## Author

radimhalfar, radim.halfar@inloop.eu  
jakubpetrik, petrik@inloop.eu

## License

Styles is available under the MIT license. See the LICENSE file for more info.
