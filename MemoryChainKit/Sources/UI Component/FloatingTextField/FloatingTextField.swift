//
//  FloatingTextField.swift
//  MemoryChainKit
//
//  Created by Marc Zhao on 2019/5/14.
//  Copyright © 2019 Memory Chain technology(China) co,LTD. All rights reserved.
//

import Foundation


@objc public protocol FloatingTextFieldDelegate:class {
    
    //MARK: optional delegate method
    @objc optional func configureLeftView( in textField:FloatingTextField?)
    @objc optional func configureRightView( in textField:FloatingTextField?)
}

@IBDesignable

open class FloatingTextField:UITextField {
    //MARK: - public properties
    @IBOutlet public weak var textFieldDelegate:FloatingTextFieldDelegate?
    
    
    @IBInspectable
    public var lineHeight: CGFloat = 0{
        didSet{
            configureLineView()
        }
    }
    
    @IBInspectable
    public var selectedLineHeight: CGFloat = 0{
        didSet{
            if selectedLineHeight == 0{
                selectedLineHeight = lineHeight
            }
        }
    }
    
    @IBInspectable
    public var labelText: String = ""{
        didSet{
            if labelText != ""{
                self.placeholderLabel.text = labelText
            }
        }
    }
    
    @IBInspectable
    public var titleLabelColor: UIColor = .darkGray
    
    @IBInspectable
    public var lineColor: UIColor = .darkGray{
        didSet{
            self.lineView?.backgroundColor = lineColor
        }
    }
    
    @IBInspectable
    public var selectedTitleColor: UIColor = .blue
    
    @IBInspectable
    public var selectedLineColor: UIColor = .blue
    
    @IBInspectable
    public var errorColor: UIColor = .red{
        didSet{
            self.errorLabel.textColor = errorColor
        }
    }
    
    @IBInspectable
    public var placeholderColor: UIColor?{
        didSet{
            #if swift(>=4.2)
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:placeholderColor ?? UIColor.lightGray])
            
