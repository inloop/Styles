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
