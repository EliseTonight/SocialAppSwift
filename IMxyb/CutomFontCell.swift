//
//  CutomFontCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CutomFontCell: UITableViewCell {
    @IBOutlet weak var headImageView: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var commentNum: UILabel!

    
    var model:EnthusModel? {
        didSet {
            self.headImageView.sd_setImage(with: URL(string: (model?.avatar)!), placeholderImage: UIImage(named: "logo_s"))
            self.nameLabel.text = model?.name
            self.typeLabel.text = model?.type
            self.titleLabel.text = model?.title
            self.contentLabel.text = model?.desc
            if model?.comment_count == nil {
                self.commentNum.text = "0"
            }
            else {
                self.commentNum.text = model?.comment_count
            }
            if model?.likers_count == nil {
                self.likeNum.text = "0"
            }
            else {
                self.likeNum.text = model?.likers_count
            }
            
            
        }
    }
    
    class func cutomFontCellWithXib(_ tableView:UITableView) -> CutomFontCell {
        let cellId = "cutomFontCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CutomFontCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("CutomFontCell", owner: nil, options: nil)?.last as? CutomFontCell
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
