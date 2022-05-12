//
//  LoginResponseBody.swift
//  Debug
//
//  Created by 이태현 on 2022/05/12.
//

import Foundation

struct LoginResponseBody: Codable {
    let success: Bool
    let data: DataClass
}

struct DataClass: Codable {
    let accessToken: String
}
