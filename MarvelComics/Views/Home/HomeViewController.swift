//
//  HomeViewController.swift
//  MarvelComics
//
//  Created by Wojciech Spaleniak on 19/10/2022.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var allComics: [ComicBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        uploadDataFromAPI()
    }
    
    private func uploadDataFromAPI() {
        ProgressHUD.show()
        NetworkService.shared.fetchComics { [weak self] result in
            switch result {
            case .success(let apiResult):
                ProgressHUD.dismiss()
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
