//
//  extension String.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 13.09.2021.
//

import Foundation

extension String {
    
    func artworkAddressCorrection() -> String {
        return String(self.dropLast(13)) + "600x600bb.jpg"
    }
    
    func convertToYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Release date unknown"
        }
    }
    
    func replaceWhitespaces() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
}
