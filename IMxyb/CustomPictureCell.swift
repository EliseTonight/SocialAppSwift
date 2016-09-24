//
//  CustomPictureCell.swift
//  IMxyb
//
//  Created by Elise on 16/4/19.
//  Copyright © 2016年 Elise. All rights reserved.
//

import UIKit

class CustomPictureCell: UITableViewCell {
    @IBOutlet weak var headImage: CornerImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var rightTopImageView: UIImageView!
    @IBOutlet weak var rightBottomImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var blackShadowView: UIView!

    @IBOutlet weak var pictureNumLabel: UILabel!
    
    
    var model:EnthusModel? {
        didSet {
            self.headImage.sd_setImage(with: URL(string: (model?.avatar)!), placeholderImage: UIImage(named: "logo_s"))
            self.mainImageView.sd_setImage(with: URL(string: (model?.cover_url)!), placeholderImage: UIImage(named: "quesheng"))
            self.rightTopImageView.sd_setImage(with: URL(string: (model?.more_pic_urls![0])!), placeholderImage: UIImage(named: "quesheng"))
            self.rightBottomImageView.sd_setImage(with: URL(string: (model?.more_pic_urls![1])!), placeholderImage: UIImage(named: "quesheng"))
            self.nameLabel.text = model?.name
            self.typeLabel.text = model?.type
            self.titleLabel.text = model?.title
            self.contentLabel.text = model?.desc
            
            if model?.comment_count == nil {
                self.commentNumLabel.text = "0"
            }
            else {
                self.commentNumLabel.text = model?.comment_count
            }
            if model?.likers_count == nil {
                self.likeNumLabel.text = "0"
            }
            else {
                self.likeNumLabel.text = model?.likers_count
            }
            
            
            
            
            if model?.photos_count == "0" {
                self.blackShadowView.isHidden = true
                self.pictureNumLabel.isHidden = true
            }
            else {
                self.pictureNumLabel.text = (model?.photos_count)! + "+"
            }
            
            
        }
    }
    
    
    
    
    
    class func cutomPictureCellWithXib(_ tableView:UITableView) -> CustomPictureCell {
        let cellId = "customPictureCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CustomPictureCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("CustomPictureCell", owner: nil, options: nil)?.last as? CustomPictureCell
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
