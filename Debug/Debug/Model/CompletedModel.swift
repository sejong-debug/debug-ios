//
//  CompletedModel.swift
//  Debug
//
//  Created by 이태현 on 2022/06/02.
//

import Foundation

struct CompletedRequestBody: Codable {
    let completed:Bool
}

struct CompletedResponseField: Codable {
    let success: Bool
    let data: Int
}
