//
//  HomeViewController.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // mock
    var allComics: [ComicBook] = [
        .init(id: "01", title: "Avengers", author: "Jason Aaron", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200"),
        .init(id: "02", title: "Spider-Man", author: "Henry Abrams", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200"),
        .init(id: "03", title: "Star Wars", author: "Mariko Tamaki", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200"),
        .init(id: "02", title: "Spider-Man", author: "Henry Abrams", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(
            UINib(nibName: CustomTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.setup(comicBook: allComics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController.instantiate()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        controller.comicBook = allComics[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}
