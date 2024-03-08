//
//  ListOfCardsCVC.swift
//  CodeCard
//
//  Created by Vikram Kunwar on 07/03/24.
//

import UIKit

class ListOfCardsCVC: UICollectionViewCell {
    
    @IBOutlet weak var lostView: UIView!
    
    @IBOutlet weak var cardImg: UIImageView!
    
    @IBOutlet weak var cardName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        lostView.layer.cornerRadius = 15
        
        lostView.clipsToBounds = true
    }
    
}
