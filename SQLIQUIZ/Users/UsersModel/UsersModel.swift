//
//  UsersModel.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import Foundation

enum UsersModel {
    
    // MARK: - Content
    struct Content: Codable {
        let page: Int?
        let perPage: Int?
        let total: Int?
        let totalPages: Int?
        let users: [User]?
        let support: Support?
        
        enum CodingKeys: String, CodingKey {
            case page
            case perPage = "per_page"
            case total
            case totalPages = "total_pages"
            case users = "data"
            case support
        }
    }
    
    // MARK: - Display Content
    struct DisplayContent: Codable {
        let page: Int
        let perPage: Int
        let total: Int
        let totalPages: Int
        let users: [DisplayUser]
        let support: DisplaySupport
        
        init(content: Content){
            page = content.page ?? 0
            perPage = content.perPage ?? 0
            total = content.total ?? 0
            totalPages = content.totalPages ?? 0
            users = (content.users ?? []).map(DisplayUser.init)
            support = DisplaySupport(support: content.support ?? Support(url: "", text: ""))
        }
    }
    
    // MARK: - User
    struct User: Codable {
        let id: Int?
        let email: String?
        let firstName: String?
        let lastName: String?
        let avatar: String?
        
        enum CodingKeys: String, CodingKey {
            case id, email
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar
        }
    }
    
    // MARK: - Display User
    struct DisplayUser: Codable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let avatar: String
        
        init(user: User){
            id = user.id ?? 0
            email = user.email ?? ""
            firstName = user.firstName ?? ""
            lastName = user.lastName ?? ""
            avatar = user.avatar ?? ""
        }
    }
    
    // MARK: - Support
    struct Support: Codable {
        let url: String?
        let text: String?
    }
    
    // MARK: - Display Support
    struct DisplaySupport: Codable {
        let url: String
        let text: String
        
        init(support: Support){
            url = support.url ?? ""
            text = support.text ?? ""
        }
    }
    
    // MARK: - Fetch
    struct Fetch {
        struct Request {
            let page: String
        }
        
        typealias Response = Content
        
        struct ViewModel {
            let contents: DisplayContent
            
            init(response: Response) {
                contents = DisplayContent(content: response)
            }
        }
    }
    
}
