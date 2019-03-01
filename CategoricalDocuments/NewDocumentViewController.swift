//
//  NewDocumentViewController.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//

import UIKit

class NewDocumentViewController: UIViewController {

    @IBOutlet weak var documentTitleField: UITextField!
    @IBOutlet weak var documentContentsField: UITextView!
    
    var doc : Document?
    
    var category : Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let document = doc {
            documentTitleField.text = document.title ?? ""
            documentContentsField.text = document.contents ?? ""
        }
    }

    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if doc == nil{//new document
            let name = documentTitleField.text
            let contents = documentContentsField.text ?? ""
            let date = Date(timeIntervalSinceNow: 0)
            
            if let document = Document(title: name, contents: contents, date: date){
                category?.addToRawDocuments(document)
                do{
                    try document.managedObjectContext?.save()
                    self.navigationController?.popViewController(animated: true)
                    
                } catch{
                    print("Document could not be saved")
                }
            }
        }
        else{//updating document
            doc?.update(title: documentTitleField.text, contents: documentContentsField.text, date: Date(timeIntervalSinceNow: 0))
            do {
                let managedContext = doc?.managedObjectContext
                try managedContext?.save()
            } catch {
                print("The document context could not be saved.")
            }
            self.navigationController?.popViewController(animated: true)
            
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
