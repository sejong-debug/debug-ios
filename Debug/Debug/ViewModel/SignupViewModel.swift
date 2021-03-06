//
//  SignUpViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/12.
//

import Alamofire
import Foundation

class SignUpViewModel: ObservableObject {
    
    func signUp(username: String,password: String,name: String) {
        
        let signUpRequestBody = SignUpReqeustBody(username: username, password: password, name: name)
 
        let urlString = url + "/members"
        
        AF.request(urlString, method: .post, parameters: signUpRequestBody, encoder: JSONParameterEncoder.default)
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
