//
//  WeekMyTableViewCell.swift
//  MovieCKH
//
//  Created by 최기훈 on 2022/03/28.
//

import UIKit

class WeekMyTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRank: UILabel!
    @IBOutlet weak var auCnt: UILabel!
    @IBOutlet weak var openDt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

