//
//  MemberCollectionViewCell.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 05/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
    }
    
    func configureCell(model: AddActivities.Member.ViewModel.MemberViewModel) {
        imageView.image = model.photo
        titleLabel.text = model.title
    }
}
