//
//  MessageCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/13.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lastestNewsLabel: UILabel!
    @IBOutlet weak var headImage: UIImageView!

    
    
    var model:MessageModel? {
        didSet {
            self.timeLabel.text = model?.times
            self.headImage.image = UIImage(named: (model?.icon)!)
            self.clientName.text = model?.youName
            if (model?.message?.count ?? 0) == 0 {
                self.lastestNewsLabel.text = ""
            }
            else {
                let i = (model?.message?.count)! - 1
                let values = [String]((model?.message![i])!.values).first
                self.lastestNewsLabel.text = values
            }
//            else {
//                for var i = ((model?.message?.count ?? 0) - 1); i >= 0 ; i-- {
//                    let keys = [String]((model?.message![i])!.keys)
//                    if keys.first == "other" {
//                        let values = [String]((model?.message![i])!.values).first
//                        self.lastestNewsLabel.text = values
//                        break
//                    }
//                    if i == 0 {
//                        self.lastestNewsLabel.text = ""
//                        break
//                    }
//                }
//            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    class func messageCellWithXib(tableView:UITableView) -> MessageCell {
        let cellId = "messageCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? MessageCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("MessageCell", owner: nil, options: nil).last as? MessageCell
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
