//
//  TaskTableViewCell.swift
//  TaskList
//
//  Created by Anoop Kharsu on 29/11/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var checkButtonView: UIButton!
    @IBOutlet weak var dateLabelView: UILabel!
    
    weak var taskListDelegate: TaskListDelegate?
    
    func setup(_ data: TaskItem) {
        checkButtonView.tintColor = .secondaryLabel
        titleLabelView.text = data.name
        dateLabelView.text = data.date?.formatted(date: .abbreviated, time: .shortened)
        dateLabelView.textColor = data.Overdue ? .systemRed : .secondaryLabel
    }
    
    @IBAction func completeTask(_ sender: UIButton) {
        sender.tintColor = .systemGreen
        taskListDelegate?.completeTask(self)
    }
}
