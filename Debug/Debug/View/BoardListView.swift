//
//  CropListView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/13.
//

import SwiftUI

struct BoardListView: View {
    @State var showingImagePopUp = false
    
    let project: ProjectListResponse
    let testArray = ["내용", "메모"]
    
    var body: some View {
        
        ZStack {
            List {
                ForEach(testArray, id: \.self) { test in
                    Text(test)
                        .onTapGesture {
                            showingImagePopUp.toggle()
                        }
    //                HStack {
    //
    //                } //불러올 이미지 + 메모내용 불러오기
                }
            }
            .listStyle(PlainListStyle())
            ImagePopUpView(showing: $showingImagePopUp)
        }
        .navigationTitle("작물목록")
    }
}

struct CropListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let project = ProjectListResponse(name: "testname", startDate: "2020.01.01", endDate: "2020.01.02", cropType: "팥", error: nil)
        NavigationView {
            BoardListView(project: project)
        }
    }
}
