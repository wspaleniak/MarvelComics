//
//  String+Extension.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import Foundation

extension String {
    
    var asUrl: URL? {
        return URL(string: self)
    }
}
