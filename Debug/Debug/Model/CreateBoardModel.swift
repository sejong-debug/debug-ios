//
//  CreateMemoModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/24.
//

import Foundation

struct createBoardRequest: Codable {
//    let projectID: Int
    let memo: String
    let image: Data
}

struct createBoardResponse: Codable {
    let success: Bool
    let data: Int
}
