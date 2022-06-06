//
//  BoardListModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/25.
//

import Foundation

struct BoardListRequest: Codable {
    let page: Int
}

// MARK: - Welcome
struct BoardListResponse: Codable {
    let success: Bool
    let data: DataClass
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let content: [Content]
        let pageable: Pageable
        let numberOfElements, size, number: Int
        let first, last: Bool
        let sort: Sort
        let empty: Bool
    }

    // MARK: - Content
    struct Content: Codable, Hashable {
        let boardID: Int
        let memo: String
        let boardImageID: Int
        let boardImageURI: String

        enum CodingKeys: String, CodingKey {
            case boardID = "boardId"
            case memo
            case boardImageID = "boardImageId"
            case boardImageURI = "boardImageUri"
        }
    }

    // MARK: - Pageable
    struct Pageable: Codable {
        let sort: Sort
        let pageNumber, pageSize, offset: Int
        let paged, unpaged: Bool
    }

    // MARK: - Sort
    struct Sort: Codable {
        let unsorted, sorted, empty: Bool
    }

}

