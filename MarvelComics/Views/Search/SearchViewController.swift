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
    var allComics: [ComicBook] = []
    var filteredComics: [ComicBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        registerCells()
        uploadDataFromAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func uploadDataFromAPI() {
        NetworkService.shared.fetchComics { [weak self] result in
            switch result {
            case .success(let apiResult):
                
                guard let comics = apiResult.results else {
                    return
                }
                
                for i in 0..<comics.count {
                    
                    let title = comics[i].title ?? "Unknown title"
                    var author: String
                    let authors = comics[i].creators.items ?? []
                    if !authors.isEmpty {
                        author = "writer: Unknown\n\(authors[0].author)"
                        for item in authors {
                            if let writer = item.writer { author = writer }
                        }
                    } else { author = "writer: Unknown" }
                    let description = comics[i].description ?? "We have no description for this comic book."
                    let image = comics[i].thumbnail?.urlString ?? "Without image"
                    
                    self?.allComics.append(ComicBook(id: "00", title: title, author: author, description: description, image: image))
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        
        for comicBook in allComics {
            guard let title = comicBook.title?.lowercased() else { return }
            if title.contains(text) {
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
