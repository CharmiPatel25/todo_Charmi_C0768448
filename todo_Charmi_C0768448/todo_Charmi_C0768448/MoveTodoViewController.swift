//
//  MoveTodoViewController.swift
//  todo_Charmi_C0768448
//
//  Created by user174608 on 6/28/20.
//  Copyright © 2020 charmi. All rights reserved.
//

import UIKit
import CoreData

class MoveTodoViewController: UIViewController {
    
    var categories = [Category]()
    var selectedTodo: [Todo]? {
        didSet {
            loadCategories()
        }
    }
 let moveTodoContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadCategories() {
           let request: NSFetchRequest<Category> = Category.fetchRequest()
           let categoryPredicate = NSPredicate(format: "No match %@", selectedTodo?[0].parentFolder?.name ?? "")
           request.predicate = categoryPredicate
           
           do {
               categories = try moveTodoContext.fetch(request)
           } catch {
               print("Error  \(error.localizedDescription)")
           }
       }

}
