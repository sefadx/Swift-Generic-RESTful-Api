//
//  APIServices.swift
//  iOS Restful Api
//
//  Created by Sefa DİNÇER on 31.10.2022.
//

import Foundation

struct APIServices {
    let urlString: String
    
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               completion: @escaping (Result<T,APIError>) -> Void ) {
        guard
            let url = URL(string: urlString)
        else{
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            
            guard
                error == nil
            else{
                completion(.failure(.taskError(error!.localizedDescription)))
                return
            }
            
            guard
                let data = data
            else {
                completion(.failure(.dataError))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do{
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }catch{
                completion(.failure(.decodeDataError(error.localizedDescription)))
            }
            
        }.resume()
    }
    
}

enum APIError : Error, LocalizedError{
    case invalidUrl
    case invalidResponseStatus
    case taskError(String)
    case dataError
    case decodeDataError(String)
    
    var errorDescription: String?{
        switch self {
        case .invalidUrl:
            return NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The API failed to issue a valid response", comment: "")
        case .taskError(let string):
            return string
        case .dataError:
            return NSLocalizedString("The data provided appears to be corrupt", comment: "")
        case .decodeDataError(let string):
            return string
        }
    }
}
