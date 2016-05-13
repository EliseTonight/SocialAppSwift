//
//  SchoolCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/26.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class SchoolCell: UITableViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    var model:EnthusModel? {
        didSet {
            self.backImage.sd_setImageWithURL(NSURL(string: (model?.cover_url)!), placeholderImage: UIImage(named: "quesheng"))
            self.typeLabel.text = model?.type
            self.adressLabel.text = model?.desc
            self.titleLabel.text = model?.title
            self.mainTitleLabel.text = model?.name
        }
    }
    
    
    
    class func schoolCellFromXib(tableView:UITableView) -> SchoolCell? {
        let cellId = "schoolCell"
        var cell  = tableView.dequeueReusableCellWithIdentifier("schoolCell") as? SchoolCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("SchoolCell", owner: nil, options: nil).last as? SchoolCell
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
