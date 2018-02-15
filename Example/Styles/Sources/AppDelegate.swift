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
}

let h1 = TextStyle(
      .font(.preferredFont(forTextStyle: .largeTitle)),
      .foregroundColor(.black),
      .backgroundColor(.yellow),
      .paragraphStyle([
          .alignment(.center)
        ]),
      .obliqueness(0.3),
      .shadow(.magenta)
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
        .roundCorners([.topLeft, .bottomRight], radius: 10),
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

let blueFootnote = magentaFootnote.updating(.foregroundColor(.blue))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(magentaFootnote.attributes)
        print(blueFootnote.attributes)
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
