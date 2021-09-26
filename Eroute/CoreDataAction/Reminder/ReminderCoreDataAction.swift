//
//  ReminderCoreDataAction.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit
import CoreData

class ReminderCoreDataAction {

    static let shared = ReminderCoreDataAction()

    private init() { }


    private func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    private func saveContext(with context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error as NSError {
            debugPrint("Failed to save new user! \(error): \(error.userInfo)")
        }
    }

    func saveReminder(with model: ReminderModel) {
        let managedContext = getContext()
        let newReminder = Reminder(context: managedContext)

        newReminder.id = model.id
        newReminder.label = model.label
        newReminder.note = model.note
        newReminder.dateTimeText = model.dateTimeText
        newReminder.isCompleted = model.isCompleted

        saveContext(with: managedContext)

    }

    func fetchReminders(completion: @escaping (Result<[ReminderModel], DataBaseError>) -> Void) {
        let managedContext = getContext()
        fetch(type: Reminder.self, managedObjectContext: managedContext) { [weak self] (reminderList: [Reminder]?) in

            guard let reminderList = reminderList,
                reminderList.count > 0 else {
                completion(.failure(.noDataFound(String(describing: Alarm.self))))
                return
            }

            let listReminderModel = reminderList.map{ ReminderModel(from: $0) }
            completion(.success(listReminderModel))
        }
    }

    func removeReminder(with model: ReminderModel, completion: @escaping (Bool) -> Void){
        let managedContext = getContext()

        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Reminder.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (reminderList: [Reminder]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let reminder = reminderList?.first {
                managedContext.delete(reminder)
                completion(true)
            } else {
                completion(false)
            }

            self.saveContext(with: managedContext)

        }
    }


    func updateReminder(with model: ReminderModel, completion: @escaping (Bool) -> Void) {
        let managedContext = getContext()
        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Reminder.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (reminderList: [Reminder]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let updateReminder = reminderList?.first {
                updateReminder.id = model.id
                updateReminder.label = model.label
                updateReminder.note = model.note
                updateReminder.dateTimeText = model.dateTimeText
                updateReminder.isCompleted = model.isCompleted

                completion(true)
            } else {
                completion(false)
            }

            self.saveContext(with: managedContext)

        }
    }


    func toggleReminder(with model: ReminderModel, completion: @escaping (Bool) -> Void) {
        let managedContext = getContext()
        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Reminder.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (reminderList: [Reminder]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let updateReminder = reminderList?.first {
                updateReminder.isCompleted = !model.isCompleted
                completion(true)
            } else {
                completion(false)
            }

            self.saveContext(with: managedContext)

        }
    }


    // MARK: - Helper Method
    private func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void)) {

        managedObjectContext.perform {
            let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: type))
            if let predicate = predicate {
                request.predicate = predicate
            }
            if let sortDescriptors = sortDescriptors {
                request.sortDescriptors = sortDescriptors
            }
            do {
                let result = try managedObjectContext.fetch(request)
                completion(result)
            } catch {
                completion(nil)
            }
        }
    }
}

