//
//  ProjectList.swift
//  Debug
//
//  Created by 이태현 on 2022/03/31.
//

import Foundation

struct ProjectListResponse: Codable, Hashable {
    let name: String?
    let startDate: Date?
    let endDate: Date?
    let cropType: String?
    let error: String?
    
    enum codingKey: String, CodingKey {
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case cropType = "crop_type"
        case error
    }
}
