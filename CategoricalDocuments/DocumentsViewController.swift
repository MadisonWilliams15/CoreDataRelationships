//
//  DocumentsViewController.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//

import UIKit
import CoreData

class DocumentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    var category : Category?//passed from prepare for segue
    var dateFormatter = DateFormatter()
    @IBAction func newDocument(_ sender: Any) {
    }
    
    @IBOutlet weak var documentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        documentsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.documents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        if let document = category?.documents?[indexPath.row]{
            cell.textLabel?.text = document.title
            
            if let date = document.date{
                cell.detailTextLabel?.text = dateFormatter.string(from: date)
            }
            
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewDocumentViewController else{
            return
        }
        destination.category = category
        
        if let destination = segue.destination as? NewDocumentViewController,
            let segueIdentifier = segue.identifier, segueIdentifier == "editDocument",
            let row = documentsTableView.indexPathForSelectedRow?.row {
            destination.doc = category?.documents?[row]
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
    
    
    func deleteDocument(at indexPath: IndexPath){
        guard let document = category?.documents?[indexPath.row],
            let managedContext = document.managedObjectContext else{
                return
        }
        managedContext.delete(document)
        
        do{
            try managedContext.save()
            documentsTableView.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Document could not be deleted")
            documentsTableView.reloadRows(at: [indexPath], with: .automatic)
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
