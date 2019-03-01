//
//  DocumentCategoriesViewController.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//
import CoreData
import UIKit


class DocumentCategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categories : [Category] = []
    @IBOutlet weak var categoriesTableView: UITableView!
    
    func numberOfSections(in categoriesTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = "\(category.title ?? "") (\(category.documents?.count ?? 0)) "
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try managedContext.fetch(fetchRequest)
            categoriesTableView.reloadData()
        }catch{
            print("Could not fetch categories")
        }
        print(categories.count)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DocumentsViewController,
            let selectedRow = self.categoriesTableView.indexPathForSelectedRow?.row else{
                    return
            }
        destination.category = categories[selectedRow]
        
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCategory(at: indexPath)
            
        }
    }
    
    func deleteCategory(at indexPath:IndexPath){
        let category = categories[indexPath.row]
        
        guard let managedContext = category.managedObjectContext else{
            return
        }
        managedContext.delete(category)
        do{
            try managedContext.save()
            categories.remove(at: indexPath.row)
            categoriesTableView.deleteRows(at: [indexPath], with: .automatic)
        }catch{
            print("Could not delete")
            categoriesTableView.reloadRows(at: [indexPath], with: .automatic)
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
