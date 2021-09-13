//
//  extension UIView.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 13.09.2021.
//

import UIKit

extension UIView {
    
    func addShadow() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 7
    }
}

