//
//  extension Int.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 13.09.2021.
//

import Foundation

extension Int {
    
    func formatMilliesToMinutesSeconds() -> String {
        
        let minutes = Int(Double(self / 1000) / 60)
        let seconds = Int((self / 1000) % 60)
        
        return String(format:"%02d:%02d", minutes, seconds);
    }
}
