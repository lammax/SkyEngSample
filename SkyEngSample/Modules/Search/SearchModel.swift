//
//  SearchModel.swift
//  SkyEngSample
//
//  Created by Максим Ламанский on 29.03.2021.
//

import Foundation

/*
{
    "id": 29909,
    "text": "searchingly",
    "meanings": [
      {
        "id": 107454,
        "partOfSpeechCode": "r",
        "translation": {
          "text": "испытующе",
          "note": ""
        },
        "previewUrl": "//d2zkmv5t5kao9.cloudfront.net/images/56e2b49f44f696c53cfbb661c9072bbd.jpeg?w=96&h=72",
        "imageUrl": "//d2zkmv5t5kao9.cloudfront.net/images/56e2b49f44f696c53cfbb661c9072bbd.jpeg?w=640&h=480",
        "transcription": "ˈsɜːʧɪŋli",
        "soundUrl": "//d2fmfepycn0xw0.cloudfront.net?gender=male&accent=british&text=searchingly"
      }
    ]
  },*/

/*
 n - noun,
 v - verb,
 j - adjective,
 r - adverb,
 prp - preposition,
 prn - pronoun,
 crd - cardinal number,
 cjc - conjunction,
 exc - interjection,
 det - article,
 abb - abbreviation,
 x - particle,
 ord - ordinal number,
 md - modal verb,
 ph - phrase,
 phi - idiom. */

enum Search {
    
    enum SpeechCode: String, Codable {
        case noun = "n"
        case verb = "v"
        case adjective = "j"
        case adverb = "r"
        case preposition = "prp"
        case pronoun = "prn"
        case cardinal = "crd"
        case conjunction = "cjc"
        case interjection = "exc"
        case article = "det"
        case abbreviation = "abb"
        case particle = "x"
        case ordinal = "ord"
        case modal = "md"
        case phrase = "ph"
        case idiom = "phi"
        
        enum CodingKeys: String, CodingKey {
            case noun = "n"
            case verb = "v"
            case adjective = "j"
            case adverb = "r"
            case preposition = "prp"
            case pronoun = "prn"
            case cardinal = "crd"
            case conjunction = "cjc"
            case interjection = "exc"
            case article = "det"
            case abbreviation = "abb"
            case particle = "x"
            case ordinal = "ord"
            case modal = "md"
            case phrase = "ph"
            case idiom = "phi"
        }
    }
    
    struct Translation: Codable {
        let text: String
        let note: String?
    }
    
    struct Meaning: Codable {
        let id: Int
        let partOfSpeechCode: SpeechCode
        let translation: Translation?
        let previewUrl: String
        let imageUrl: String
        let transcription: String
        let soundUrl: String

    }
    
    struct Result: Codable {
        let id: Int
        let text: String
        let meanings: [Meaning]?
    }
    
    struct CellData {
        let text: String
        let detailedText: String?
        
        init(text: String = "", detailedText: String? = nil) {
            self.text = text
            self.detailedText = detailedText
        }
        
        init(searchResult: Search.Result) {
            text = searchResult.text
            detailedText = searchResult.meanings?.first?.translation?.text
        }
    }
    
}
