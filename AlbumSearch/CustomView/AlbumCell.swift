//
//  AlbumCell.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 08.09.2021.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNamelabel: UILabel!
    
    func setup(with entityArray: [iTunesEntity], indexPath: IndexPath) {
        
        let album = entityArray[indexPath.item]
        artistNameLabel.text = album.artistName + Constants.roundSeparator + album.releaseDate.convertToYear()
        albumNamelabel.text = album.collectionName
        
        imageView.loadImage(at: album.artworkUrl100, upscale: false, activity: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        artistNameLabel.text = nil
        albumNamelabel.text = nil
    }
}
