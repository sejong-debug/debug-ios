//
//  LoginViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/12.
//

import Alamofire
import Foundation

let host = "192.168.0.27"
let port = "8080"
let url = "http://\(host):\(port)"

let headers: HTTPHeaders = [
    "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)"//나중에 서비스 할때 토큰 넣어줘야함
//    "Authorization": "bearer token"
]

class LoginViewModel: ObservableObject {
    
    @Published var loginResult: Bool?
    
    func login(username: String, password: String) {
        
        let loginRequestBody = LoginRequestBody(username: username, password: password)

        let urlString = url + "/login"
        
        AF.request(urlString, method: .post,parameters: loginRequestBody,encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: LoginResponseBody.self) { response in
                switch response.result {
                case .success(let successResponse):
                    UserDefaults.standard.removeObject(forKey: "token")//기존 토큰 제거해주고
                    UserDefaults.standard.set(successResponse.data.accessToken,forKey: "token")//토큰 설정하주고
                    print(UserDefaults.standard.string(forKey: "token")!)//잘 저장 됐는지 출력 해 주고
                    print(successResponse)
                    self.loginResult = true
                case .failure(let error):
                    self.loginResult = false
                    print(error)
                }
        }
    }
}
