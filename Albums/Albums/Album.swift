//
//  Album.swift
//  Albums
//
//  Created by Zack Larsen on 2/10/20.
//  Copyright © 2020 Zack Larsen. All rights reserved.
//
/*
 {
 "artist" : "Weezer",
 "coverArt" : [ {
 "url" : "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png"
 } ],
 "genres" : [ "Alternative" ],
 "id" : "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22",
 "name" : "Weezer (The Blue Album)",
 "songs" : [ {
 "duration" : {
 "duration" : "3:25"
 },
 "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
 "name" : {
 "title" : "My Name Is Jonas"
 }
 }, {
 "duration" : {
 "duration" : "3:05"
 },
 "id" : "6E8AC92B-ABB4-4303-89CC-51020CEBB557",
 "name" : {
 "title" : "No One Else"
 }
 }, {
 "duration" : {
 "duration" : "4:19"
 },
 "id" : "0A856A54-2E15-4D4A-9B4B-1870F7783EBE",
 "name" : {
 "title" : "The World Has Turned And Left Me Here"
 }
 }, {
 "duration" : {
 "duration" : "2:39"
 },
 "id" : "7119F603-B37E-40B5-968D-E0091A610765",
 "name" : {
 "title" : "Buddy Holly"
 }
 }, {
 "duration" : {
 "duration" : "5:06"
 },
 "id" : "DDECE717-E075-4A64-9A9F-68CB2A5A58B6",
 "name" : {
 "title" : "Undone (The Sweater Song)"
 }
 }, {
 "duration" : {
 "duration" : "3:06"
 },
 "id" : "3FD6E647-4DF1-48CF-8E76-B932DF773ED3",
 "name" : {
 "title" : "Surf Wax America"
 }
 }, {
 "duration" : {
 "duration" : "4:17"
 },
 "id" : "214FB379-4032-4310-8B7C-C69BA21C4394",
 "name" : {
 "title" : "Say It Ain’t So"
 }
 }, {
 "duration" : {
 "duration" : "3:56"
 },
 "id" : "E4ECC640-120D-4A35-8938-3D83DE031430",
 "name" : {
 "title" : "In The Garage"
 }
 }, {
 "duration" : {
 "duration" : "3:25"
 },
 "id" : "34C44D53-6B14-40F7-8438-F147BD2B321D",
 "name" : {
 "title" : "Holiday"
 }
 }, {
 "duration" : {
 "duration" : "7:59"
 },
 "id" : "BA71E72D-E148-4D81-9A11-D7EA048F2949",
 "name" : {
 "title" : "Only In Dreams"
 }
 } ]
 }
 
 */


import Foundation



class Album: Codable {
  var artist: String
  var name: String
  var identifier: UUID
  var coverArt: [URL]
  var genres: [String]
  var songs: [Song]
}
    
    enum Keys: String, CodingKey {
        case artist
        case genres
        case songs
        case name
        case coverArt
        case identifier
        
    }
    
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: Keys.self)
        let artist = try container.decode(String.self, forKey: .artist)
        let genresContainer = try container.decode([String].self, forKey:  .genres)
        var genres: [String] = []
        var songs: [Song] = []
        let songContainer = try container.nestedContainer(keyedBy: Keys.self, forKey: .songs)
    }
}
/* "songs" : [ {
 "duration" : {
 "duration" : "3:25"
 },
 "id" : "82BDE132-E492-4FED-9A77-B49CADBC2BFD",
 "name" : {
 "title" : "My Name Is Jonas"
 } */
struct Song: Decodable {
    let name: String
    let duration: Int
    let title: String
    
    enum SongKeys: String, CodingKey {
        case name
        case duration
        case title
        
        enum DurationKeys: Int, CodingKey {
            case duration
        }
        enum NameDescriptionKeys: String, CodingKey {
            case name
            enum NameKeys: String, CodingKey {
                case title
            }
        }
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.self, forKey: .duration)
        duration = try durationContainer.decode(Int.self, forKey: .duration)
        
        var titleContainer = try container.nestedUnkeyedContainer(forKey: .name)
        var titleName = [String]()
        
        while titleContainer.isAtEnd == false {
            
            let titleDescriptionContainer = try titleContainer.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.self)
            
            let titleContainer = try titleDescriptionContainer.nestedContainer(keyedBy: SongKeys.NameDescriptionKeys.NameKeys, forKey: .name)
            
        }
        
        
        
}


