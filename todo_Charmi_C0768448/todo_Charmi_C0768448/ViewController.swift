//
//  ViewController.swift
//  todo_Charmi_C0768448
//
//  Created by user174608 on 6/23/20.
//  Copyright © 2020 charmi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tabelView: UITableView!
    var categoryContext: NSManagedObjectContext!
    var notificationArray = [Todo]()
    
    var categoryName = UITextField()
    var categoryArray: [Category] = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addCategory(_ sender: Any) {
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: addCategoryName(textField:))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if(self.categoryName.text!.count < 1) {
                self.emptyFieldAlert()
                return
            }
            else {
                self.addNewCategory()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func addNewCategory() {
        
        let categoryNames = self.categoryArray.map {$0.name}
        guard !categoryNames.contains(categoryName.text) else {self.showAlert(); return}
        let newCategory = Category(context: self.categoryContext)
        newCategory.name = categoryName.text!
        self.categoryArray.append(newCategory)
        do {
            try categoryContext.save()
            tabelView.reloadData()
        } catch {
            print("Error saving categories \(error.localizedDescription)")
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Same Category Already Exists!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
    func emptyFieldAlert() {
        
        let alert = UIAlertController(title: "Alert", message: " Category Name cannot be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func addCategoryName(textField: UITextField) {
        
        self.categoryName = textField
        self.categoryName.placeholder = " Please Enter Category Name"
        
    }
    
    func initialSetUp() {
        let categoryNames = self.categoryArray.map {$0.name}
        guard !categoryNames.contains("Archived") else {return}
        let newCategory = Category(context: self.categoryContext)
        newCategory.name = "Archived"
        self.categoryArray.append(newCategory)
        do {
            try categoryContext.save()
            tabelView.reloadData()
        } catch {
            print("Error saving categories \(error.localizedDescription)")
        }
    }
    
    func fetchData() {
    
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    
            request.sortDescriptors = [sortDescriptor]
            do {
                categoryArray = try categoryContext.fetch(request)
            } catch {
                print("Error loading categories: \(error.localizedDescription)")
            }
   
            tabelView.reloadData()
            
        }
    
    func firstTimeSetup() {
        let categoryNames = self.categoryArray.map {$0.name}
        guard !categoryNames.contains("Archived") else {return}
        let newCategory = Category(context: self.categoryContext)
        newCategory.name = "Archived"
        self.categoryArray.append(newCategory)
        do {
            try categoryContext.save()
            tabelView.reloadData()
        } catch {
            print("Error  \(error.localizedDescription)")
        }
    }
   func initializeCoreData() {
       print("initialized")
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       categoryContext = appDelegate.persistentContainer.viewContext
       
       fetchCategoryData()
       
   }
    
    func fetchCategoryData() {
   
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    
            request.sortDescriptors = [sortDescriptor]
            do {
                categoryArray = try categoryContext.fetch(request)
            } catch {
                print("Error loading categories: \(error.localizedDescription)")
            }
    
            tabelView.reloadData()
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let destination = segue.destination as! TaskListViewController
           if let indexPath = tabelView.indexPathForSelectedRow {
               destination.selectedCategory = categoryArray[indexPath.row]
           }
       }
    
     func setUpTableView() {
            tabelView.delegate = self
            tabelView.dataSource = self
    
            tabelView.estimatedRowHeight = 44
            tabelView.rowHeight = UITableView.automaticDimension
        }
            
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categoryArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
            let category = categoryArray[indexPath.row]
            if category.name == "Archived" {
                cell.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
            cell.textLabel?.text = category.name
            
            return cell
        }
    
} //class end

