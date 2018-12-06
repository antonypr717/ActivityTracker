//
//  AddTaskTableViewCell.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 06/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//

import UIKit

class AddTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with model: AddTask.Fetch.ViewModel.ItemViewModel) {
        checkImageView.image = model.isChecked ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
        titleLabel.attributedText = model.title
        counterLabel.text = model.index
    }
}
