//
//  util_Tests.swift
//  body-pix-swiftTests
//
//  Created by George Dambara on 2024/08/10.
//

import XCTest
@testable import body_pix_swift

final class util_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToInputResolutionHeightAndWidth() throws {
        let input:InputSize = (453, 690);
        let resolution:BodyPixInternalResolution = .medium;
        
        let result:(Int, Int) =  ToInputResolutionHeightAndWidth(internalResolution: resolution, outputStride: .value16, size: input)
        
        XCTAssertEqual(result.0, 225)
        XCTAssertEqual(result.1, 337)
    }


}
