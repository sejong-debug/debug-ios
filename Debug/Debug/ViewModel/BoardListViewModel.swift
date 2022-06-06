//
//  BoardListViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/25.
//

import Alamofire
import Foundation

class BoardListViewModel: ObservableObject {
    
    @Published var boardListData: [[BoardListResponse.Content]] = []
    @Published var diseaseCount: Int?
    
    func loadBoardList(projectID: Int, page: Int) {

        let urlString = url + "/projects" + "/\(projectID)/boards?page=\(page)&size=10"
        
        AF.request(urlString, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: BoardListResponse.self) { response in
                switch response.result {
                case .success(let board):
                    self.boardListData.append(board.data.content)
                    print("boardLoad success")
                case .failure(let error):
                    print("boardList load error")
                    print(error)
                }
            }
    }
    
    func loadDeseaseCount(projectID: Int) {//질병 갯수
        
        let urlString = url + "/statistics/projects/\(projectID)"
        
        AF.request(urlString, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: diseaseResponse.self) { response in
                switch response.result {
                case .success(let success):
                    self.diseaseCount = success.data
                    print(success.data)
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    func modifyCompleted(completed: Bool) {
        
        let parameters: Parameters = [
            "completed" : false
        ]

        let urlString = url + "/projects/1/completed"
        
        AF.request(urlString, method: .put, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .validate()
            .responseDecodable(of: CompletedResponseField.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
