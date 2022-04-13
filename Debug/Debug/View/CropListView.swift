//
//  CropListView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/13.
//

import SwiftUI

struct CropListView: View {
    let project: ProjectListResponse
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CropListView_Previews: PreviewProvider {
    static var previews: some View {
        let project = ProjectListResponse(name: "testname", startDate: "2020.01.01", endDate: "2020.01.02", cropType: "팥", error: nil)
        return CropListView(project: project)
    }
}
