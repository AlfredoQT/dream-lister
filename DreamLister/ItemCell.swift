//
//  ItemCell.swift
//  DreamLister
//
//  Created by Alfredo Quintero Tlacuilo on 1/27/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    func configureCell(item: Item){
        priceLbl.text = "$\(item.price)"
        detailsLbl.text = item.details
        titleLbl.text = item.title
    }
}
