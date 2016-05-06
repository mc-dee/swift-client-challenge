//
//  CoreDataMapper.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//
//  This file is part of GitHubCLient.
//
//  GitHubCLient is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  GitHubCLient is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with GitHubCLient.  If not, see <http://www.gnu.org/licenses/>.

import Foundation
import CoreData
import UIKit

class CoreDataMapper<T: NSManagedObject> {
    
    /**
     Generated an array of [T: NSManagedObject]
     
     - parameter array: Array of dictionary [String : AnyObject]
     
     - returns: Array of [T: NSManagedObject]
     */
    static func objects(fromArray array: [[String : AnyObject]]) -> [T]? {
        // Create empty objects array
        var objects: [T] = []
        
        // Iterate over each element and generate according object
        for object in array {
            // Check if element could be created, otherwise ignore it and skip loop
            guard let transformedObject = self.object(fromDictionary: object) else {
                continue
            }
            // Append object
            objects.append(transformedObject)
        }
        return objects
    }
    
    /**
     Returns an object of given T: NSManagedObject
     
     - parameter dictionary: Dictionary which should be copied into T: NSManagedObject
     
     - returns: NSManagedObject of T
     */
    static func object(fromDictionary dictionary: [String : AnyObject]) -> T? {
        // App delegate is needed for moc
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        // Get object description
        let repositoryDescription = NSEntityDescription.entityForName(String(T), inManagedObjectContext: appDelegate.managedObjectContext)
        guard let description = repositoryDescription else {
            return nil
        }
        
        let object = T(entity: description, insertIntoManagedObjectContext: appDelegate.managedObjectContext)
        self.setValues(fromDictionary: dictionary, onManagedObject: object)
        return object
    }
    
    private static func setValues<T: NSManagedObject>(fromDictionary value: [String : AnyObject], onManagedObject managedObject: T) {
        // Iterate attributes
        let attributes = managedObject.entity.attributesByName
        for attribute in attributes {
            // If attribute is named like a keyword, _val is appended
            let hasValSuffix = attribute.0.hasSuffix("_val")
            
            // Get attribute name
            var attributeName = attribute.0
            
            // Strip _val suffix before fetch from JSON
            if hasValSuffix {
                attributeName = attribute.0.stringByReplacingOccurrencesOfString("_val", withString: "")
            }
            
            // Get value, skip if not present in model
            guard var value = value[attributeName] else {
                continue
            }
            
            // We need to get the attribute type, so we can decide
            // which class is required for initialization
            let attributeType = attribute.1.attributeType
            switch attributeType {
            case .UndefinedAttributeType:
                print("UndefinedAttributeType is not implemented - \(attributeName)")
                break
            case .Integer16AttributeType, .Integer32AttributeType, .Integer64AttributeType, .DecimalAttributeType, .BooleanAttributeType:
                value = NSNumber(integer: Int(String(value))!)
            case .DoubleAttributeType, .FloatAttributeType:
                value = NSNumber(double: Double(String(value))!)
            case .StringAttributeType:
                value = String(value)
            case .DateAttributeType:
                print("DateAttributeType is not implemented - \(attributeName)")
                continue
            case .BinaryDataAttributeType:
                print("BinaryDataAttributeType is not implemented - \(attributeName)")
                continue
            case .TransformableAttributeType:
                print("TransformableAttributeType is not implemented - \(attributeName)")
                continue
            case .ObjectIDAttributeType:
                print("ObjectIDAttributeType is not implemented - \(attributeName)")
                continue
            }
            
            // Readd _val string to attribute name if present, before setting value to attribute
            if hasValSuffix {
                attributeName = attributeName.stringByAppendingString("_val")
            }
            
            // Wired cast inference seems to break here in Swift 2.2
            (managedObject as NSManagedObject).setValue(value, forKey: attributeName)
        }
        
        // Iterate relations
        let relationships = managedObject.entity.relationshipsByName
        for relationship in relationships {
            // If relationship is named like a keyword, _val is appended
            let hasValSuffix = relationship.0.hasSuffix("_val")
            
            // Get relationship name
            var relationshipName = relationship.0
            
            // Strip _val suffix before fetch from JSON
            if hasValSuffix {
                relationshipName = relationship.0.stringByReplacingOccurrencesOfString("_val", withString: "")
            }
            
            // We need to know if we have multiple relations
            let relationshipDescription = relationship.1
            
            // Check if destination entity is available
            guard let destinationEntity = relationshipDescription.destinationEntity else {
                continue
            }
            
            // Get value, skip if not present in model
            guard var relationValue = value[relationshipName] else {
                continue
            }
            
            /**
             Method creates and returns an related object of managedObject
             
             - parameter value:                Values for related object
             - parameter entityDescription:    Entity description of the target NSManagedObject
             - parameter managedObjectContext: Object content in which the object should be created
             
             - returns: An created managed object
             */
            func relatedObject(forValues value: [String : AnyObject], entityDescription: NSEntityDescription, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject {
                // Create object
                let relatedManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entityDescription.name!, inManagedObjectContext: managedObject.managedObjectContext!)
                
                // Set values from dictionary to related object
                self.setValues(fromDictionary: value, onManagedObject: relatedManagedObject)

                // Return created managed object
                return relatedManagedObject
            }
            
            // Check if relationship is to-many or one-to-one
            if !relationshipDescription.toMany {
                
                // Check if we really have an array of String:AnyObject dictionary
                guard let relationValue = relationValue as? [String : AnyObject] else {
                    print("Ups, couldnt not get dictionary for \(relationshipName)")
                    continue
                }
                
                // Creates and NSManagedObject of the relationship destinationy entity
                let relatedObject = relatedObject(
                    forValues: relationValue,
                    entityDescription: destinationEntity,
                    inManagedObjectContext: managedObject.managedObjectContext!
                )
                
                // Set object to one-to-one relation
                (managedObject as NSManagedObject).setValue(relatedObject, forKey: relationshipName)
            } else {
                // Check if we really have an array of String:AnyObject dictionary
                guard let relationValue = relationValue as? [[String : AnyObject]] else {
                    print("Ups, couldnt not get dictionary for \(relationshipName)")
                    continue
                }

                // Array in which created objects will be stored
                var relatedObjects: [NSManagedObject] = []
                
                // Create an NSMangedObject for each value
                for relationValue in relationValue {
                    let relatedObject = relatedObject(
                        forValues: relationValue,
                        entityDescription: destinationEntity,
                        inManagedObjectContext: managedObject.managedObjectContext!
                    )
                    relatedObjects.append(relatedObject)
                }
                
                // Get current set of relation ship
                guard let toManyRelation = managedObject.valueForKeyPath(relationshipName) as? NSMutableSet else {
                    print("Could not get keypath for relation \(relationshipName)")
                    continue
                }
                
                // Add objects to relation in present set of NSManagedObject
                toManyRelation.addObjectsFromArray(relatedObjects)
            }
        }
    }
}