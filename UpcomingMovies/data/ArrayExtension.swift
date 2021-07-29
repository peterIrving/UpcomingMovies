//
//  ListExtension.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/27/21.
//

import Foundation

extension Array where Element == String {
    func returnListWithCommasAsString()-> String {
        var string: String?
           for element in self {
               if string == nil {
                   string = element
               } else {
               string = string! + ", " + element
               }
           }
        return string!
    }

}
