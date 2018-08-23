//
//  Country.swift
//  ios-list2
//
//  Created by Michael Kofler on 17.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import Foundation

struct Country {
  var name: String
  var population: Int
  var area: Double
  var capital: String
  
  // aus Textdatei 'bundesländer.txt' lesen,
  // Spalten sind durch Tabs getrennt,
  // deutsche Kommas als Dezimaltrenner
  static func readFromBundle() -> [Country] {
    var data = [Country]()
    let fmt = NumberFormatter()
    fmt.numberStyle = .decimal
    fmt.locale = Locale(identifier: "de_DE")
    
    if let path =  Bundle.main.path(
      forResource: "bundesländer", ofType: "txt")
    {
      do {
        let txt =  try String(contentsOfFile: path,
                              encoding: .utf8)
        let lines = txt.characters.split() {$0 == "\n"}
          .map { String($0) }
        for line in lines {
          let columns = line.characters.split() {$0 == "\t"}
            .map { String($0) }
          if columns.count == 4 {
            let name = columns[0]
            let area = Double(fmt.number(from: columns[1]) ?? 0.0)
            let pop = Int(columns[2]) ?? 0
            let cap = columns[3]
            data.append(Country(name: name,
                                population: pop,
                                area: area,
                                capital: cap))
          }
        }  // for
      } catch _ {}
    }  // if let
    
    return data
  }
}
