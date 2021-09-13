//
//  ImageLoader.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 13.09.2021.
//

import UIKit

class ImageLoader {
    
    static let loader = ImageLoader()
    func getImage(for string: String, upscale: Bool, completed: @escaping (Result<UIImage, ASError>) -> Void) {
        var url = String()
        switch upscale {
        case false:
            url = string
        case true:
            url = string.artworkAddressCorrection()
        }
        guard let url = URL(string: url) else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            let image = UIImage(data: data)
            completed(.success(image!))
        })
        task.resume()
    }
}
