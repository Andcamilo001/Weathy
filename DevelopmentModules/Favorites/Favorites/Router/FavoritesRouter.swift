//
//  FavoritesRouter.swift
//  Favorites
//
//  Created by Andres Camilo Lezcano Restrepo on 4/01/25.
//

import Foundation
import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    func navigateToCityDetail(_ city: FavoritesLoad)
}

public class FavoritesRouter: FavoritesRouterProtocol {
    weak var viewController: UIViewController?

    public static func createModule() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view

        return view
    }

    func navigateToCityDetail(_ city: FavoritesLoad) {
        // Implementar la navegación a detalle
    }
}
