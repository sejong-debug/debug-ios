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
            case .success(let sessionToken):
                //UserDefaults.standard.setValue(sessionToken.token, forKey: "tokenValue") //토큰저장 test, 여러개 저장하려면 수정해야함
                if sessionToken.error == nil {
                    //sessionToken 의 token 부분을 클라이언트 부분에서 따로 저장하기
                    DispatchQueue.main.async {
                        self.isLogin = true
                    }
                } else {// error message 출력
                    print(sessionToken.error ?? "nil")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLogin = true
                } //login 테스트용 실제로는 sucess일때만 true로 바꿔줘야함
                print(error)
            }
            
        }
    }
    
}
