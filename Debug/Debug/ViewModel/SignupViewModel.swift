//
//  SignupViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var isSignup = false
    
    var name = ""
    var username = ""
    var password = ""
    
    func signup() {
        
        Webservice().signup(name: name, username: username, password: password) { result in
            
            switch result {
            case .success(let message):
                DispatchQueue.main.async {
                    self.isSignup = true
                }
                print(message)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isSignup = true
                } // 테스트용
                print(error)
            }
        }
    }
}
