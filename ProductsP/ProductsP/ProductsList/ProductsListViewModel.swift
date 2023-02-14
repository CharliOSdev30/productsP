//
//  ProductsListViewModel.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation

class ProductsListViewModel {

    private weak var view: ProductsListViewController?
    private var navigator: HomeNavigator?

    func bind(view: ProductsListViewController, navigator: HomeNavigator) {
        self.view = view
        self.navigator = navigator
    }

    func goToProductDetail() {
        self.navigator?.toProductDetail()
    }
}
