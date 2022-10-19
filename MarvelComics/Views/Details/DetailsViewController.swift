//
//  DetailsViewController.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var comicBookImageView: UIImageView!
    
    var comicBook: ComicBook!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        populateView()
    }
    
    @IBAction func findOutMoreBtnClicked(_ sender: UIButton) {
    }
    
    private func setupView() {
        navigationItem.largeTitleDisplayMode = .never
        title = comicBook.title
    }
    
    private func populateView() {
        titleLbl.text = comicBook.title
        authorLbl.text = comicBook.author
        descriptionLbl.text = comicBook.description
        comicBookImageView.kf.setImage(with: comicBook.image?.asUrl)
    }

}
