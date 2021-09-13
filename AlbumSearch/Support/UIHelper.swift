//
//  UIHelper.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 08.09.2021.
//

import UIKit

enum UIHelper {
    
    static func createOneColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 20
        let availableWidth = width - (padding * 2)
        let itemWidth = availableWidth
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 90)
        flowLayout.minimumLineSpacing = padding
        
        return flowLayout
    }
}
