//
//  DetailsViewController.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import UIKit

protocol DetailsViewControllerDelegate {
    func updateText(with text: Details.Text)
    func updateImage(_ image: UIImage?)
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var viewModel: (DetailsViewModelDelegate & DetailsViewModelDatasource) = DetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewControllerDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateView()
    }
    
    func set(searchResult: Search.Result) {
        viewModel.set(searchResult: searchResult)
    }
    
}

extension DetailsViewController: DetailsViewControllerDelegate {
    func updateText(with text: Details.Text) {
        textLabel.text = text.text
        translationLabel.text = text.translation
    }
    
    func updateImage(_ image: UIImage?) {
        self.imageView.image = image
    }
}
