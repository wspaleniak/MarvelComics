//
//  HomeViewController.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit

class HomeViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Comics"
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        let controller = DetailsViewController.instantiate()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.pushViewController(controller, animated: true)
    }
    

}
