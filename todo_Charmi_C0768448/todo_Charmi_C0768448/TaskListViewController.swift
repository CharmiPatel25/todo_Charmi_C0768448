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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
