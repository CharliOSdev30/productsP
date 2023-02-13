//
//  ManagerConnections.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation
import RxSwift

class ManagerConnections {

    func getExchangeType() -> Observable<[ExchangesTypes]> {

        return Observable.create { observer in

        let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.mainURL.main + Constants.EndPoints.exchange)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let exchange = try decoder.decode(Exchange.self, from: data)

                    observer.onNext(exchange.exchangeType)
                } catch let error {
                    observer.onError(error)
                    print(error)
                }
            } else if response.statusCode == 401 {
                print("Error 401")
            }
            observer.onCompleted()
            }.resume()
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }

    func getTransactionProduct() -> Observable<[TransactionProduct]> {
        
        return Observable.create { observer in

        let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.mainURL.main + Constants.EndPoints.transactions)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let transaction = try decoder.decode(Transactions.self, from: data)

                    observer.onNext(transaction.transactionProduct)
                } catch let error {
                    observer.onError(error)
                    print(error)
                }
            } else if response.statusCode == 401 {
                print("Error 401")
            }
            observer.onCompleted()
            }.resume()
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
}
