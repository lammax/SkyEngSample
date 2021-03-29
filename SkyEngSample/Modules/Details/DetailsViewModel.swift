//
//  DetailsViewModel.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import Foundation

protocol DetailsViewModelDelegate {
    func doSmth()
}

protocol DetailsViewModelDatasource {
    var viewControllerDelegate: DetailsViewControllerDelegate? { get set }
}

class DetailsViewModel: DetailsViewModelDatasource {
    
    var viewControllerDelegate: DetailsViewControllerDelegate?
    
}

extension DetailsViewModel: DetailsViewModelDelegate {

    func doSmth() {
        print("Smth")
    }
    
}
