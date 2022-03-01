//
//  FavoritesTableViewCell.swift
//  SportsApp
//
//  Created by Nasr on 01/03/2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var youTubeButton: UIButton!
    
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
