//
//  ProductDetailViewModel.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation
import RxSwift

class ProductDetailViewModel {

    private var managerConnection = ManagerConnections()
    private(set) weak var view: ProductDetailViewController?
    private var navigator: DetailNavigator?

    func bind(view: ProductDetailViewController, navigator: DetailNavigator) {
        self.view = view
        self.navigator = navigator
    }

    func getExchangeType() -> Observable<[ExchangesTypes]> {
        return managerConnection.getExchangeType()
    }

    func getTransactionType() -> Observable<[TransactionProduct]> {
        return managerConnection.getTransactionProduct()
    }

    func goBack() {
        self.navigator?.goBackMenu()
    }
}
