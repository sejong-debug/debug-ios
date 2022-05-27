//
//  StatisticsModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/24.
//

import Foundation

struct StatisticsResponseBody: Codable {
    
    let success: Bool
    let data: DataClass
    
    struct DataClass: Codable, Hashable {
        let cropType: String
        let projectCount: Int
        let diseases: [String: Int]
    }
}
