//
//  ProductsListViewModel.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation

class ProductsListViewModel {

    private weak var view: ProductsListViewController?
    private var navigator = MainNavigator()

    func bind(view: ProductsListViewController) {
        self.view = view
    }

    func goToProductDetail() {
        self.navigator.toProductDetail()
    }
}
