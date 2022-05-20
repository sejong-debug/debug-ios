//
//  ProjectCreateViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/13.
//

import Alamofire
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

class ProjectCreateViewModel: ObservableObject {
    
    func createProject(projectCreateRequestBody: ProjectCreateRequestBody) {
        
        let url = "/projects"
        
        AF.request("wroing url", method: .post, parameters: projectCreateRequestBody,encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: ProjectCreateResponseBody.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
