//
//  LeagueTableViewCell.swift
//  SportsApp
//
//  Created by Nasr on 23/02/2022.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    static var identifier = "LeagueCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var youtubeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
