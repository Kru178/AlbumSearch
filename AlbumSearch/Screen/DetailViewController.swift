//
//  DetailViewController.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 10.09.2021.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var artworkView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    var albumId: Int?
    var tracks = [iTunesEntity]()
    var album: iTunesEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadAlbum(for: albumId)
    }
    
    func loadAlbum(for id: Int?) {
        guard let id = albumId else { return }
        NetworkService.shared.getResult(for: nil, id: id, completed: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.presentAlert(withTitle: "Error", message: "Couldn't load album")
                case .success(let list):
                    self.checkTracks(of: list.results)
                }
            }
        })
    }
    
    func checkTracks(of list: [iTunesEntity]) {
        list.forEach { album in
            if album.wrapperType == "collection" {
                self.album = album
            } else {
                self.tracks.append(album)
            }
        }
        setupView(with: album)
    }
    //    MARK: - Setup View

    func setupView(with album: iTunesEntity?) {
        guard let album = album else { return }
        artistLabel.text = album.artistName
        albumLabel.text = album.collectionName
        genreLabel.text = album.primaryGenreName + Constants.roundSeparator + album.releaseDate.convertToYear()
        artworkImageView.loadImage(at: album.artworkUrl100, upscale: true, activity: activityIndicator)
        tableHeight.constant = CGFloat(Double(tracks.count) * 43.5)
        tracksTableView.reloadData()
    }
    //    MARK: - Cofigure View

    func configureView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        artworkView.addShadow()
        artworkImageView.layer.cornerRadius = 7
        tracksTableView.allowsSelection = false
        tracksTableView.separatorInset.left = 50
        tracksTableView.contentInset.left = 0
        artistLabel.textColor = .red
        genreLabel.textColor = .lightGray
    }
    
    //    MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tracksTableView.dequeueReusableCell(withIdentifier: CellId.trackCell, for: indexPath) as! TrackCell
        cell.setup(with: tracks, indexPath: indexPath)
        return cell
    }
}
