//
//  MovieListCell.swift
//  MovieList
//
//  Created by eSparkBiz-1 on 22/08/19.
//  Copyright © 2019 eSparkBiz. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    var minHeight: CGFloat?

    @IBOutlet var lableBottom: NSLayoutConstraint!
//    @IBOutlet var imageBottom: NSLayoutConstraint!
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = minHeight else { return size }
        return CGSize(width: size.width, height: max(size.height, minHeight))
    }

}
