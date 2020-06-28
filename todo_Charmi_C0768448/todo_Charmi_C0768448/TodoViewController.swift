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
    }
    
    
    
    @IBAction func doneBtn(_ sender: Any) {
        
    }
    

}//class end
