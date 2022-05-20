//
//  createMemoViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/20.
//

import Alamofire
import Foundation

struct createBoardRequest: Codable {
    let projectID: Int
    let memo: String
    let image: Data
}

struct createBoardResponse: Codable {
    let success: Bool
    let data: Int
}

class CreateMemoViewModel: ObservableObject {
    
    let headers: HTTPHeaders = [
        "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",//나중에 서비스 할때 토큰 넣어줘야함
        "Accept": "application/json"
    ]
    
    func uploadBoard(createBoard: createBoardRequest) {
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(String(createBoard.projectID).utf8),
                                                withName: "projectId")
            multipartFormData.append(Data(createBoard.memo.utf8),
                                                 withName: "memo")
            multipartFormData.append(createBoard.image,withName: "image")
            
        }, to: "board 생성 url 오류", headers: headers)
        .responseDecodable(of: createBoardResponse.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

var dict: [String:Int] = [:]
