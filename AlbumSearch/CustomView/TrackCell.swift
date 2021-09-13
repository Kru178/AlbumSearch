//
//  TrackCell.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 11.09.2021.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackNumberLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func setup(with entityArray: [iTunesEntity], indexPath: IndexPath) {

        let track = entityArray[indexPath.row]
        trackNumberLabel.text = "\(indexPath.row + 1)"
        trackNumberLabel.textColor = .lightGray
        trackNameLabel.text = track.trackName
        durationLabel.text = track.trackTimeMillis?.formatMilliesToMinutesSeconds()
        durationLabel.textColor = .lightGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        trackNumberLabel.text = nil
        trackNameLabel.text = nil
        durationLabel.text = nil
    }
}
