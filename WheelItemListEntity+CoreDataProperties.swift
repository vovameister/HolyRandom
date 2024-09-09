//
//  WheelItemListEntity+CoreDataProperties.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 9.9.24..
//
//

import Foundation
import CoreData


extension WheelItemListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WheelItemListEntity> {
        return NSFetchRequest<WheelItemListEntity>(entityName: "WheelItemListEntity")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var item: NSSet?

}

// MARK: Generated accessors for item
extension WheelItemListEntity {

    @objc(addItemObject:)
    @NSManaged public func addToItem(_ value: WheelItemEntity)

    @objc(removeItemObject:)
    @NSManaged public func removeFromItem(_ value: WheelItemEntity)

    @objc(addItem:)
    @NSManaged public func addToItem(_ values: NSSet)

    @objc(removeItem:)
    @NSManaged public func removeFromItem(_ values: NSSet)

}

extension WheelItemListEntity : Identifiable {

}
