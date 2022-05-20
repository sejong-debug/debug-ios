//
//  ProjectListViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/13.
//

import Alamofire
import Foundation


struct ProjectListRequest: Codable {
    let page: Int
}

// MARK: - Welcome
struct ProjectListResponse: Codable {
    let success: Bool
    let data: DataClass
    
    struct DataClass: Codable {
        let content: [Content]
        let pageable: Pageable
        let numberOfElements, number: Int
        let sort: Sort
        let first, last: Bool
        let size: Int
        let empty: Bool
    }

    // MARK: - Content
    struct Content: Codable, Hashable {
        let projectID: Int
        let name, cropType, startDate, endDate: String
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
        let sorted, unsorted, empty: Bool
    }

}

// MARK: - DataClass


class ProjectListViewModel: ObservableObject {
    
    @Published var projectListData: [[ProjectListResponse.Content]] = []
    
    init() {
        loadProjectList(page: 0)
    }
    
    func loadProjectList(page: Int) {
        
        //URL = /projects?page=0&size=10
        
        AF.request("wrong url projectList", method: .post, parameters: ProjectListRequest(page: page), encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: ProjectListResponse.self) { response in
                
                switch response.result {
                case .success(let project):
                    self.projectListData.append(project.data.content)
                case .failure(let error):
                    print(error)
                }
                
            }
        
    }
    
}
