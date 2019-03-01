//
//  Document+CoreDataClass.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Document)
public class Document: NSManagedObject {
    var date : Date?{
        get{
            return rawDate as Date?
        }
        set{
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(title:String?, contents:String?, date:Date?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext
            else{
                return nil
        }
        self.init(entity: Document.entity(), insertInto: context)
        self.title = title
        self.contents = contents
        self.date = date
    }
    
    func update(title:String?, contents: String?, date:Date?){
        self.title = title
        self.contents = contents
        self.date = date
    }

}

