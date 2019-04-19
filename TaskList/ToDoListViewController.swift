//
//  ToDoListViewController.swift
//  TaskList
//
//  Created by Zach Swartz on 4/19/19.
//  Copyright © 2019 Zach Swartz. All rights reserved.
//


import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks: [Task] = [Task]()
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear...")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Error: No access to managed context.")
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try managedContext.fetch(fetchRequest)
            self.taskTableView.reloadData()
            print("Task table reloaded.")
        } catch {
            print("Error: Fetch could not be performed.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ToDoListViewController,
            let selectedRow = self.taskTableView.indexPathForSelectedRow?.row else {
                return
        }
        destination.tasks = [tasks[selectedRow]]
    }
    
    func deleteTask(at indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        if let managedContext = task.managedObjectContext {
            managedContext.delete(task)
            do {
                try managedContext.save()
                self.tasks.remove(at: indexPath.row)
                taskTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Error: Could not delete task.")
                taskTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.detailTextLabel?.text = task.priority
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath)
        }
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTask", sender: self)
    }
}
