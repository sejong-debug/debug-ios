//
//  SignUpModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/24.
//

import Foundation

struct SignUpReqeustBody: Codable {
    var username: String
    var password: String
    var name: String
}

struct SignUpResponseBody: Codable {
    let success: Bool
}
