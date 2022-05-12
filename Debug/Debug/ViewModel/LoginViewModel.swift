//
//  LoginViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/12.
//

import Alamofire
import Foundation

class LoginViewModel: ObservableObject {
    
    func login(username: String, password: String) {
        
        let loginRequestBody = LoginRequestBody(username: username, password: password)
        
        let host = "172.30.1.13"
        let url = "http://\(host):8080/login"
        
        AF.request(url, method: .post,parameters: loginRequestBody,encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: LoginResponseBody.self) { response in
                switch response.result {
                case .success(let successResponse):
                    print(successResponse)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
