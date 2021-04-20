//
//  File.swift
//  
//
//  Created by Reza Khonsari on 4/20/21.
//

import UIKit

class OTPTextField: UITextField {
    
    
    var borderHeight: CGFloat = 1
    var bottomBorder = CALayer()
    
    var borderColor: UIColor = .red { didSet { bottomBorder.backgroundColor = borderColor.cgColor} }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        layer.addSublayer(bottomBorder)
        bottomBorder.backgroundColor = borderColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder.frame = .init(x: .zero, y: frame.maxY, width: bounds.width, height: borderHeight)
    }
}
