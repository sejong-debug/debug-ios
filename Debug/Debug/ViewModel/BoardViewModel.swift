//
//  BoardResponse.swift
//  Debug
//
//  Created by 이태현 on 2022/05/25.
//
import Alamofire
import Foundation

class BoardViewModel: ObservableObject {
    
    @Published var boardData: BoardResponse.DataClass? = nil
    
    func boardLoad(projectID: Int, boardID: Int) {
        boardData = nil
        let urlString = url + "/projects" + "/\(projectID)" + "/boards" + "/\(boardID)"
        print("boardLoad 실행 중")
        AF.request(urlString, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: BoardResponse.self) { response in
                switch response.result {
                case .success(let success):
                    print("board실행 완료")
                    self.boardData = success.data
                    print(success)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}
