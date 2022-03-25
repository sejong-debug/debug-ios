//
//  Webservice.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import Foundation

enum SignupError: Error {
    case custom(errorMessage: String)
}

enum LoginError: Error {
    case custom(errorMessage: String)
}

struct SignupRequestBody: Codable {
    var username: String
    var password: String
}

struct LoginRequestBody: Codable {
    var username: String
    var password: String
}

class Webservice {
    
    func signup(username: String, password: String, completionHandler: @escaping (Result<String, SignupError>) -> Void ) {
        
        guard let url = URL(string: "") else {
            completionHandler(.failure(.custom(errorMessage: "url 오류")))
            return
        } // 회원가입에 필요한 url 설정해야함
        
        let body = SignupRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: url) { _, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(.failure(.custom(errorMessage: "response 오류")))
                return
            }
            
            guard error == nil else {
                completionHandler(.failure(.custom(errorMessage: "error 발생")))
                return
            }
            
            completionHandler(.success("성공"))
        }.resume()
        
    }
    
    func login(username: String, password: String, completionHandler: @escaping (Result<String, LoginError>) -> Void) {
        
        guard let url = URL(string: "") else {
            completionHandler(.failure(.custom(errorMessage: "url 오류")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: url) { _, response, error in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300,
                error == nil else {
                
                completionHandler(.failure(.custom(errorMessage: "로그인 요청 보낼때 data 오류, response 오류, error 셋중 하나 발생")))
                
                return
            }
            
            let token = response.value(forHTTPHeaderField: "Autorization")
            
            completionHandler(.success(token ?? "성공은 했는데 token을 못받은 경우"))
        }
    }
}
