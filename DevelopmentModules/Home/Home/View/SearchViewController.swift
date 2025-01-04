//
//  SearchViewController.swift
//  Home
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import Foundation
import UIKit

public class SearchViewController: UIViewController, SearchViewProtocol {
    var presenter: SearchPresenterProtocol?
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var cities: [SearchResult] = []
    private var favoriteLocations: [String: Int] = [:]

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        searchBar.delegate = self
        searchBar.placeholder = "Busca tu ubicación"
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        // Configuración del layout...

        // Cargar ubicaciones favoritas al inicio
        presenter?.showFavoriteLocations()
    }

    func showCities(_ cities: [SearchResult]) {
        self.cities = cities
        tableView.reloadData()
    }

    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func showFavoriteLocations(_ favoriteLocations: [String: Int]) {
        self.favoriteLocations = favoriteLocations
        tableView.reloadData() // Actualiza la lista de ubicaciones favoritas
    }

    func showEmptyState() {
        // Mostrar lupa de búsqueda
        let emptyStateLabel = UILabel()
        emptyStateLabel.text = "Busca tu ubicación"
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        view.addSubview(emptyStateLabel)
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        presenter?.searchCities(with: query)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = "\(city.name), \(city.country)"
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectCity(cities[indexPath.row])
    }
}
