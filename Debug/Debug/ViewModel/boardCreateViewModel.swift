//
//  createMemoViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/20.
//

import Alamofire
import Foundation


class boardCreateViewModel: ObservableObject {
    
    @Published var boardID: Int? = nil
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token")!)",//나중에 서비스 할때 토큰 넣어줘야함
        "Content-Type": "multipart/form-data"
    //    "Authorization": "bearer token"
    ]
    
    func uploadBoard(createBoard: createBoardRequest, projectID: Int) {
        
        let urlString = url + "/projects" + "/\(projectID)" + "/boards"
        
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(Data(createBoard.memo.utf8), withName: "memo")
            multipartFormData.append(createBoard.image,withName: "image", fileName: "test.jpeg", mimeType: "image/jpeg")
            
        }, to: urlString, headers: headers)
        .responseDecodable(of: createBoardResponse.self) { response in
            switch response.result {
            case .success(let success):
                self.boardID = success.data
                print(success)
            case .failure(let error):
                print("multipart error")
                print(error)
            }
        }
    }
    
}

