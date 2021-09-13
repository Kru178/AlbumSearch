//
//  NetworkService.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 08.09.2021.
//

import UIKit

class NetworkService {
    
    static let shared = NetworkService()
    private let baseURL = "https://itunes.apple.com/search?"
    private let detailUrl = "https://itunes.apple.com/lookup?entity=song&id="
    
    func getResult(for name: String?, id: Int?, completed: @escaping (Result<ResultsList, ASError>) -> Void) {
        var endpoint = ""
        if let name = name {
            let end = "&country=us&entity=album&term=\(name.replaceWhitespaces())"
            endpoint = baseURL + end
        } else if let id = id {
            endpoint = detailUrl + "\(id)"
        }
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            
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
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let list = try decoder.decode(ResultsList.self, from: data)
                completed(.success(list))
            }
            catch {
                print(error)
                completed(.failure(.decoderFail))
            }
        }
        task.resume()
    }
}
