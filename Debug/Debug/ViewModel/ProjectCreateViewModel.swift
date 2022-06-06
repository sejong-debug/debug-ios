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
        
        let urlString = url + "/projects"
        
        AF.request(urlString, method: .post, parameters: projectCreateRequestBody, encoder: JSONParameterEncoder.default, headers: headers)
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
