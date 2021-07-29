//
//  ExtensionTests.swift
//  UpcomingMoviesTests
//
//  Created by Peter Irving on 7/29/21.
//

import XCTest
@testable import UpcomingMovies

class ExtensionTests: XCTestCase {

    func testArrayStringPrintExtension()throws {
        let array = ["action", "comedy"]
        XCTAssertEqual(array.returnListWithCommasAsString(), "action, comedy")
    }

}
