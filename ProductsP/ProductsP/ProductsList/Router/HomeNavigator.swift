//
//  HomeNavigator.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 14/2/23.
//

import Foundation
import UIKit

class HomeNavigator {

    var productsList: UIViewController {
        return createProductsListViewController()
    }
    private var sourceView: UIViewController?

    private func createProductsListViewController() -> UIViewController {
        return ProductsListViewController()
    }

    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }

    func toProductDetail() {
        let detailView = ProductDetailViewController()
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
