//
//  UIView+Extension.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set { self.layer.cornerRadius = newValue}
    }
}
