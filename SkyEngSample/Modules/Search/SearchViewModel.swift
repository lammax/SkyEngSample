//
//  SearchViewModel.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import Foundation
import Combine

protocol SearchViewModelDelegate {
    func search(text: String)
    func getCellData(for indexPath: IndexPath) -> Search.CellData
    func getSearchResult(for indexPath: IndexPath) -> Search.Result
}

protocol SearchViewModelDatasource {
    var viewControllerDelegate: SearchViewControllerDelegate? { get set }
    var tableData: [Search.Result] { get set }
}

class SearchViewModel: SearchViewModelDatasource {
    
    //MARK: SearchViewModelDatasource
    var viewControllerDelegate: SearchViewControllerDelegate?
    var tableData: [Search.Result] = [] {
        didSet {
            self.viewControllerDelegate?.updateTable()
        }
    }

    private var cancellables: [AnyCancellable] = []
    
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    private let net = NetManager.shared
    
    deinit {
        clearCancellables()
    }
    
    private func setupPublisher(completion: (() -> Void)? = nil) {
        guard cancellables.count == 0 else { completion?(); return }
        let cancellable = searchTextPublisher
            .receive(on: RunLoop.main)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .compactMap {
                self.net.search(for: $0)
            }
            .flatMap { $0 }
            .sink { searchResults in
                self.tableData = searchResults
            }
        
        cancellables.append(cancellable)
        completion?()
    }
    
    private func clearCancellables() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
}

extension SearchViewModel: SearchViewModelDelegate {

    func search(text: String) {
        guard text.count > 0 else {
            self.tableData = []
            self.clearCancellables()
            return
        }
        setupPublisher {
            self.searchTextPublisher.send(text)
        }
    }
    
    func getCellData(for indexPath: IndexPath) -> Search.CellData {
        Search.CellData(searchResult: getSearchResult(for: indexPath))
    }
    
    func getSearchResult(for indexPath: IndexPath) -> Search.Result {
        tableData[indexPath.row]
    }
    
}
