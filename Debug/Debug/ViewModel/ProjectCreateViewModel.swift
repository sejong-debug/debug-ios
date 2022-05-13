//
//  ProjectCreateViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/13.
//

import Alamofire
import Foundation

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
