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
    
//    init() {
//        print("프로젝트 리스트 조회 이니셜라이저 생성")
//        print(UserDefaults.standard.string(forKey: "token")!)
//        loadProjectList(page: 0)
//    }
    
    func loadProjectList(page: Int) {
        
        let urlString = url + "/projects?page=\(page)&size=10"
        print(urlString)
        AF.request(urlString, method: .get, headers: headers)
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
