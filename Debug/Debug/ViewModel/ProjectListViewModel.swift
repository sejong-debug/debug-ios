//
//  ProjectListViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/13.
//

import Alamofire
import Foundation

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
