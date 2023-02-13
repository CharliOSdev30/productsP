//
//  ProductsListCellView.swift
//  ProductsP
//
//  Created by carlos.gonzalezc.local on 9/2/23.
//

import Foundation
import UIKit

class ProductsListCellView: UITableViewCell {

    // MARK: - IBOutlet
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var goDetailButton: UIButton!

    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
