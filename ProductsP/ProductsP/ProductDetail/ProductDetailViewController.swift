//
//  ProductDetailViewController.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation
import UIKit
import RxSwift

class ProductDetailViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var skuProductLabel: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var amountTransactionLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var transactionTwoLabel: UILabel!
    @IBOutlet weak var amountTransactionTwoLabel: UILabel!
    @IBOutlet weak var currencyTwoLabel: UILabel!
    @IBOutlet weak var totalInfoLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var transactionTwoView: UIView!
    
    //    MARK: - Variables

    private var navigator = DetailNavigator()
    private var viewModel = ProductDetailViewModel()
    private var disposeBag = DisposeBag()
    private var exchange = [ExchangesTypes]()
    private var euroToDollar: Double = 0.0
    private var cadToEuro: Double = 0.0
    private var dollarToEuro: Double = 0.0
    private var euroToCad: Double = 0.0
    private var transaction = [TransactionProduct]()
    private var firstTransaction: Double = 0.0
    private var secondTransaction: Double = 0.0
    private var firstProduct: Double = 0.0
    private var secondProduct: Double = 0.0
    private var thirdProduct: Double = 0.0
    private var fourthProduct: Double = 0.0
    private let cellSelected = PublishSubject<Int>()

    //    MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, navigator: self.navigator)
        self.getExchanges()
        self.changeEuroToDollars()
        self.changeCadToEuro()
        self.changeDollarToEuro()
        self.changeEuroToCad()
        self.getTransactions()
        self.getTotalFirstProduct()
        self.getTotalSecondProduct()
        self.getTotalThirdProduct()
        self.getTotalFourthProduct()
        self.setupUI()
    }

    //    MARK: - Functions

    func setupUI() {
        self.detailView.layer.cornerRadius = 10
        self.totalInfoLabel.text = "TOTAL EN €"
        
        cellSelected.subscribe(onNext: { [weak self] index in
            self?.setProductToShow(index: index)
        }).disposed(by: disposeBag)
    }

    func setProductToShow(index: Int) {
        switch index {
        case 0:
            self.productImage.image = UIImage(named: "cross.circle.fill")
            self.productNameLabel.text = "Seguro de Vida"
            let product = self.transaction.filter { $0.productCode == "T2006" }
            product.forEach { product in
                self.skuProductLabel.text = product.productCode
                if product.currencyType == "USD" {
                    self.currencyLabel.text = product.currencyType
                } else {
                    self.currencyTwoLabel.text = product.currencyType
                }
            }
            self.amountTransactionLabel.text = String(self.firstTransaction)
            self.amountTransactionTwoLabel.text = String(self.secondTransaction)
            self.transactionTwoView.isHidden = false
            self.totalAmountLabel.text = String(self.firstProduct)
        case 1:
            self.productImage.image = UIImage(named: "house.fill")
            self.productNameLabel.text = "Seguro de Hogar"
            let product = self.transaction.filter { $0.productCode == "M2007" }
            product.forEach { product in
                self.skuProductLabel.text = product.productCode
                self.amountTransactionLabel.text = String(product.totalAmount)
                self.currencyLabel.text = product.currencyType
            }
            self.transactionTwoView.isHidden = true
            self.totalAmountLabel.text = String(self.secondProduct)
        case 2:
            self.productImage.image = UIImage(named: "eurosign.circle.fill")
            self.productNameLabel.text = "Préstamos personales"
            let product = self.transaction.filter { $0.productCode == "R2008" }
            product.forEach { product in
                self.skuProductLabel.text = product.productCode
                self.amountTransactionLabel.text = String(product.totalAmount)
                self.currencyLabel.text = product.currencyType
            }
            self.transactionTwoView.isHidden = true
            self.totalAmountLabel.text = String(self.thirdProduct)
        case 3:
            self.productImage.image = UIImage(named: "ellipsis.bubble.fill")
            self.productNameLabel.text = "Asesor Financiero"
            let product = self.transaction.filter { $0.productCode == "B2009" }
            product.forEach { product in
                self.skuProductLabel.text = product.productCode
                self.amountTransactionLabel.text = String(product.totalAmount)
                self.currencyLabel.text = product.currencyType
            }
            self.transactionTwoView.isHidden = true
            self.totalAmountLabel.text = String(self.fourthProduct)
        default:
            break
        }
    }

    private func getExchanges() {
        return viewModel.getExchangeType()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)

            .subscribe(
                onNext: { exchange in
                    self.exchange = exchange
                }, onError: { error in
                    print(error.localizedDescription)
                }, onCompleted: {

                }).disposed(by: disposeBag)
    }

    private func changeEuroToDollars() {
        let firstChange = self.exchange.filter { $0.formatOne == "EUR" && $0.formatTwo == "USD" }
        firstChange.forEach { operation in
            self.euroToDollar = operation.operation
        }
    }

    private func changeCadToEuro() {
        let firstChange = self.exchange.filter { $0.formatOne == "CAD" && $0.formatTwo == "EUR" }
        firstChange.forEach { operation in
            self.cadToEuro = operation.operation
        }
    }

    private func changeDollarToEuro() {
        let firstChange = self.exchange.filter { $0.formatOne == "USD" && $0.formatTwo == "EUR" }
        firstChange.forEach { operation in
            self.dollarToEuro = operation.operation
        }
    }

    private func changeEuroToCad() {
        let firstChange = self.exchange.filter { $0.formatOne == "EUR" && $0.formatTwo == "CAD" }
        firstChange.forEach { operation in
            self.euroToCad = operation.operation
        }
    }

    private func dollarToCad(price: Double) -> Double {
        let firtsStep = price * self.dollarToEuro
        let secondStep = firtsStep * self.euroToCad

        return secondStep
    }

    private func getTransactions() {
        return viewModel.getTransactionType()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)

            .subscribe(
                onNext: { transaction in
                    self.transaction = transaction
                }, onError: { error in
                    print(error.localizedDescription)
                }, onCompleted: {

                }).disposed(by: disposeBag)
    }

    private func getTotalFirstProduct() {
        let product = self.transaction.filter { $0.productCode == "T2006" }
        product.forEach { product in
            if product.currencyType == "USD" {
                self.firstTransaction = product.totalAmount
            } else {
                self.secondTransaction = product.totalAmount
            }
            self.firstProduct = (firstTransaction * self.dollarToEuro) + secondTransaction
        }
    }

    private func getTotalSecondProduct() {
        let product = self.transaction.filter { $0.productCode == "M2007" }
        product.forEach { product in
            self.secondProduct = product.currencyType == "CAD" ? product.totalAmount * self.cadToEuro : product.totalAmount
        }
    }

    private func getTotalThirdProduct() {
        let product = self.transaction.filter { $0.productCode == "R2008" }
        product.forEach { product in
            self.thirdProduct = product.currencyType == "USD" ? product.totalAmount * self.dollarToEuro : product.totalAmount
        }
    }

    private func getTotalFourthProduct() {
        let product = self.transaction.filter { $0.productCode == "B2009" }
        product.forEach { product in
            self.fourthProduct = product.currencyType == "USD" ? product.totalAmount * self.dollarToEuro : product.totalAmount
        }
    }

    // MARK: - @IBActions

    @IBAction func backButtonAction(_ sender: Any) {
        viewModel.goBack()
    }
    
}
