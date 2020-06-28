//
//  TaskListViewController.swift
//  todo_Charmi_C0768448
//
//  Created by user174608 on 6/28/20.
//  Copyright © 2020 charmi. All rights reserved.
//

import UIKit
import CoreData

class TaskListViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
   
    
    
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    
    var selectedSort = 0
    var selectedCategory: Category? {
        didSet {
            loadTodos()
        }
    }
    
    var categoryName: String!
    let todoListContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasksArray = [Todo]()
    var selectedTodo: Todo?
    var todoToMove = [Todo]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func loadTodos(with request: NSFetchRequest<Todo> = Todo.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let sortOptions = ["date", "name"]
        let todoPredicate = NSPredicate(format: "parentFolder.name=%@", selectedCategory!.name!)
        request.sortDescriptors = [NSSortDescriptor(key: sortOptions[selectedSort], ascending: true)]
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [todoPredicate, addtionalPredicate])
        } else {
            request.predicate = todoPredicate
        }
        
        do {
            tasksArray = try todoListContext.fetch(request)
        } catch {
            print("Error loading todos \(error.localizedDescription)")
        }
        
    }
    @IBAction func addTodo(_ sender: Any) {
        performSegue(withIdentifier: "todoViewScreen", sender: self)
    }
    
    
    @IBAction func sortToDo(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
               case 0: selectedSort = 0
                   break
               case 1: selectedSort = 1
                   break
               default:
                   break
               }
               
               loadTodos()
               tabelView.reloadData()
    }
    
    func deleteTodoFromList() {
        
        todoListContext.delete(selectedTodo!)
        tasksArray.removeAll { (Todo) -> Bool in
            Todo == selectedTodo!
        }
        tabelView.reloadData()
        
    }
    
    func saveTodos() {
        do {
            try todoListContext.save()
        } catch {
            print("Error  \(error.localizedDescription)")
        }
    }
    
    func saveTodo(title: String, dueDate: Date)
    {
        let todo = Todo(context: todoListContext)
        todo.name = title
        todo.due_date = dueDate
        todo.date = Date()
        todo.parentFolder = selectedCategory
        saveTodos()
        tasksArray.append(todo)
        tabelView.reloadData()
    }
    
    
    func updateTodo() {
        saveTodos()
        tabelView.reloadData()
    }
    
    func markTodoCompleted() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let folderPredicate = NSPredicate(format: "name MATCHES %@", "Archived")
        request.predicate = folderPredicate
        do {
            let category = try context.fetch(request)
            self.selectedTodo?.parentFolder = category.first
            saveTodos()
            tasksArray.removeAll { (Todo) -> Bool in
                Todo == selectedTodo!
            }
            tabelView.reloadData()
        } catch {
            print("Error fetching data \(error.localizedDescription)")
        }
        
    }
    
    func setUpTableView() {
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.estimatedRowHeight = 44
        tabelView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return tasksArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
                   let task = tasksArray[indexPath.row]
                   cell.textLabel?.text = task.name
                   if (task.due_date! < Date() && task.parentFolder?.name != "Archived") {
                    cell.backgroundColor = UIColor.red
                   }
                   if (Calendar.current.isDateInToday(task.due_date!) && task.parentFolder?.name != "Archived") {
                    cell.backgroundColor = UIColor.green
                   }
                   return cell
       }
}//class end
