//
//  RealmManager.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/19/22.
//

import Foundation
import RealmSwift

//observable object protocol = all views connected or having access to realm manager can see live changes
class RealmManager: ObservableObject {
    
    //private(set) means we can only set this variable within this class
    private(set) var localRealm: Realm?
    
    //published property wrapper will allow us to notify our views of any change in this class
    @Published private(set) var tasks: [Task] = []
    
    init()
    {
        openRealm()
        getTasks()
    }
    
    func openRealm() {
        do
        {
            let config = Realm.Configuration(schemaVersion: 1)//migration block needed if updating schema
            Realm.Configuration.defaultConfiguration = config
            
            //create realm, opening a box
            localRealm = try Realm()
        }
        catch
        {
            print("Error opening realm: \(error)")
        }
    }
    //create
    func addTask(taskTitle: String) {
        //unwrap the optional from local realm variable with if let
        if let localRealm = localRealm
        {
            do
            {
                try localRealm.write
                {
                    //let copyTask = localRealm.create(Task(value: ["title": taskTitle, "completed": false]))
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask, update: .all)
                    //adding getTasks updates the tasks array every time we add a task to localRealm
                    getTasks()
                    
                    print("Added new task to Realm: \(newTask)")//message to console
                }
            }
            catch
            {
                print("Error adding task to realm: \(error)")
            }
        }
    }
    //read
    func getTasks() {
        if let localRealm = localRealm
        {
            //sort objects by completed status, not completed tasks will go to the beginning of array, completed will go to the bottom array
            //localrealm.objects gives accesss
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
            print("get tasks passed")
        }
    }
    //update
    func updateTask(id: ObjectId, completed: Bool) {
        if let localRealm = localRealm {
            do {
                //filter all tasks and only return us the task with the specified id
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                //
                guard !taskToUpdate.isEmpty else { return }
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated task with ID \(id)! Completed status: \(completed)")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    //delete
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                //filter all tasks and only return us the task with the specified id
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else { return }
                
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task with ID \(id)")
                    print("get deleted passed")
                }
            } catch {
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
    
}
