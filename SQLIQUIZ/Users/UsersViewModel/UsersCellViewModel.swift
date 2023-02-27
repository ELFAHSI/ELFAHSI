//
//  UsersCellViewModel.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import Foundation


class UsersCellViewModel {
    var id: Int
    var fullName: String
    var email: String
    var profilLink: String
    
    init(user: UsersModel.DisplayUser) {
        self.id = user.id
        self.fullName = user.firstName + " " + user.lastName
        self.id = user.id
        self.email = user.email
        self.profilLink = user.avatar
    }
   
}
