//
//  ASError.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 09.09.2021.
//

import Foundation

enum ASError: String, Error {
    
    case invalidUrl = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid."
    case decoderFail = "Can't decode the data"
}
