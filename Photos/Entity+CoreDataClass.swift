//
//  Entity+CoreDataClass.swift
//  Photos
//
//  Created by Ryan Rottmann on 3/22/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Entity)
public class Entity: NSManagedObject {
    
    var image: UIImage?{
        get {//convert binary data to image
            // convert NSData to data and then call constructor
            if let data = photo as Data? {
                return UIImage(data: data)
                
            } else {
                return nil
            }
            
        }
        set{//convert image to binary data
            if let newImage = newValue{// newValue is what you are pulling from core data
                photo = newImage.pngData() as NSData?
            }
        }
  
    }
    
    convenience init?(image: UIImage?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext, let image = image else {
            return nil
        }
        self.init(entity: Entity.entity(), insertInto: managedContext)
        self.photo = image.pngData() as NSData?
   
    }
}
