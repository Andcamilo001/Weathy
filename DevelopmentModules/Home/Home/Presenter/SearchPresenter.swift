//
//  SearchPresenter.swift
//  Home
//
//  Created by Andres Camilo Lezcano Restrepo on 3/01/25.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    func searchCities(with query: String)
    func didSelectCity(_ city: SearchResult)
    func showFavoriteLocations()
}

protocol SearchViewProtocol: AnyObject {
    func showCities(_ cities: [SearchResult])
    func showError(_ error: String)
    func showFavoriteLocations(_ favoriteLocations: [String: Int])
    func showEmptyState()
}

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?

    func searchCities(with query: String) {
        if query.isEmpty {
            view?.showEmptyState()
        } else {
            interactor?.searchCities(with: query)
        }
    }

    func didSelectCity(_ city: SearchResult) {
        interactor?.incrementFavoriteLocation(cityName: city.name, countryName: city.country)
        router?.navigateToCityDetail(city)
    }

    func showFavoriteLocations() {
        let favoriteLocations = interactor?.getFavoriteLocations() ?? [:]
        view?.showFavoriteLocations(favoriteLocations)
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func didRetrieveCities(_ cities: [SearchResult]) {
        view?.showCities(cities)
    }

    func didFailWithError(_ error: Error) {
        view?.showError(error.localizedDescription)
    }

    func didRetrieveFavoriteLocations(_ favoriteLocations: [String: Int]) {
        view?.showFavoriteLocations(favoriteLocations)
    }
}
