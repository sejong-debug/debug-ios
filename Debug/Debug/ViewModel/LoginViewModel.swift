//
//  LoginViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isLogin = false
    
    var username = ""
    var password = ""
    
    func login() {
        
        Webservice().login(username: username, password: password) { result in
            
            switch result {
            case .success(let token):
                UserDefaults.standard.setValue(token, forKey: "tokenValue") //토큰저장 test, 여러개 저장하려면 수정해야함
                DispatchQueue.main.async {
                    self.isLogin = true
                }
            case .failure(.custom(errorMessage: let error)):
                DispatchQueue.main.async {
                    self.isLogin = true
                } //login 테스트용 실제로는 sucess일때만 true로 바꿔줘야함
                print(error)
            }
            
        }
    }
    
}
