//
//  SearchViewController.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit
import ProgressHUD

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLbl: UILabel!
    
    // mock
    // should get data from API
    var searchComics: [ComicBook] = [
        .init(id: "01", title: "Avengers", author: "Jason Aaron", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200"),
        .init(id: "02", title: "Spider-Man", author: "Henry Abrams", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200"),
        .init(id: "03", title: "Star Wars", author: "Mariko Tamaki", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200"),
        .init(id: "04", title: "Batman", author: "Panicz Panicz", description: "This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out. This is the best comic book has ever made and I love read it everyday so dont waste my time and go out", image: "https://picsum.photos/100/200")
    ]
    
    var filteredComics: [ComicBook] = []
    
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredComics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.setup(comicBook: filteredComics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController.instantiate()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        controller.comicBook = filteredComics[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        infoLbl.text = ""
        filteredComics = []
        let text = searchText.trimmingCharacters(in: .whitespaces).lowercased()
        
        for comicBook in searchComics {
            guard let title = comicBook.title?.lowercased() else { return }
            guard let author = comicBook.author?.lowercased() else { return }
            
            if title.contains(text) || author.contains(text) {
                filteredComics.append(comicBook)
            }
        }
        if filteredComics.isEmpty {
            if text.isEmpty {
                infoLbl.text = "Start typing to find a particular comics."
            } else {
                infoLbl.text = "We didn't find such a comic book."
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
