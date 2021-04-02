//
//  DetailsViewModel.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import Foundation
import Combine

protocol DetailsViewModelDelegate {
    func set(searchResult: Search.Result)
    func updateView()
}

protocol DetailsViewModelDatasource {
    var viewControllerDelegate: DetailsViewControllerDelegate? { get set }
    var searchResult: Search.Result? { get set }
}

class DetailsViewModel: DetailsViewModelDatasource {
    
    var viewControllerDelegate: DetailsViewControllerDelegate?
    var searchResult: Search.Result?

    private var cancellables: [AnyCancellable] = []
    private let imagePublisher = PassthroughSubject<String, Never>()
    private let net = NetManager.shared

    init() {
        setupPublisher()
    }
    
    deinit {
        clearCancellables()
    }
    
    private func clearCancellables() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    private func setupPublisher() {
        let cancellable = imagePublisher
            .receive(on: RunLoop.main)
            .compactMap {
                self.net.fetchImage(for: $0)
            }
            .flatMap { $0 }
            .sink { image in
                self.viewControllerDelegate?.updateImage(image)
            }
        
        cancellables.append(cancellable)
    }
    
    private func updateImage() {
        if let imageUrl = searchResult?.meanings?.first?.imageUrl {
            imagePublisher.send(imageUrl)
        }
    }
    
    private func updateText() {
        viewControllerDelegate?.updateText(with: Details.Text(searchResult: searchResult))
    }

}

extension DetailsViewModel: DetailsViewModelDelegate {

    func set(searchResult: Search.Result) {
        self.searchResult = searchResult
    }
    
    func updateView() {
        updateImage()
        updateText()
    }
    
}
