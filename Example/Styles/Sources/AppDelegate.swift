//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit
import Styles

extension Shadow {
    static let magenta = Shadow(
        color: .magenta,
        offset: UIOffset(horizontal: 1, vertical: 1),
        radius: 4
    )

    static let blue = Shadow(
        color: .blue,
        offset: UIOffset(horizontal: 4, vertical: 4),
        radius: 4
    )

    static let red = Shadow(
        color: .red,
        offset: UIOffset(horizontal: 0, vertical: 8),
        radius: 16
    )
}

let h1 = TextStyle(
      .font(.preferredFont(forTextStyle: .largeTitle)),
      .foregroundColor(.black),
      .backgroundColor(.yellow),
      .paragraphStyle([
          .alignment(.center)
        ]),
      .obliqueness(0.3),
      .shadow(.magenta),
      effects: [ everyOtherTilda ]
)

let body = TextStyle(
      .font(.preferredFont(forTextStyle: .body)),
      .foregroundColor(.black),
      .backgroundColor(.yellow),
      .letterSpacing(1.5),
      .paragraphStyle([
          .alignment(.natural),
          .lineHeight(2.5)
        ]),
      .strikethrought(TextDecoration(
        style: .thick,
        pattern: .dash,
        color: .yellow
      )),
      .underline(TextDecoration(
        style: .single,
        pattern: .dashDotDot,
        byWord: true,
        color: .red
      ))
)

let highlight = body.updating(
    .backgroundColor(.blue),
    .foregroundColor(.green),
    .font(.preferredFont(forTextStyle: .largeTitle))
)

let bigRed = TextStyle(
    .font(.preferredFont(forTextStyle: .largeTitle)),
    .foregroundColor(.red)
)

let bigGreen = TextStyle(
    .font(.preferredFont(forTextStyle: .largeTitle)),
    .foregroundColor(.green)
)
let cyanTextWithBlueShadow = TextStyle(
    .foregroundColor(.cyan),
    .shadow(.blue)
)

let bigRedFirstWord = TextEffect(style: bigRed, matching: First(occurenceOf: "Styles"))
let bigGreenLastWord = TextEffect(style: bigGreen, matching: Block { $0.range(of: "awesome") })
let everyOtherTilda = TextEffect(style: cyanTextWithBlueShadow, matching: Regex("~.*?(~)"))
let doge = TextEffect(image: #imageLiteral(resourceName: "doge"), style: cyanTextWithBlueShadow, matching: First(occurenceOf: " i"))

let styleWithEffects = TextStyle(
    .font(.preferredFont(forTextStyle: .body)),
    .backgroundColor(.yellow),
    effects: [
        bigRedFirstWord,
        bigGreenLastWord,
        doge
    ]
)

let rounded = ViewStyle(
        .cornerRadius(10),
        .borderWidth(3),
        .borderColor(.red),
        .opacity(0.8)
    )

let appColor = ViewStyle(
    .backgroundColor(.gray),
    .tintColor(.blue)
)

let redColor = ViewStyle(
    .backgroundColor(.red),
    .shadow(.red)
)

let textFieldColorStyle = ViewStyle(
    .backgroundColor(.white),
    .tintColor(.blue)
)

let red = ViewStyle(
    .borderColor(.red),
    .borderWidth(0.5),
    .cornerRadius(0),
    .shadow(.red)
)

let blue = red.updating(
    .borderColor(.blue),
    .cornerRadius(10),
    .shadow(.none)
)

let greenHeadline = TextStyle(
    .font(.preferredFont(forTextStyle: .headline)),
    .foregroundColor(.green)
)

let magentaFootnote = TextStyle(
    .font(.preferredFont(forTextStyle: .footnote)),
    .foregroundColor(.magenta)
)

let largeTitle = TextStyle(
    .font(.preferredFont(forTextStyle: .largeTitle)),
    .foregroundColor(.white),
    .backgroundColor(.magenta)
)

let blueFootnote = magentaFootnote.updating(.foregroundColor(.blue))
let roundedApp = rounded + appColor

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        ExLabel.appearance().textStyle = styleWithEffects
        ExLabel.appearance().viewStyle = roundedApp

        ExButton.appearance().setTextStyle(h1, for: .normal)
        ExButton.appearance().setTextStyle(highlight, for: .highlighted)

        UITextField.appearance().setViewStyle(red, for: .editing)
        UITextField.appearance().setViewStyle(blue, for: .inactive)
        UITextField.appearance().setPlaceholderStyle(greenHeadline, for: .inactive)
        UITextField.appearance().setPlaceholderStyle(magentaFootnote, for: .editing)

        UITextView.appearance().setViewStyle(red, for: .editing)
        UITextView.appearance().setViewStyle(blue, for: .inactive)

        UINavigationBar.appearance().titleTextStyle = body
        UINavigationBar.appearance().largeTitleTextStyle = largeTitle
        UINavigationBar.appearance().tintColor = .yellow
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().barStyle = .black
        return true
    }
}
