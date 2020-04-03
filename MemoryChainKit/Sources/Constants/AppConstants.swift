//
//  AppConstants.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2020/3/19.
//  Copyright © 2020 Marc Steven(https://github.com/MarcSteven). All rights reserved.
//
import UIKit

public struct AppConstants {
    public static var φ: CGFloat { 0.618 }
    public static var statusBarHeight:CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    public static var tabBarHeight:CGFloat {
        return 49
    }
    public static var uiControlsHeight:CGFloat {return 50}
    public static var searchBarHeight:CGFloat {return uiControlsHeight}
    public static var hairlINE:CGFloat  = 0.5
    public static var tileCornerRadius:CGFloat = 11
    public static var cornerRadius:CGFloat = 6
    
}

//Device:
extension AppConstants {
    
}
extension CGFloat {
    public static let minimumPadding: CGFloat = 8
    public static let defaultPadding: CGFloat = 15
    public static let maximumPadding: CGFloat = 30

    /// A convenience method to return `1` pixel relative to the screen scale.
    
}
extension UIColor {
    /// Returns default system tint color.
    public static var systemTint: UIColor {
        struct Static {
            static let tintColor = UIView().tintColor ?? .appleBlue
        }

        return Static.tintColor
    }

    /// Returns default app tint color.
    @nonobjc public static var appTint: UIColor = .systemTint

    /// The color for app borders or divider lines that hide any underlying content.
    @nonobjc public static var appSeparator = UIColor(hexString: "DFE9F5")
    @nonobjc public static var appHighlightedBackground = appSeparator
    @nonobjc public static var appBackgroundDisabled = appleGray
}

extension UIColor {
    @nonobjc static var appleGray: UIColor {
        return UIColor(hexString: "EBF2FB")
        
        }
    @nonobjc static var appleTealBlue: UIColor {return  UIColor(hexString: "5AC8FA") }
    @nonobjc static var appleBlue: UIColor { return UIColor(hexString: "007AFF") }
    @nonobjc static var applePurple: UIColor { return UIColor(hexString: "5856D6") }
    @nonobjc static var appleGreen: UIColor { return UIColor(hexString: "4CD964") }
    @nonobjc static var appleRed: UIColor { return UIColor(hexString: "FF3B30") }
}


// MARK: - Global

/// Returns the name of a `type` as a string.
///
/// - Parameter value: The value for which to get the dynamic type name.
/// - Returns: A string containing the name of `value`'s dynamic type.
public func name(of value: Any) -> String {
    let kind = value is Any.Type ? value : Swift.type(of: value)
    let description = String(reflecting: kind)

    // Swift compiler bug causing unexpected result when getting a String describing
    // a type created inside a function.
    //
    // https://bugs.swift.org/browse/SR-6787

    let unwantedResult = "(unknown context at "
    guard description.contains(unwantedResult) else {
        return description
    }

    let components = description.split(separator: ".").filter { !$0.hasPrefix(unwantedResult) }
    return components.joined(separator: ".")
}
