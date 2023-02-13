//
//  MainNavigator.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 11/2/23.
//

import UIKit

class MainNavigator {

    private var sourceView: UIViewController?

    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }

    func  toProductDetail() {
//        let detailView = ProductDetailViewModel().viewController
//        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }

    func pop(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
