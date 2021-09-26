//
//  AlarmCoreDataAction.swift
//  Eroute
//
//  Created by bhavesh on 25/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//
import UIKit
import CoreData

class AlarmCoreDataAction {

    static let shared = AlarmCoreDataAction()

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

    func saveAlarm(with model: AlarmModel) {
        let managedContext = getContext()
        let newAlarm = Alarm(context: managedContext)

        newAlarm.id = model.id
        newAlarm.dateText = model.dateText
        newAlarm.isSnooze = model.isSnooze
        newAlarm.repeatValue = Int16(model.repeatValue)
        newAlarm.label = model.label

        saveContext(with: managedContext)

    }

    func fetchAlarms(completion: @escaping (Result<[AlarmModel], DataBaseError>) -> Void) {
        let managedContext = getContext()
        fetch(type: Alarm.self, managedObjectContext: managedContext) { [weak self] (alarmList: [Alarm]?) in

            guard let alarmList = alarmList,
                alarmList.count > 0 else {
                completion(.failure(.noDataFound(String(describing: Alarm.self))))
                return
            }

            let listAlarmModel = alarmList.map{ AlarmModel(from: $0) }
            completion(.success(listAlarmModel))
        }
    }

    func removeAlarm(with model: AlarmModel, completion: @escaping (Bool) -> Void){
        let managedContext = getContext()

        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Alarm.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (alarmList: [Alarm]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let alarm = alarmList?.first {
                managedContext.delete(alarm)
                completion(true)
            } else {
                completion(false)
            }

            self.saveContext(with: managedContext)

        }
    }


    func updateAlarm(with model: AlarmModel, completion: @escaping (Bool) -> Void) {
        let managedContext = getContext()
        let predicate = NSPredicate(format: "id == %@", model.id.uuidString)
        fetch(type: Alarm.self, predicate: predicate, managedObjectContext: managedContext) { [weak self] (alarmList: [Alarm]?) in

            guard let self = self else {
                completion(false)
                return
            }

            if let updateAlarm = alarmList?.first {
                updateAlarm.id = model.id
                updateAlarm.dateText = model.dateText
                updateAlarm.isSnooze = model.isSnooze
                updateAlarm.repeatValue = Int16(model.repeatValue)
                updateAlarm.label = model.label
                completion(true)
            } else {
                completion(false)
            }

            self.saveContext(with: managedContext)

        }
    }



    // MARK: - Helper Method
    func fetch<T: NSManagedObject>(type: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, managedObjectContext: NSManagedObjectContext, completion: @escaping (([T]?) -> Void)) {

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
