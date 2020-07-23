//
//  DetailsCell.swift
//  MovieList
//
//  Created by eSparkBiz-1 on 29/08/19.
//  Copyright © 2019 eSparkBiz. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {

    @IBOutlet var lblValue: UILabel!
    @IBOutlet var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
