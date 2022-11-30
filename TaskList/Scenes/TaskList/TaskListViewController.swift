//
//  TaskListViewController.swift
//  TaskList
//
//  Created by Anoop Kharsu on 29/11/22.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let interactor = TaskListInteractor()
    var tasks: [TaskItem] {
        interactor.tasks
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        interactor.taskListDelegate = self
        interactor.getAllTasks()
        tableView.register(.init(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        let vc = TaskViewController(nibName: "TaskViewController", bundle: nil)
        vc.taskListDelegate = self
        navigationController?.showDetailViewController(vc, sender: nil)
    }
    
    func completeTask(_ index: IndexPath ) {
        interactor.deleteTask(tasks[index.item])
        tableView.deleteRows(at: [index], with: .automatic)
    }
}

//MARK: TableView
extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.taskListDelegate = self
        cell.setup(tasks[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .destructive, title: "Complete", handler: {[weak self] _,_,_ in
            self?.completeTask(indexPath)
        })
        
        completeAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskViewController(nibName: "TaskViewController", bundle: nil)
        vc.taskListDelegate = self
        vc.task = tasks[indexPath.item]
        
        navigationController?.showDetailViewController(vc, sender: nil)
    }
}

// MARK: Delegates
extension TaskListViewController: TaskListInteractorDelegate, TaskListDelegate {
    func addNewTask(_ name: String, _ date: Date) {
        interactor.createTask(name,date)
    }
    
    func saveTask() {
        showMessage("Task saved")
        interactor.save()
    }
    
    func reloadList() {
        tableView.reloadData()
    }
    
    func completeTask(_ cell: TaskTableViewCell) {
        if let index = tableView.indexPath(for: cell){
            completeTask(index)
        }
    }
    
    func showMessage(_ message: String) {
        snackBarMessage(message)
    }
}

protocol TaskListDelegate: AnyObject {
    func addNewTask(_ name: String, _ date: Date)
    func saveTask()
    func completeTask(_ cell: TaskTableViewCell)
}
