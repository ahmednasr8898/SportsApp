//
//  LatestEventsTableViewCell.swift
//  SportsApp
//
//  Created by Nasr on 28/02/2022.
//

import UIKit

class LatestEventsTableViewCell: UITableViewCell {
  
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var matchPosterImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var homeScoreTeamLabel: UILabel!
    @IBOutlet weak var awayScoreTeamLabel: UILabel!
    @IBOutlet weak var DateMatchLabel: UILabel!
    @IBOutlet weak var timeMatchLabel: UILabel!
    
    static var identifier = "LatestEventsTableViewCell"
    var upCommingEventArray: [Event] = []
    static func nib ()->UINib{
        return UINib(nibName: "LatestEventsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
