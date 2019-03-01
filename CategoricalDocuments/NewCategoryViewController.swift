//
//  NewCategoryViewController.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveCategory(_ sender: Any) {
        let category = Category(title: titleTextField.text ?? "No title" )
        do{
            try category?.managedObjectContext?.save()
            self.navigationController?.popViewController(animated: true)
        }catch{
            print("Could not save category")
        }
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
