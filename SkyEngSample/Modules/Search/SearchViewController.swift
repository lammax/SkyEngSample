//
//  ViewController.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import UIKit
import Combine

protocol SearchViewControllerDelegate {
    func updateTable()
}

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var currentCancellable: AnyCancellable?
    var currentPublisher: AnyPublisher<UISearchBar, Error>?
    
    private var viewModel: (SearchViewModelDelegate & SearchViewModelDatasource) = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
    }

    private func setupDelegates() {
        viewModel.viewControllerDelegate = self
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellData = viewModel.getCellData(for: indexPath)
        
        cell.textLabel?.text = cellData.text
        cell.detailTextLabel?.text = cellData.detailedText
        
        return cell
    }
    
    private func showDetails(for indexPath: IndexPath) {
        //MARK: here, best practice is to use Router, but App is small, so let's pass it
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        detailsVC.set(searchResult: viewModel.getSearchResult(for: indexPath))
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

}

extension SearchViewController: SearchViewControllerDelegate {
    func updateTable() {
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.search(text: searchText)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(for: indexPath)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        setupCell(for: indexPath)
    }
}
