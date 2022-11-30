//
//  TaskListInteractor.swift
//  TaskList
//
//  Created by Anoop Kharsu on 29/11/22.
//

import Foundation
import UIKit

class TaskListInteractor {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks = [TaskItem]()
    
    weak var taskListDelegate: TaskListInteractorDelegate?
    
    func getAllTasks() {
        let req = TaskItem.getRequest()
        if let items = try? context.fetch(req){
            tasks = items
        }
    }
    
    func createTask(_ name: String, _ data: Date) {
        let item = TaskItem(context: context)
        item.date = data
        item.name = name
        save()
        taskListDelegate?.showMessage("New task added")
    }
    
    func deleteTask(_ task: TaskItem) {
        context.delete(task)
        try? context.save()
        getAllTasks()
        taskListDelegate?.showMessage("Task completed")
    }
    
    func save() {
        do {
            try context.save()
            getAllTasks()
            taskListDelegate?.reloadList()
        } catch {
            // error
        }
    }
}

protocol TaskListInteractorDelegate: AnyObject {
    func reloadList()
    func showMessage(_ message: String)
}
