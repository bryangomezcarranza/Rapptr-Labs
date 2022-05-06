//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import UIKit

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
*/

class LoginClient {

    static let shared = LoginClient()
    
    private let baseUrl = "https://dev.rapptrlabs.com/Tests/scripts/login.php"
    private let emailKey = "email"
    private let passwordKey = "password"
    
    
    func login(email: String, password: String, completion: @escaping (Result<String?, RError>) -> Void) {
        
        guard let baseUrl = URL(string: baseUrl) else { return }

        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        let emailQuery = URLQueryItem(name: emailKey , value: email)
        let passwordQuery = URLQueryItem(name: passwordKey, value: password)
        components?.queryItems = [emailQuery, passwordQuery]

        guard let finalUrl = components?.url else { return completion(.failure(.invalidUrl))}

        let task = URLSession.shared.dataTask(with: finalUrl) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError))
                print(error)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success("Sucess, \(data) was found!"))
        }
        task.resume()
    }
}
