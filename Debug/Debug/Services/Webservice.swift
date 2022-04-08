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

enum projectListError: Error {
    case custom(errorMessage: String)
}

class Webservice {
    
    func signup(name: String, username: String, password: String, completionHandler: @escaping (Result<String, SignupError>) -> Void ) {
        
        guard let url = URL(string: "") else {
            completionHandler(.failure(.custom(errorMessage: "회원가입 url 오류")))
            return
        } // 회원가입에 필요한 url 설정해야함
        
        let body = SignupRequestBody(name: name, username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(.failure(.custom(errorMessage: "회원가입 response 오류")))
                return
            }
            
            guard error == nil else {
                completionHandler(.failure(.custom(errorMessage: "회원가입 error 발생")))
                return
            }
            
            completionHandler(.success("성공"))
        }.resume()
        
    }
    
    func login(username: String, password: String, completionHandler: @escaping (Result<SessionToken, LoginError>) -> Void) {
        
        guard let url = URL(string: "") else {
            completionHandler(.failure(.custom(errorMessage: "로그인 url 오류")))
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                guard let token = response.value(forHTTPHeaderField: "Autorization") else {
                    completionHandler(.failure(.custom(errorMessage: "Missing access token")))
                    return
                }
                
                guard let data = data, error == nil else { return }
                guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else { return }
                guard let errorMessage = loginResponse.error else { return }
                
                let sessionToken = SessionToken(token: token, error: errorMessage)
                
                completionHandler(.success(sessionToken))
            }
        }
        .resume()
    }
    
    func fetchProjectList(completionHandler: @escaping (Result<String, projectListError>) -> Void) {
        
        guard let url = URL(string: "") else {
            completionHandler(.failure(.custom(errorMessage: "로그인 url 오류")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
        }
        .resume()
        
    }
}
