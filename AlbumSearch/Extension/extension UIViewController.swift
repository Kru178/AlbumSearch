//
//  extension UIViewController.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 13.09.2021.
//

import UIKit

extension UIViewController {
    
    public func presentAlert(withTitle title: String?, message: String?, completionHandler: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completionHandler?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
