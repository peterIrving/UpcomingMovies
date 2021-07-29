//
//  StringExtension.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation


extension String {
    func toDate ()->Date?{
        var returnedDate: Date?
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: self) {
            returnedDate = date
        }
        return returnedDate
    }
}
