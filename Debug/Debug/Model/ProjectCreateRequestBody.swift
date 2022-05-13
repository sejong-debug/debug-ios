//
//  ProjectCreateRequestBody.swift
//  Debug
//
//  Created by 이태현 on 2022/05/13.
//

import Foundation

struct ProjectCreateRequestBody: Codable {
    var name: String
    var cropType: String
    var startDate: String
    var endDate: String
}
