//
//  StatisticsViewModel.swift
//  Debug
//
//  Created by 이태현 on 2022/05/20.
//
import Alamofire
import Foundation

class StatisticsViewModel: ObservableObject {
    
    @Published var data: StatisticsResponseBody.DataClass? = nil
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }
    
    func getStatistics(cropType: String, startDate: String, endDate: String) {
        data = nil
        let urlString = url + "/statistics/crop-types"
        
        let end = dateFormatter.string(from: Date())
        
        let parameters: Parameters = [
            "cropType" : cropType,
            "startDate": startDate == "" ? "0000-01-01" : startDate,
            "endDate": endDate == "" ? end : endDate
        ]
        
        AF.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
            .validate()
            .responseDecodable(of: StatisticsResponseBody.self) { response in
                switch response.result {
                case .success(let success):
                    self.data = success.data
                    print(success)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
