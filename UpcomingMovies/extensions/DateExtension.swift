//
//  DateExtensions.swift
//  UpcomingMovies
//
//  Created by Peter Irving on 7/29/21.
//

import Foundation

extension Date {
    func toString () -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d y"
        
        return dateFormatter.string(from: self)
    }
    
    
}
