//
//  ProductsListViewController.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation
import UIKit
import RxSwift

class ProductsListViewController: UIViewController {

    // MARK: - Variables

    private var navigator = MainNavigator()
    private var viewModel = ProductsListViewModel()
    private var product = ProductsListModel()
    private let cellSelected = PublishSubject<Int>()
    
    // MARK: - IBOutlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Functions

    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.viewModel.bind(view: self, navigator: self.navigator)
        setupUI()
        setupTableView()
        self.tableView.reloadData()
    }

    private func setupUI() {
        self.titleLabel.text = "Goliath National Bank"
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.layer.cornerRadius = 5
    }
}

// MARK: - TableView extension

extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.product.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductsListCellView.self)) as! ProductsListCellView
        product.products.forEach { product in
            cell.productNameLabel.text = product
        }
        product.imageProducts.forEach { image in
            cell.productImage.image = UIImage(named: image)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected.onNext(indexPath.row)
    }
}
