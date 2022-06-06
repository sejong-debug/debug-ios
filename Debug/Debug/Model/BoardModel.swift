//
//  BoardModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/25.
//

import Foundation

struct BoardRequest: Codable {
    let projectID: Int
    let boardID: Int
}

struct BoardResponse: Codable {
    let success: Bool
    let data: DataClass
    
    struct DataClass: Codable {
        let boardID: Int
        let memo: String
        let boardImageID: Int
        let boardImageURI: String
        let issues: [String]

        enum CodingKeys: String, CodingKey {
            case boardID = "boardId"
            case memo
            case boardImageID = "boardImageId"
            case boardImageURI = "boardImageUri"
            case issues
        }
    }

}

