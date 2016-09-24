//
//  CommentCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    
    
    var model:CommentModel? {
        didSet {
            self.headImage.sd_setImage(with: URL(string: (model?.head)!), placeholderImage: UIImage(named: "logo_s"))
            self.nameLabel.text = model?.name
            self.contentLabel.text = model?.text
        }
    }
    
    
    
    
    
    
    @IBAction func commentButtonClick(_ sender: UIButton) {
        
    }
    
    
    class func commentCellWithXib(_ tableView:UITableView) -> CommentCell? {
        let cellId = "commentCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CommentCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("CommentCell", owner: nil, options: nil)?.last as? CommentCell
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
