//
//  EventCoreDataAction.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import UIKit
import CoreData

class EventCoreDataAction {

    static let shared = EventCoreDataAction()

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

    func saveEvent(with model: EventModel) {
        let managedContext = getContext()
        let newEvent = Event(context: managedContext)

        newEvent.id = model.id
        newEvent.name = model.name
        newEvent.dateText = model.dateText
        newEvent.startTimeText = model.startTimeText
        newEvent.endTimeText = model.endTimeText
        newEvent.eventDescription = model.eventDescription

        saveContext(with: managedContext)

    }

    func fetchEvents(completion: @escaping (Result<[EventModel], DataBaseError>) -> Void) {
        let managedContext = getContext()
        fetch(type: Event.self, managedObjectContext: managedContext) { [weak self] (eventList: [Event]?) in

            guard let eventList = eventList,
                eventList.count > 0 else {
                completion(.failure(.noDataFound(String(describing: Alarm.self))))
                return
            }

            let listEventModel = eventList.map{ EventModel(from: $0) }
            completion(.success(listEventModel))
        }
    }

    func removeEvent(with model: EventModel, completion: @escaping (Bool) -> Void){
        let managedContext = getContext()

        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Event.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (eventList: [Event]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let event = eventList?.first {
                managedContext.delete(event)
                completion(true)
            } else {
                completion(false)
            }

            self.saveContext(with: managedContext)

        }
    }


    func updateEvent(with model: EventModel, completion: @escaping (Bool) -> Void) {
        let managedContext = getContext()
        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Event.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (eventList: [Event]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let updateEvent = eventList?.first {
                updateEvent.id = model.id
                updateEvent.name = model.name
                updateEvent.dateText = model.dateText
                updateEvent.startTimeText = model.startTimeText
                updateEvent.endTimeText = model.endTimeText
                updateEvent.eventDescription = model.eventDescription
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
