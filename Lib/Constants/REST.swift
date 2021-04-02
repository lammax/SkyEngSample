//
//  REST.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 01.04.2021.
//

import Foundation

enum REST {
    
    enum EndPoint: String {
        case search = "https://dictionary.skyeng.ru/api/public/v1/words/search"
        case image = "https:"
    }
    
    struct URLS {
        
        func getEndPoint(for endPoint: REST.EndPoint, text: String?) -> URL? {
            guard let text = text else { return nil }
            
            var urlPath: String = ""
            
            switch endPoint {
            case .search:
                urlPath = endPoint.rawValue + "?search=" + text
            case .image:
                urlPath = endPoint.rawValue + text
            }
            
            print(urlPath)
            
            return URL(string: urlPath)
        }
        
    }
    
}
