//
//  CodeChallengeTests.swift
//  CodeChallengeTests
//
//  Created by Ivan Alejandro Hernandez Sanchez on 07/02/25.
//

import Testing
@testable import CodeChallenge
import XCTest

class FlickrViewModelTests: XCTestCase {
    func testFetchPhotos() {
        let viewModel = FlickrViewModel()
        let expectation = XCTestExpectation(description: "Fetch photos")

        viewModel.fetchPhotos(for: "dog")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertFalse(viewModel.photos.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
}
