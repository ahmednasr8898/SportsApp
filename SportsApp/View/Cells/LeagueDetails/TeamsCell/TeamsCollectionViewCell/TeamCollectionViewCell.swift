//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    static var identifier = "TeamCollectionViewCell"
    static func nib ()->UINib{
        return UINib(nibName: "TeamCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
