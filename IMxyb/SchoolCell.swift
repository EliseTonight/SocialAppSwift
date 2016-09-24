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
            self.backImage.sd_setImage(with: URL(string: (model?.cover_url)!), placeholderImage: UIImage(named: "quesheng"))
            self.typeLabel.text = model?.type
            self.adressLabel.text = model?.desc
            self.titleLabel.text = model?.title
            self.mainTitleLabel.text = model?.name
        }
    }
    
    
    
    class func schoolCellFromXib(_ tableView:UITableView) -> SchoolCell? {
        let cellId = "schoolCell"
        var cell  = tableView.dequeueReusableCell(withIdentifier: "schoolCell") as? SchoolCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("SchoolCell", owner: nil, options: nil)?.last as? SchoolCell
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
