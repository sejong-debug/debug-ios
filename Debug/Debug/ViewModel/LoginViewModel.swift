//
//  LoginViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/12.
//

import Alamofire
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var loginResult: Bool?
    
    func login(username: String, password: String) {
        
        let loginRequestBody = LoginRequestBody(username: username, password: password)
//        print(username,password)
        let host = "172.30.1.13"
        let url = "http://\(host):8080/login"
        
        AF.request("wrong url login", method: .post,parameters: loginRequestBody,encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: LoginResponseBody.self) { response in
                switch response.result {
                case .success(let successResponse):
//                    UserDefaults.standard.removeObject(forKey: "token")
//                    UserDefaults.standard.set(successResponse.success,forKey: "token")
//                    print(UserDefaults.standard.string(forKey: "token")!)
                    print(successResponse)
                    self.loginResult = true
                case .failure(let error):
                    self.loginResult = true
                    print(error)
                }
        }
    }
}
