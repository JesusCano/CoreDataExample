//
//  Artist+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Jesus Jaime Cano Terrazas on 04/09/21.
//
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist")
    }

    @NSManaged public var image: String?
    @NSManaged public var nacionality: String?
    @NSManaged public var name: String?
    @NSManaged public var songs: NSSet?

}

// MARK: Generated accessors for songs
extension Artist {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}

extension Artist : Identifiable {

}
