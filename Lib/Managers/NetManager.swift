//
//  NetManager.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 01.04.2021.
//

import Foundation
import Combine
import UIKit

class NetManager {
    
    static let shared = NetManager()
    
    func search(for text: String?) -> AnyPublisher<[Search.Result], Never>? {
        
        guard let url = REST.URLS().getEndPoint(for: .search, text: text) else { return nil }
        let searchPublisher: AnyPublisher<[Search.Result]?, Error> = NetService.fetchDecodable(url: url)
            
        return searchPublisher
            .catch { error in Just([]) }
            .compactMap { $0 }
            .eraseToAnyPublisher()
            
    }
    
    func fetchImage(for text: String?) -> AnyPublisher<UIImage?, Never>? {
        
        guard let url = REST.URLS().getEndPoint(for: .image, text: text) else { return nil }
        let searchPublisher: AnyPublisher<UIImage?, Never> = NetService.fetchImage(url: url)

        return searchPublisher
            
    }
    

}
