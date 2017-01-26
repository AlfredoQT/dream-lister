//
//  MaterialView.swift
//  DreamLister
//
//  Created by Alfredo Quintero Tlacuilo on 1/25/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit

//By default it won't be selecting the material design option for this
private var materialKey = false

//Anything that inherits from UIView will also have the ability to add the following styling
extension UIView {

    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        }
        
        set {
            //A person can decide whether to have the material design in that view
            materialKey = newValue
            
            if materialKey{
                self.layer.masksToBounds = false
                //For rounding
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            }
            else {
                self.layer.cornerRadius = 0.0
                self.layer.shadowOpacity = 0.0
                self.layer.shadowRadius = 0.0
                self.layer.shadowColor = nil
            }
        }
    }

}
