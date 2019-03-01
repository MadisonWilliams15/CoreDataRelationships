//
//  Category+CoreDataClass.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Category)
public class Category: NSManagedObject {
    
    var documents: [Document]?{
        return self.rawDocuments?.array as? [Document]
    }
    
    convenience init?(title : String){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        self.init(entity: Category.entity(), insertInto: context)
        self.title = title
    }

}
