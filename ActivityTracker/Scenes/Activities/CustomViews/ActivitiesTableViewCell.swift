//
//  ActivitiesTableViewCell.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 03/12/18.
//  Copyright © 2018 Antony Raphel. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var firstMember: UIImageView!
    @IBOutlet weak var secondMember: UIImageView!
    @IBOutlet weak var totMemberLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkListLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func initUI() {
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true
        firstMember.layer.cornerRadius = firstMember.frame.size.height/2
        firstMember.clipsToBounds = true
        secondMember.layer.cornerRadius = secondMember.frame.size.height/2
        secondMember.clipsToBounds = true
    }
    
    @IBAction func didTapOnButton(_ sender: Any) {
        
    }
    
    func configureCell(with model: Activities.Fetch.ViewModel.ActivityViewModel) {
        logo.image = model.logo
        firstMember.isHidden = true
        secondMember.isHidden = true
        if model.members.count >= 2 {
            firstMember.image = model.members.first?.photo
            secondMember.image = model.members.last?.photo
            firstMember.isHidden = false
            secondMember.isHidden = false
        } else if model.members.count >= 1 {
            firstMember.image = model.members.first?.photo
            firstMember.isHidden = false
            secondMember.isHidden = true
        }
        firstMember.image = model.members.first?.photo
        dueDateLabel.text = model.dueDate
        titleLabel.text = model.title
        descriptionLabel.text = model.desc
        checkListLabel.text = model.checkList
        totMemberLabel.text = model.membersCount
        timerLabel.text = model.time
    }
}
