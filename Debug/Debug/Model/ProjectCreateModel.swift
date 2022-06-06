//
//  ProjectCreateModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/24.
//

import Foundation

struct ProjectCreateRequestBody: Codable {
    var name: String
    var cropType: String
    var startDate: String
    var endDate: String
}

struct ProjectCreateResponseBody: Codable {
    let success: Bool
    let data: Int
}
