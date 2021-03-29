//
//  ViewController.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import UIKit

protocol SearchViewControllerDelegate {
    func doSmth()
}

class SearchViewController: UIViewController {

    private var viewModel: (SearchViewModelDelegate & SearchViewModelDatasource) = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewControllerDelegate = self
    }
    
    
    

}

extension SearchViewController: SearchViewControllerDelegate {
    func doSmth() {
        print("")
    }
}
