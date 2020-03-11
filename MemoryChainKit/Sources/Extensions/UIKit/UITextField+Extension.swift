//
//  UITextField+Extension.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

#if canImport(UIKit)
import UIKit

#if !os(watchOS)
// MARK: - Enums
public extension UITextField {
    
    ///  UITextField text type.
    ///
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    enum TextType {
        case emailAddress
        case password
        case generic
    }
    
}

//MARK: - configure leftView 
public extension UITextField {
   
     func configureLeftViewForTextFiled(_ imageName:String,withTextField textField:UITextField) {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.image!.size.width + 20, height: (imageView.image?.size.height)!)
        textField.leftViewMode = .always
        textField.leftView = imageView
        
    }
    func configureKeybordTypeForTextFiled(textField:UITextField,withKeyboardType keyboardType:UIKeyboardType) {
        textField.keyboardType = keyboardType
    }
}

// MARK: - Properties
public extension UITextField {
    
    ///  Set textField for common text types.
    var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = false
                placeholder = "emailAddress".localized
                
            case .password:
                keyboardType = .asciiCapable
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = true
                placeholder = "password".localized
                
            case .generic:
                isSecureTextEntry = false
            }
        }
    }
    
    ///  Check if text field is empty.
    var isEmpty: Bool {
        return text?.isEmpty == true
    }
    
    ///  Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    ///  Check if textFields text is a valid email format.
    ///
    ///        textField.text = "john@doe.com"
    ///        textField.hasValidEmail -> true
    ///
    ///        textField.text = "swifterswift"
    ///        textField.hasValidEmail -> false
    ///
     var hasValidEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    ///  Left view tint color.
    @IBInspectable  var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
    ///  Right view tint color.
    @IBInspectable  var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
    
}

// MARK: - Methods
public extension UITextField {
    
    ///  Clear text.
     func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    ///  Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
     func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        //字体颜色
        self.attributedPlaceholder = NSAttributedString.init(string:holder, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize:20), NSAttributedString.Key.foregroundColor:color])
    }
    
    ///  Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
     func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    ///  Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
     func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /// Add border width and color
    ///
    /// - Parameters:
    ///   - width: width
    ///   - color: color
    func setBorder(_ width: CGFloat, _ color: UIColor) {
        self.borderWidth = width
        self.borderColor = color
    }
    
    func addLineView(_ viewColor: UIColor, _ margin: CGFloat) {
        let view = UIView()
        view.backgroundColor = viewColor
        self.addSubview(view)
        #warning("TO DO add constraints")
        }
    }


#endif

#endif

//MARK: - fix secureEntry

public extension UITextField {
    func fixSecureEntry() {
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
    
    //MARK:-设置暂位文字的颜色
    var placeholderColor:UIColor {
        get {
            let color =   self.value(forKeyPath: "_placeholderLabel.textColor")
            if(color == nil){
                return UIColor.white;
            }
            return color as! UIColor;
        }
        set {
            self.setValue(newValue, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    //MARK:-设置暂位文字的字体
    var placeholderFont:UIFont{
        get {
            let font =   self.value(forKeyPath: "_placeholderLabel.font")
            if(font == nil){
                return UIFont.systemFont(ofSize: 14);
            }
            return font as! UIFont;
        }
        set {
            self.setValue(newValue, forKeyPath: "_placeholderLabel.font")
        }
    }
}
