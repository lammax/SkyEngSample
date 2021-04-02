//
//  SkyEngSampleTests.swift
//  SkyEngSampleTests
//
//  Created by Максим Ламанский on 29.03.2021.
//

import XCTest
@testable import SkyEngSample

class SkyEngSampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURL() throws {
        let url = REST.URLS().getEndPoint(for: .search, text: "text")
        XCTAssertTrue(url != nil)
        XCTAssertTrue(url?.absoluteString == "https://dictionary.skyeng.ru/api/public/v1/words/search?search=text")
    }


}
