//
//  TaskListModels.swift
//  TaskList
//
//  Created by Anoop Kharsu on 29/11/22.
//

import Foundation
import CoreData

extension TaskItem {
    var Overdue: Bool {
        if let date  {
            return date < .now
        }
        return false
    }
    
    static func getRequest() -> NSFetchRequest<TaskItem>{
        let req = TaskItem.fetchRequest()
        req.sortDescriptors = [.init(key: "date", ascending: true)]
        
        return req
    }
}
