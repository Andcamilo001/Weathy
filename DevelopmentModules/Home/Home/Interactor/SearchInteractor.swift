//
//  SearchInteractor.swift
//  Home
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import Foundation
import NetworkInterface

protocol SearchInteractorInputProtocol: AnyObject {
    func searchCities(with query: String)
    func getFavoriteLocations() -> [String: Int]
    func incrementFavoriteLocation(cityName: String, countryName: String)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    func didRetrieveCities(_ cities: [SearchResult])
    func didFailWithError(_ error: Error)
    func didRetrieveFavoriteLocations(_ favoriteLocations: [String: Int])
}

class SearchInteractor: SearchInteractorInputProtocol {
    weak var presenter: SearchInteractorOutputProtocol?
    private let network: NetWorkInterface
    private let apiKey: String
    private var favoriteLocations: FavoriteLocation = [:]

    init(network: NetWorkInterface, apiKey: String) {
        self.network = network
        self.apiKey = apiKey
    }

    func searchCities(with query: String) {
        let url = "https://api.weatherapi.com/v1/search.json"
        let parameters: [String: Any] = ["key": apiKey, "q": query]

        network.performRequest(
            url: url,
            method: .get,
            parameters: parameters,
            headers: nil
        ) { (result: Result<[SearchResult], NetworkError>) in
            switch result {
            case .success(let cities):
                self.presenter?.didRetrieveCities(cities)
            case .failure(let error):
                self.presenter?.didFailWithError(error)
            }
        }
    }

    func getFavoriteLocations() -> [String: Int] {
        return favoriteLocations
    }

    func incrementFavoriteLocation(cityName: String, countryName: String) {
        let key = "\(cityName), \(countryName)"
        if let count = favoriteLocations[key] {
            favoriteLocations[key] = count + 1
        } else {
            favoriteLocations[key] = 1
        }
        // Notify presenter to update the favorites view
        presenter?.didRetrieveFavoriteLocations(favoriteLocations)
    }
}
