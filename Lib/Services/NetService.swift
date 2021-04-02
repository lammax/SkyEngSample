//
//  NetService.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 01.04.2021.
//

import Foundation
import Combine
import UIKit

class NetService {
    
    class func fetchDecodable<T: Decodable>(url: URL) -> AnyPublisher<T?, Error> {
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    class func fetchImage(url: URL) -> AnyPublisher<UIImage?, Never> {

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .catch { _ in Just(nil) }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}
