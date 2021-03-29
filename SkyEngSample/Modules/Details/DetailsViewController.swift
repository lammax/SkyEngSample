//
//  DetailsViewController.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func doSmth()
}

class DetailsViewController: UIViewController {
    
    private var viewModel: (DetailsViewModelDelegate & DetailsViewModelDatasource) = DetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewControllerDelegate = self
    }
    
}

extension DetailsViewController: DetailsViewControllerDelegate {
    func doSmth() {
        print("")
    }
}
