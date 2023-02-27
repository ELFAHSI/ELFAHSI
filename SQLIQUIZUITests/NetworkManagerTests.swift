//
//  NetworkManagerTests.swift
//  SQLIQUIZUITests
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 27/2/2023.
//

import XCTest
import Combine

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testGetData() {
        // Given
        let expectation = XCTestExpectation(description: "fetch data from network")
        
        // When
        let publisher: Future<[String: String], Error> = networkManager.getData(from: "https://jsonplaceholder.typicode.com/todos/1", type: [String: String].self)
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Failed to fetch data with error: \(error.localizedDescription)")
            case .finished:
                expectation.fulfill()
            }
        }, receiveValue: { value in
            // Then
            XCTAssertNotNil(value)
            XCTAssertEqual(value["title"], "delectus aut autem")
        })
        .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
}
