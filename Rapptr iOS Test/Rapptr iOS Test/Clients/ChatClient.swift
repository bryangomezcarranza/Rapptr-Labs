//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import UIKit

class ChatClient {
    
    static let shared = ChatClient()
    let cache = NSCache<NSString, UIImage>()
    
    let baseUrl = "https://dev.rapptrlabs.com/Tests/scripts/chat_log.php"
    
    
    func fetchChatData(completion: @escaping (Result<[MessageData]?, RError>) -> Void) {
        let endPoint = baseUrl
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.thrownError))
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
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(Message.self, from: data)
                let chatData = data.data
                completion(.success(chatData))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    // Donwloads Image
    func downloadImage(from url: String, completion: @escaping(Result<UIImage?, RError>) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
            return
        }
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                completion(.failure(.invalidUrl))
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let profilePhoto = UIImage(data: data) else {
                completion(.failure(.unableToComplete))
                return
            }
            self.cache.setObject(profilePhoto, forKey: cacheKey)
            completion(.success(profilePhoto))
        }
        task.resume()
    }
}
