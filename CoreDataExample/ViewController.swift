//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Jesus Jaime Cano Terrazas on 04/09/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.insertExample()
        self.readExample()
        self.updateExample()
        self.readExample()
        self.deleteExample()
    }
    
    // MARK: - Private Methods

    private func insertExample() {
        print("Insert Example")
        
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        //Instant an Artist using CoreData Constructor
        
        let artist = Artist(context: context)
        artist.name = "Luis Miguel"
        artist.nacionality = "Mexican"
        artist.image = "luis_miguel"
        
        let song = Song(context: context)
        song.title = "Incondicional"
        song.duration = 210
        
        
        // Stablish the relation between the artist and the song
        song.artist = artist
        
        let songTwo = Song(context: context)
        songTwo.title = "La Bikina"
        songTwo.duration = 240
        artist.addToSongs(songTwo)
        
        CoreDataManager.sharedInstance.saveContext()
        
        print("Insert Finished")
    }
    
    private func readExample() {
        print("Read...")
        
        let artists = CoreDataManager.sharedInstance.readData(className: "Artist") as! [Artist]
        
        print("Artists found: \(artists.count)")
        
        for artist in artists {
            
            print("ARTIST: \n")
            print("ID: \(artist.id)")
            print("Name: \(artist.name ?? "")")
            print("Nacionality: \(artist.nacionality ?? "")")
            print("Image: \(artist.image ?? "")")
            
            print("____________________")
            
            for song in artist.songs?.allObjects as! [Song] {
                print("Song Title: \(song.title ?? "")")
                print("Duration: \(song.duration)")
                print("Song Artist: \(song.artist?.image ?? "")")
            }
        }
        
        let songs = CoreDataManager.sharedInstance.readData(className: "Song", key: "title", value: "Incondicional")
        
        print("Songs Found: \(songs.count)")
        
        let genericsArtist = CoreDataManager.sharedInstance.readWithGeneric(className: Artist.self)
        
        for a in genericsArtist {
            print(a.name ?? "")
        }
        
    }
    
    private func updateExample() {
        print("Update...")
        
        let artists = CoreDataManager.sharedInstance.readWithGeneric(className: Artist.self)
        
        for artist in artists {
            artist.name = "\(artist.name!) Updated!!"
            
            for song in artist.songs?.allObjects as! [Song] {
                song.title = "\(song.title!) Updated!!"
            }
        }
        
        CoreDataManager.sharedInstance.saveContext()
        
        print("Update Finished")
    }
    
    private func deleteExample() {
        print("Delete All")
        
        // First we need to get all the artist
        let artists = CoreDataManager.sharedInstance.readWithGeneric(className: Artist.self)
        
        // Get the context
        let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        for artist in artists {
            context.delete(artist)
        }
        
        CoreDataManager.sharedInstance.saveContext()
        print("Delete Finished")
        self.readExample()
        
    }
}

