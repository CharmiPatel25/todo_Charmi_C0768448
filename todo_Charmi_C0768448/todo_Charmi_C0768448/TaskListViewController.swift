//
//  TaskListViewController.swift
//  todo_Charmi_C0768448
//
//  Created by user174608 on 6/28/20.
//  Copyright © 2020 charmi. All rights reserved.
//

import UIKit
import CoreData

class TaskListViewController: UIViewController {
    
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
    
    
    
}//class end
