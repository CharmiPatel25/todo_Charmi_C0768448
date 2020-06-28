//
//  TodoViewController.swift
//  todo_Charmi_C0768448
//
//  Created by user174608 on 6/28/20.
//  Copyright © 2020 charmi. All rights reserved.
//

import UIKit
import CoreData


class TodoViewController: UIViewController {
    
    var todo: Todo?
    var delegate: TaskListViewController?
    @IBOutlet weak var todoLbl: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var buttonStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        delegate?.deleteTodoFromList()
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func doneBtn(_ sender: Any) {
        if(checkTitle()) {
            todo?.name = todoLbl!.text!
            todo?.due_date = datePicker!.date
            delegate?.markTodoCompleted()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func checkTitle() -> Bool {
        if (todoLbl.text?.isEmpty ?? true) {
            let alert = UIAlertController(title: "Title cannot be blank", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        else {
            return true
        }
    }

}//class end
