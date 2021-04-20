//
//  OTPView.swift
//  FNMOTPFields
//
//  Created by Reza Khonsari on 5/28/20.
//  Copyright © 2020 Reza Khonsari. All rights reserved.
//

import UIKit

public class FNMOTPFields: UIView {
    
    public var otpDidChange: ((String)->())?
    public var currentOTP = ""
    
    private var textFields = [OTPTextField]()
    @IBInspectable
    public var borderColor: UIColor = .red {
        didSet {
            textFields.forEach { $0.borderColor = borderColor }
        }
    }
    
    @IBInspectable
    public var borderHeight: CGFloat = 1 {
        didSet {
            textFields.forEach { $0.borderHeight = borderHeight }
        }
    }
    
    @IBInspectable
    public var numberOfOTP: Int = 6 {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable
    public var showKeyboardOnLaunch: Bool = false { didSet { if showKeyboardOnLaunch { textFields.first?.becomeFirstResponder() } } }
    
    
    private func setLayout() {
        textFields = []
        mainStackView.arrangedSubviews.forEach {
            mainStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        mainStackView.invalidateIntrinsicContentSize()

        for index in 0..<numberOfOTP {
            let textField = OTPTextField()
            textField.delegate = self
            textField.backgroundColor = .clear
            textField.textAlignment = .center
            textField.keyboardType = .asciiCapableNumberPad
            if #available(iOS 12.0, *) {
                textField.textContentType = .oneTimeCode
            } else {
                textField.textContentType = .none
            }
            textField.borderHeight = borderHeight
            textField.borderColor = borderColor
            textFields.append(textField)
            mainStackView.addArrangedSubview(textField)
            if index == .zero, showKeyboardOnLaunch {
                textField.becomeFirstResponder()
            }
        }
    }
    
    private var mainStackView = UIStackView() .. {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 16
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        setLayout()
    }
    
}

extension FNMOTPFields: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        
        if let index = textFields.firstIndex(of: textField as! OTPTextField) {
            if index == textFields.indices.last {
                textField.resignFirstResponder()
            } else {
                textFields[index + 1].becomeFirstResponder()
            }
        }
        
        if let text = textField.text {
            let currentString = (text as NSString).replacingCharacters(in: range, with: string) as NSString
            textField.text = currentString as String
            let value = textFields.map { $0.text! }.joined()
            otpDidChange?(value)
            currentOTP = value
            return currentString.length <= 1
        } else {
            return false
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}


