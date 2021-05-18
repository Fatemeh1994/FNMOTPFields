//
//  File.swift
//  
//
//  Created by Reza Khonsari on 4/20/21.
//

import UIKit

public class OTPTextField: UITextField {
    
    var layout: Layout = .bottomBorder
    
    var borderRadius: CGFloat = .zero
    var borderHeight: CGFloat = 1
    var bottomBorder = CALayer()
    
    var borderColor: UIColor = .red {
        didSet {
            switch layout {
            case .bottomBorder:
                bottomBorder.backgroundColor = borderColor.cgColor
            case .fullBorder:
                layer.borderColor = borderColor.cgColor
            }
        }
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
        switch layout {
        case .bottomBorder:
            layer.addSublayer(bottomBorder)
            bottomBorder.backgroundColor = borderColor.cgColor
        case .fullBorder:
            layer.borderWidth = borderHeight
            layer.borderColor = borderColor.cgColor
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        switch layout {
        case .bottomBorder:
            bottomBorder.frame = .init(x: .zero, y: frame.maxY, width: bounds.width, height: borderHeight)
            bottomBorder.cornerRadius = borderRadius
        case .fullBorder:
            layer.borderWidth = borderHeight
        }
    }
}

public extension OTPTextField {
    enum Layout {
        case bottomBorder
        case fullBorder
    }
}
