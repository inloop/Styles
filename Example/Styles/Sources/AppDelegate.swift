//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit
import Styles

extension NSShadow {
    static let magenta: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.magenta
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 4
        return shadow
    }()

    static let blue: NSShadow = {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blue
        shadow.shadowOffset = CGSize(width: 4, height: 4)
        shadow.shadowBlurRadius = 4
        return shadow
    }()
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
let doge = TextEffect(image: #imageLiteral(resourceName: "doge"), matching: First(occurenceOf: " i"))

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
        .roundCorners([.topLeft, .bottomRight], radius: 10),
        .borderWidth(3),
        .borderColor(.red),
        .opacity(0.8)
    )

let appColor = ViewStyle(
    .backgroundColor(.gray),
    .tintColor(.blue)
)

let redColor = ViewStyle(
    .backgroundColor(.red)
)

let textFieldColorStyle = ViewStyle(
    .backgroundColor(.white),
    .tintColor(.blue)
)

let red = ViewStyle(
    .borderColor(.red),
    .borderWidth(0.5)
)

let blue = red.updating(
    .borderColor(.blue),
    .roundCorners(.allCorners, radius: 10)
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
        print(magentaFootnote.attributes)
        print(blueFootnote.attributes)
        // Override point for customization after application launch.
        ExLabel.appearance().textStyle = styleWithEffects
        ExLabel.appearance().viewStyle = roundedApp
        UIButton.appearance().setTextStyle(h1, for: .normal)
        UIButton.appearance().setTextStyle(highlight, for: .highlighted)
        UITextField.appearance().setViewStyle(red, for: .editing)
        UITextField.appearance().setViewStyle(blue, for: .inactive)
        UITextField.appearance().setPlaceholderStyle(greenHeadline, for: .inactive)
        UITextField.appearance().setPlaceholderStyle(magentaFootnote, for: .editing)
        UITextView.appearance().setViewStyle(red, for: .editing)
        UITextView.appearance().setViewStyle(blue, for: .inactive)
        UITextView.appearance().setTextStyle(highlight, for: .editing)
        UINavigationBar.appearance().titleTextStyle = body
        UINavigationBar.appearance().largeTitleTextStyle = largeTitle
        UINavigationBar.appearance().tintColor = .yellow
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().barStyle = .black
        return true
    }
}