            #elseif swift(>=4.0)
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor:placeholderColor ?? UIColor.lightGray])
            #else
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSForegroundColorAttributeName:placeholderColor ?? UIColor.lightGray])
            #endif
        }
    }
    
    @IBInspectable
    public var rightImage: UIImage?{
        didSet{
            let ratio = (rightImage?.size.height)! / (rightImage?.size.width)!
            let newWidth = self.frame.height / ratio
            
            right_view = UIView(frame: CGRect(x: 0, y: 0, width: newWidth, height: self.frame.size.height))
            
            if rightImageClicable{
                right_view!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightViewSelected(_:))))
            }
            let imageView = UIImageView(image: rightImage)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            right_view?.addSubview(imageView)
            
            imageView.topAnchor.constraint(equalTo: right_view!.topAnchor, constant: 7).isActive = true
            imageView.leftAnchor.constraint(equalTo: right_view!.leftAnchor, constant: 7).isActive = true
            imageView.bottomAnchor.constraint(equalTo: right_view!.bottomAnchor, constant: -7).isActive = true
            imageView.rightAnchor.constraint(equalTo: right_view!.rightAnchor, constant: -7).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            self.rightView = right_view
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable
    public var rightImageSquare: UIImage?{
        didSet{
            let newWidth = 20
            right_view = UIView(frame: CGRect(x: 0, y: 0, width: newWidth + 14, height: newWidth))
            
            if rightImageClicable{
                right_view!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightViewSelected(_:))))
            }
            let imageView = UIImageView(image: rightImage)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            right_view?.addSubview(imageView)
            
            imageView.centerYAnchor.constraint(equalTo: right_view!.centerYAnchor, constant: 0).isActive = true
            imageView.leftAnchor.constraint(equalTo: right_view!.leftAnchor, constant: 7).isActive = true
            imageView.rightAnchor.constraint(equalTo: right_view!.rightAnchor, constant: -7).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            self.rightView = right_view
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable
    public var padding: CGFloat = 0{
        didSet{
            if rightImage == nil{
                self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
                self.rightViewMode = .always
            }
            if leftImage == nil{
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
                self.leftViewMode = .always
            }
        }
    }
    
    @IBInspectable
    public var leftImage: UIImage?{
        didSet{
            let ratio = (leftImage?.size.height)! / (leftImage?.size.width)!
            let newWidth = self.frame.height / ratio
            left_view = UIView(frame: CGRect(x: 0, y: 0, width: newWidth, height: self.frame.size.height))
            if leftImageClicable{
                if left_view != nil{
                    left_view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftViewSelected(_:))))
                }
            }
            let imageView = UIImageView(image: leftImage)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            left_view?.addSubview(imageView)
            
            imageView.topAnchor.constraint(equalTo: left_view!.topAnchor, constant: 7).isActive = true
            imageView.leftAnchor.constraint(equalTo: left_view!.leftAnchor, constant: 7).isActive = true
            imageView.bottomAnchor.constraint(equalTo: left_view!.bottomAnchor, constant: -7).isActive = true
            imageView.rightAnchor.constraint(equalTo: left_view!.rightAnchor, constant: -7).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            self.leftView = left_view
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable
    public var leftImageSquare: UIImage?{
        didSet{
            let newWidth = 20
            left_view = UIView(frame: CGRect(x: 0, y: 0, width: newWidth + 14, height: newWidth))
            if leftImageClicable{
                if left_view != nil{
                    left_view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftViewSelected(_:))))
                }
            }
            let imageView = UIImageView(image: leftImage)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            left_view?.addSubview(imageView)
            
            imageView.centerYAnchor.constraint(equalTo: left_view!.centerYAnchor, constant: 0).isActive = true
            imageView.leftAnchor.constraint(equalTo: left_view!.leftAnchor, constant: 7).isActive = true
            imageView.rightAnchor.constraint(equalTo: left_view!.rightAnchor, constant:-7).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            self.leftView = left_view
            self.leftViewMode = .always
        }
    }
    
    
    public var rightImageClicable: Bool = false{
        didSet{
            if rightImageClicable{
                right_view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightViewSelected(_:))))
            }
        }
    }
    
    public var leftImageClicable: Bool = false{
        didSet{
            if leftImageClicable{
                left_view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftViewSelected(_:))))
            }
        }
    }
    
    //MARK:-  Private Properties
    var right_view: UIView?
    var left_view: UIView?
    
    lazy var lineView:UIView? = {
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        return parentView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .clear
        label.font = self.font
        return label
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = self.font
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    var floatingLabelTopConstraint: NSLayoutConstraint!
    var floatingLabelLeftConstraint: NSLayoutConstraint!
    var floatingLabelHeightConstraint: NSLayoutConstraint!
    var lineHeightConstraint: NSLayoutConstraint?
    
    var showError: Bool = false{
        didSet{
            if showError{
                self.configureErrorLabel()
            }else{
                if isEditing{
                    self.lineView?.backgroundColor = selectedLineColor
                    self.placeholderLabel.textColor = selectedTitleColor
                }else{
                    self.lineView?.backgroundColor = lineColor
                    self.placeholderLabel.textColor = titleLabelColor
                }
                self.errorLabel.isHidden = true
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addViews()
    }
    
    public func showErrorMessage(_ error: String){
        if error.count > 0{
            self.showError = true
            self.configureErrorLabel()
            self.errorLabel.isHidden = false
            errorLabel.textColor = errorColor
            errorLabel.text = error
            lineView?.backgroundColor = errorColor
            if let text = text{
                if text.count > 0{
                    placeholderLabel.isHidden = false
                    placeholderLabel.textColor = errorColor
                }else{
                    placeholderLabel.textColor = .clear
                    placeholderLabel.isHidden = true
                }
            }
        }else{
            self.showError = false
            self.errorLabel.isHidden = true
        }
    }
    
    //MARK:-  Private Functions
    
    @objc func rightViewSelected(_ gesture: UITapGestureRecognizer){
        let textField = gesture.view?.superview as? FloatingTextField
        self.textFieldDelegate?.configureLeftView?(in: textField)
    }
    
    @objc func leftViewSelected(_ gesture: UITapGestureRecognizer){
        let textField = gesture.view?.superview as? FloatingTextField
        self.textFieldDelegate?.configureRightView?(in: textField)
    }
    
    func addViews(){
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        for subView in self.subviews{
            if subView == placeholderLabel{
                return
            }
        }
        addSubview(placeholderLabel)
        if labelText != ""{
            placeholderLabel.text = labelText
        }else{
            placeholderLabel.text = placeholder
        }
        self.floatingLabelTopConstraint = self.placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        self.floatingLabelTopConstraint.isActive = true
        self.placeholderLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.placeholderLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.floatingLabelHeightConstraint = self.placeholderLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0)
        self.floatingLabelHeightConstraint.isActive = true
        self.placeholderLabel.textAlignment = self.textAlignment
        if (text?.count)! > 0{
            self.configureLineView()
            self.textFieldDidChange(self)
            self.resignFirstResponder()
        }
        
    }
    
    func configureLineView(){
        if lineHeight != 0{
            for subview in self.subviews{
                if subview == self.lineView{
                    return
                }
            }
            if lineView != nil{
                addSubview(self.lineView!)
                lineView?.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                lineView?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                lineView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                lineHeightConstraint = lineView?.heightAnchor.constraint(equalToConstant: lineHeight)
                lineView?.backgroundColor = lineColor
                lineHeightConstraint?.isActive = true
            }
        }
    }
    
    func configureErrorLabel(){
        for subview in self.subviews{
            if subview == self.errorLabel{
                return
            }
        }
        addSubview(self.errorLabel)
        errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: lineHeight).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        errorLabel.textColor = errorColor
        errorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    open override var isSecureTextEntry: Bool{
        set{
            super.isSecureTextEntry = newValue
            
        }get{
            return super.isSecureTextEntry
        }
    }
    
    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        if labelText != ""{
            placeholderLabel.text = labelText
        }else{
            placeholderLabel.text = placeholder
        }
        if selectedLineHeight == 0{
            lineHeightConstraint?.constant = lineHeight
        }else{
            lineHeightConstraint?.constant = selectedLineHeight
        }
        self.lineView?.backgroundColor = selectedLineColor
        if let count = self.text?.count{
            if count > 0{
                self.placeholderLabel.textColor = selectedTitleColor
                if showError{
                    lineView?.backgroundColor = errorColor
                    placeholderLabel.textColor = errorColor
                }
            }
        }
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override open func resignFirstResponder() -> Bool {
        lineHeightConstraint?.constant = lineHeight
        self.lineView?.backgroundColor = lineColor
        if let count = self.text?.count{
            if count > 0{
                self.placeholderLabel.textColor = titleLabelColor
            }else{
                self.placeholderLabel.textColor = .clear
            }
            if showError{
                lineView?.backgroundColor = errorColor
                placeholderLabel.textColor = errorColor
            }
        }else{
            self.placeholderLabel.textColor = .clear
        }
        return super.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField:UITextField){
        if let text = self.text{
            if text.count > 0{
                placeholderLabel.isHidden = false
                if self.showError != false{
                    self.showError = false
                    self.placeholderLabel.textColor = self.selectedTitleColor
                    self.lineView?.backgroundColor = self.selectedLineColor
                }
                if self.floatingLabelTopConstraint.constant != -15{
                    self.floatingLabelHeightConstraint.isActive = false
                    self.floatingLabelTopConstraint.constant = -15
                    self.placeholderLabel.font = UIFont.boldSystemFont(ofSize: 12)
                    UIView.transition(with: self.placeholderLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                        self.layoutIfNeeded()
                        self.placeholderLabel.textColor = self.selectedTitleColor
                    }) { (completed) in
                        
                    }
                }
            }else{
                self.floatingLabelHeightConstraint.isActive = false
                self.floatingLabelHeightConstraint = self.placeholderLabel.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0)
                self.floatingLabelHeightConstraint.isActive = true
                self.floatingLabelTopConstraint.constant = 20
                UIView.transition(with: self.placeholderLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self.layoutIfNeeded()
                    self.placeholderLabel.font = self.font
                    self.placeholderLabel.textColor = .clear
                }) { (completed) in
                    
                }
            }
        }
    }
    
}
//Usage as below:
/***
 let textField = FloatingTextField(frame: CGRect(x:10, y: 100, width: UIScreen.main.bounds.width - 20, height: 40))
 textField.lineColor = .black
 textField.titleLabelColor = .black
 textField.lineHeight = 1
 textField.showErrorMessage("This is Text Error")
 self.view.addSubview(textField)
 **/
