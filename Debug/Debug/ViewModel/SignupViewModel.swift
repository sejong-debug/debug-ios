//
//  SignUpViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/12.
//

import Alamofire
import Foundation

struct SignUpReqeustBody: Codable {
    var username: String
    var password: String
    var name: String
}

struct SignUpResponseBody: Codable {
    let success: Bool
}


class SignUpViewModel: ObservableObject {
    
    func signUp(username: String,password: String,name: String) {
        
        let signUpRequestBody = SignUpReqeustBody(username: username, password: password, name: name)
        
        let host = "172.30.1.13"
        let url = "http://\(host):8080/members"
        AF.request("wrong url", method: .post, parameters: signUpRequestBody, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: SignUpResponseBody.self) { result in
                switch result.result {
                case .success(let response):
                    print(response)
                case .failure(let fail):
                    print(fail)
                }
            }
    }

}
