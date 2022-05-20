//
//  StatisticsViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/20.
//
import Alamofire
import Foundation

struct StatisticsResponseBody: Codable {
    
    let success: Bool
    let data: DataClass
    
    struct DataClass: Codable {
        let cropType: String
        let projectCount: Int
        let diseases: [String: Int]
    }
}

class StatisticsViewModel: ObservableObject {
    
    @Published var data: [StatisticsResponseBody.DataClass] = []
    
    let headers: HTTPHeaders = [
        "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",//나중에 서비스 할때 토큰 넣어줘야함
    ]
    
    func getStatistics() {
        data = []
        AF.request("url 통계 설정해야함", method: .get, headers: headers)
            .validate()
            .responseDecodable(of: StatisticsResponseBody.self) { response in
                switch response.result {
                case .success(let success):
                    self.data.append(success.data)
                    print(success)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
