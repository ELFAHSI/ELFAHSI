//
//  UsersViewModel.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import Foundation
import Combine

class UsersViewModel {
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: UsersModel.DisplayContent!
    var users: Observable<[UsersCellViewModel]> = Observable(nil)
    
    private var cancellables = Set<AnyCancellable>()
    
    // Fetch Data
    func getContents(request: UsersModel.Fetch.Request) {
        Indicator.sharedInstance.showIndicator()
        NetworkManager.shared.getData(from: .wsGetAllUsers, type: UsersModel.Content.self,path: request.page)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("The Error Is : \(err.localizedDescription)")
                case .finished:
                    print(request.page)
                }
            }
            receiveValue: { response in
                let viewModel =  UsersModel.Fetch.ViewModel(response: response)
                self.dataSource = viewModel.contents
                Indicator.sharedInstance.hideIndicator()
                self.mapUsersData()
            }
            .store(in: &cancellables)
    }
    
    // Binding
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.users.count ?? 0
    }
    
    private func mapUsersData() {
        users.value = self.dataSource?.users.compactMap({ UsersCellViewModel(user: $0) })
    }
    
}
