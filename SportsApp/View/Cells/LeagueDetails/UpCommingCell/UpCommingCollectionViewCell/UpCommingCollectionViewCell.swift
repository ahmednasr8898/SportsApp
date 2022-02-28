//
//  UpCommingCollectionViewCell.swift
//  SportsApp
//
//  Created by Nasr on 24/02/2022.
//

import UIKit

class UpCommingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var matchTimeLabel: UILabel!
    @IBOutlet weak var matchDateLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    static var idenifier = "UpCommingCollectionViewCell"
    
    static func nib()-> UINib{
        return UINib(nibName: "UpCommingCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
