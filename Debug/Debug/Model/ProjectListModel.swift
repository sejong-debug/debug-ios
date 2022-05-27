//
//  ProjectListModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/24.
//

import Foundation

struct ProjectListRequest: Codable {
    let page: Int?
    let size: Int?
}
// MARK: - Welcome
struct ProjectListResponse: Codable {
    let success: Bool
    let data: DataClass
    
    struct DataClass: Codable {
        let content: [Content]
        let pageable: Pageable
        let numberOfElements, size: Int
        let first, last: Bool
        let number: Int
        let sort: Sort
        let empty: Bool
    }

    // MARK: - Content
    struct Content: Codable, Hashable {
        let projectID: Int
        let name, cropType: String
        let startDate, endDate: String?
        let completed: Bool

        enum CodingKeys: String, CodingKey {
            case projectID = "projectId"
            case name, cropType, startDate, endDate, completed
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

// MARK: - DataClass



//// MARK: - Welcome
//struct ProjectListResponse: Codable {
//    let success: Bool
//    let data: DataClass
//
//    struct DataClass: Codable {
//        let content: [Content]
//        let pageable: Pageable
//        let numberOfElements, number: Int
//        let sort: Sort
//        let first, last: Bool
//        let size: Int
//        let empty: Bool
//    }
//
//    // MARK: - Content
//    struct Content: Codable, Hashable {
//        let projectID: Int
//        let name, cropType, startDate, endDate: String
//        let completed: Bool
//
//        enum CodingKeys: String, CodingKey {
//            case projectID = "projectId"
//            case name, cropType, startDate, endDate, completed
//        }
//    }
//
//    // MARK: - Pageable
//    struct Pageable: Codable {
//        let sort: Sort
//        let pageNumber, pageSize, offset: Int
//        let paged, unpaged: Bool
//    }
//
//    // MARK: - Sort
//    struct Sort: Codable {
//        let sorted, unsorted, empty: Bool
//    }
//
//}
//
//// MARK: - DataClass
