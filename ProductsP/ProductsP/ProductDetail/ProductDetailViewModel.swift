//
//  ProductDetailViewModel.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation
import RxSwift

class ProductDetailViewModel {

    private var navigator = MainNavigator()
    private var managerConnection = ManagerConnections()
    private(set) weak var view: ProductDetailViewController?

    func bind(view: ProductDetailViewController) {
        self.view = view
    }

    func getExchangeType() -> Observable<[ExchangesTypes]> {
        return managerConnection.getExchangeType()
    }

    func getTransactionType() -> Observable<[TransactionProduct]> {
        return managerConnection.getTransactionProduct()
    }

    func goBack() {
        navigator.pop()
    }
}
