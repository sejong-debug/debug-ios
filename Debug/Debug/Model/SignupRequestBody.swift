//
//  SignupRequestBody.swift
//  Debug
//
//  Created by 이태현 on 2022/03/31.
//

import Foundation

struct SignupRequestBody: Codable {
    var name: String
    var username: String
    var password: String
}
