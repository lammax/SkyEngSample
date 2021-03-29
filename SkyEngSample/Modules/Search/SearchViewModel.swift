//
//  SearchViewModel.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import Foundation

protocol SearchViewModelDelegate {
    func doSmth()
}

protocol SearchViewModelDatasource {
    var viewControllerDelegate: SearchViewControllerDelegate? { get set }
}

class SearchViewModel: SearchViewModelDatasource {
    
    var viewControllerDelegate: SearchViewControllerDelegate?
    
    
}

extension SearchViewModel: SearchViewModelDelegate {

    func doSmth() {
        print("Smth")
    }
    
}
