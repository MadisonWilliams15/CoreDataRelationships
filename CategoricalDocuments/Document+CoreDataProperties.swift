//
//  Document+CoreDataProperties.swift
//  CategoricalDocuments
//
//  Created by Madison Williams on 2/24/19.
//  Copyright © 2019 Madison Williams. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var contents: String?
    @NSManaged public var category: Category?

}
