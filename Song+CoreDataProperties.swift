//
//  Song+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Jesus Jaime Cano Terrazas on 04/09/21.
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var title: String?
    @NSManaged public var artist: Artist?

}

extension Song : Identifiable {

}
