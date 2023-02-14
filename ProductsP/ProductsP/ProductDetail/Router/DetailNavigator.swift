//
//  DetailNavigator.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 14/2/23.
//

import Foundation
import UIKit

class DetailNavigator {

    var productDetail: UIViewController {
        return createProductDetailViewController()
    }
    private var sourceView: UIViewController?

    private func createProductDetailViewController() -> UIViewController {
        return ProductDetailViewController()
    }

    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }

    func goBackMenu() {
        let back = ProductsListViewController()
        sourceView?.navigationController?.pushViewController(back, animated: true)
    }
}
