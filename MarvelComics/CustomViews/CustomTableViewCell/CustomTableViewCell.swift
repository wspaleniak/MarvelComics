//
//  CustomTableViewCell.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {

    static let identifier = String(describing: CustomTableViewCell.self)
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var comicBookImageView: UIImageView!
    
    
    func setup(comicBook: ComicBook) {
        titleLbl.text = comicBook.title
        authorLbl.text = comicBook.author
        descriptionLbl.text = comicBook.description
        comicBookImageView.kf.setImage(with: comicBook.image?.asUrl)
    }
    
}
