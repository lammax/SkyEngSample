//
//  DetalsModel.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import Foundation

enum Details {
    
    struct Text {
        let text: String
        let translation: String
        
        init(searchResult: Search.Result?) {
            text = searchResult?.text ?? ""
            translation = searchResult?.meanings?.first?.translation?.text ?? "no translation =("
        }
    }
    
}
