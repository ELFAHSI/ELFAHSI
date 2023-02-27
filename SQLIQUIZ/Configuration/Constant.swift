//
//  Constant.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import Foundation

public enum DateFormat: String {
    case universal = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}

extension String {
    // MARK: - Webservice

    static let wsUrl = "WS_URL"
    static let wsMethod = "WS_METHOD"
    static let wsDemo = "WS_DEMO"

    // MARK: - WebService names

    static let wsGetAllUsers = "WS_GET_ALL_USERS"

}
