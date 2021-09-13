//
//  extension ImageView.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 13.09.2021.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: String, upscale: Bool, activity: UIActivityIndicatorView?) {
        ImageLoader.loader.getImage(for: url, upscale: upscale) {  result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    activity?.stopAnimating()
                    activity?.isHidden = true
                    self.image = image
                }
            }
        }
    }
}
