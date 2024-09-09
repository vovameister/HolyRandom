//
//  WheelItemEntity+CoreDataProperties.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 9.9.24..
//
//

import Foundation
import CoreData


extension WheelItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WheelItemEntity> {
        return NSFetchRequest<WheelItemEntity>(entityName: "WheelItemEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var list: WheelItemListEntity?

}

extension WheelItemEntity : Identifiable {

}
