//
//  UsersViewModelTests.swift
//  SQLIQUIZUITests
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 27/2/2023.
//

import XCTest
import Combine
@testable import SQLIQUIZ

class UsersViewModelTests: XCTestCase {
    
    var sut: UsersViewModel!
    var mockNetworkManager: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sut = UsersViewModel()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testGetContentsFailure() {
        // Given
        let expectedError = NetworkError.invalidURL
        let request = UsersModel.Fetch.Request(page: "1")
        mockNetworkManager.stubbedGetDataResult = .failure(expectedError)
        
        // When
        sut.getContents(request: request)
        
        // Then
        XCTAssertTrue((sut.isLoadingData.value != nil))
        XCTAssertNil(sut.dataSource)
        XCTAssertNil(sut.users.value)
        XCTAssertEqual(sut.numberOfSections(), 2)
        XCTAssertEqual(sut.numberOfRows(in: 0), 0)
        XCTAssertEqual(sut.numberOfRows(in: 1), 0)
        XCTAssertTrue(sut.users.value?.isEmpty ?? true)
        XCTAssertEqual(mockNetworkManager.invokedGetDataCount, 1)
        
    }
        
}

// A mock implementation of the NetworkManager protocol for testing
class MockNetworkManager: NetworkManager {
    
    var stubbedGetDataResult: Result<Decodable, Error>!
    var invokedGetDataCount = 0
    
    
    override func getData<T: Decodable>(from: String, type: T.Type, path: String? = nil) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = URL(string: self.geturl(ws: from,path: path)) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
        }
    }
}
