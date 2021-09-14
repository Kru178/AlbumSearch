//
//  ViewController.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 08.09.2021.
//

import UIKit

class AlbumsViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var albums = [iTunesEntity]()
    var selectedId: Int?
    var searched = [String]()
    static var searchData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkHistorySearch()
        checkSavedSearch()
    }
    
    func checkHistorySearch() {
        if AlbumsViewController.searchData != "" {
            loadAlbums(for: AlbumsViewController.searchData)
            AlbumsViewController.searchData = ""
        } else if searched.isEmpty {
            albumsCollectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func checkSavedSearch() {
        if let savedSearch = UserDefaults.standard.object(forKey: Constants.defaultsKey) as? [String] {
            searched  = savedSearch
        } else {
            searched = [""]
        }
    }
    
    //    MARK: - Load data
    
    func loadAlbums(for keyword: String) {
        if keyword.trimmingCharacters(in: .whitespaces).isEmpty {
            presentAlert(withTitle: "Empty Search", message: "Please type something") {
                return
            }
        }
        albums.removeAll()
        NetworkService.shared.getResult(for: keyword, id: nil) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    if list.resultCount == 0 {
                        self.presentAlert(withTitle: "Oops!", message: "We couldn't find anything. Please try something else.") { return }
                    } else {
                        for album in list.results {
                            self.albums.append(album)
                            self.navigationItem.title = keyword
                        }
                    }
                case .failure(let error):
                    print(error)
                }
                self.albums.sort {
                    $0.collectionName < $1.collectionName
                }
                self.albumsCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    //    MARK: - Configure View
    
    func configureView() {
        albumsCollectionView.collectionViewLayout = UIHelper.createOneColumnFlowLayout(in: view)
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.tintColor = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Search"
    }
    
    //    MARK: - Collectionview Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.albumCell, for: indexPath) as! AlbumCell
        cell.setup(with: albums, indexPath: indexPath)
        return cell
    }
    
    //    MARK: - Collectionview Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedId = albums[indexPath.item].collectionId
        performSegue(withIdentifier: Constants.detailSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailViewController
        detailVC?.albumId = selectedId
        navigationItem.backButtonTitle = ""
    }
    
    //    MARK: - Searchbar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        loadAlbums(for: searchBar.text!)
        searchBar.endEditing(true)
        searched.insert(searchBar.text!, at: 0)
        UserDefaults.standard.setValue(searched, forKey: Constants.defaultsKey)
        searchBar.text = nil
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        func cancelTask() {
            URLSession.shared.getAllTasks { tasks in
                for task in tasks {
                    print(task)
                    task.cancel()
                }
            }
        }
    }
}


