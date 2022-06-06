//
//  LoginModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/24.
//

import Foundation

struct LoginRequestBody: Codable {
    var username: String
    var password: String
}

struct LoginResponseBody: Codable {
    let success: Bool
    let data: DataClass
}

struct DataClass: Codable {
    let accessToken: String
}
