//
//  TaskViewController.swift
//  TaskList
//
//  Created by Anoop Kharsu on 29/11/22.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var addSaveButtonView: UIButton!
    
    weak var taskListDelegate: TaskListDelegate?
    
    var task: TaskItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        if let task {
            addSaveButtonView.setTitle("Save", for: .normal)
            datePickerView.minimumDate = task.date ?? .now
            datePickerView.date = task.date ?? .now
            taskTextField.text = task.name
        } else {
            datePickerView.minimumDate = .now
        }
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        if taskTextField.text == "" || datePickerView.date <= .now {
            snackBarMessage("Invalid task")
            return
        }
        
        if task != nil {
            task?.date = datePickerView.date
            task?.name = taskTextField.text
            taskListDelegate?.saveTask()
        } else if let name = taskTextField.text {
            taskListDelegate?.addNewTask(name, datePickerView.date)
        }
        
        dismiss(animated: true)
    }
}

