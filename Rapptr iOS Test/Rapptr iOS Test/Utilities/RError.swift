//
//  RError.swift
//  Rapptr iOS Test
//
//  Created by Bryan Gomez on 5/1/22.
//

import Foundation

enum RError: String, Error {
    case invalidUrl = "This url returned an invalid request."
    case unableToComplete = "Unable to complete your request, please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again!"
    case invalidData = "The data received from the server was invalid. Please try again."
    case thrownError = "Error was thrown"
}
