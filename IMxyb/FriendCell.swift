//
//  FriendCell.swift
//  IMxyb
//
//  Created by Elise on 16/5/10.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

    
    var model:MessageModel? {
        didSet {
            self.headImageView.image = UIImage(named: (model?.icon)!)
            self.nameLabel.text = model!.youName
            self.signLabel.text = "A civilization is gone with wind"
            self.onlineStateLabel.text = "[离线]"
            self.alpha = 0.8
        }
    }
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var onlineStateLabel: UILabel!
    
    
    
    
    
    
    
    
    
    class func friendCellFromXib(tableView:UITableView) -> FriendCell {
        let id = "friendCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id) as? FriendCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FriendCell", owner: nil, options: nil).last as? FriendCell
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
