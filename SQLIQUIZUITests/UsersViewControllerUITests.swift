//
//  UsersViewControllerUITests.swift
//  SQLIQUIZUITests
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 27/2/2023.
//

import XCTest

final class UsersViewControllerUITests: XCTestCase {
    
var sut: UsersViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as? UsersViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTableView() {
        // Test if the table view is not nil
        XCTAssertNotNil(sut.tableView)

        // Test if the table view data source is not nil
        XCTAssertNotNil(sut.tableView.dataSource)

        // Test if the table view delegate is not nil
        XCTAssertNotNil(sut.tableView.delegate)

        // Test if the table view has at least one section
        XCTAssertGreaterThan(sut.tableView.numberOfSections, 0)

        // Test if the table view has at least one row in the first section
        XCTAssertGreaterThan(sut.tableView.numberOfRows(inSection: 0), 0)

        // Test if the first cell in the first section is a UsersViewCell
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.cellForRow(at: indexPath)
        XCTAssertTrue(cell is UsersViewCell)

        // Test if the cell is properly configured
        let usersDataSource = sut.usersDataSource
        let viewModel = usersDataSource[indexPath.row]
        let usersCell = cell as? UsersViewCell
        XCTAssertEqual(usersCell?.nameLabel.text, viewModel.fullName)
        XCTAssertEqual(usersCell?.emailLable.text, viewModel.email)
    }

}

