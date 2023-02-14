//
//  MainNavigator.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 11/2/23.
//

import UIKit

class MainNavigator {

    var productsList: UIViewController {
        return createProductsListViewController()
    }
    var productDetail: UIViewController {
        return createProductDetailViewController()
    }
    private var sourceView: UIViewController?

    private func createProductsListViewController() -> UIViewController {
        return ProductsListViewController()
    }

    private func createProductDetailViewController() -> UIViewController {
        return ProductDetailViewController()
    }

    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }

    func toProductDetail() {
        sourceView?.navigationController?.pushViewController(productDetail, animated: true)
    }

    func pop() {
        sourceView?.navigationController?.pushViewController(productsList, animated: true)
    }
}
