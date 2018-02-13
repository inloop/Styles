//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import UIKit
import Styles

let h1 = TextStyle(
      .font(.preferredFont(forTextStyle: .largeTitle)),
      .foregroundColor(.black),
      .backgroundColor(.yellow),
      .paragraphStyle([
          .alignment(.center)
        ]),
      .obliqueness(0.3)
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
        pattern: .dash
      )),
      .underline(TextDecoration(
        style: .single,
        pattern: .dashDotDot,
        byWord: true,
        color: .red
      ))
)

let rounded = LayerStyle(
        .cornerRadius(10),
        .borderWidth(3),
        .borderColor(.red),
        .opacity(0.8)
    )

let appColor = ColorStyle(
    .backgroundColor(.gray),
    .tintColor(.blue)
)

let textFieldColorStyle = ColorStyle(
    .backgroundColor(.white),
    .tintColor(.blue)
)

let red = LayerStyle(
    .borderColor(.red),
    .borderWidth(0.5)
)

let blue = LayerStyle (
    .borderColor(.blue),
    .borderWidth(0.5)
)

let greenHeadline = TextStyle(
    .font(.preferredFont(forTextStyle: .headline)),
    .foregroundColor(.green)
)

let magentaFootnote = TextStyle(
    .font(.preferredFont(forTextStyle: .footnote)),
    .foregroundColor(.magenta)
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ExLabel.appearance().textStyle = body
        ExLabel.appearance().layerStyle = rounded
        UIButton.appearance().setTextStyle(h1, for: .normal)
        UIButton.appearance().setTextStyle(body, for: .highlighted)
        UITextField.appearance().setLayerStyle(red, for: .editing)
        UITextField.appearance().setLayerStyle(blue, for: .inactive)
        UITextField.appearance().setPlaceholderStyle(greenHeadline, for: .inactive)
        UITextField.appearance().setPlaceholderStyle(magentaFootnote, for: .editing)
        UINavigationBar.appearance().textStyle = h1
        UINavigationBar.appearance().tintColor = .yellow
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().barStyle = .black
        return true
    }
}

