//
//  CropListView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/13.
//

import SwiftUI

struct BoardListView: View {
    @State var showingImagePopUp = false
    let image = Image(systemName: "plus.circle")
    let project: ProjectListResponse
    let testArray: [String] = []
    
    var body: some View {
        ZStack {
            VStack {
                if !testArray.isEmpty {
                    List {
                        ForEach(testArray, id: \.self) { test in
                            Text(test)
            //                HStack {
            //
            //                } //불러올 이미지 + 메모내용 불러오기
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                    Text("작물이 존재하지 않습니다.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("오른쪽 아래 \(image) 버튼을 통해 생성해주세요.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button {
                        showingImagePopUp.toggle()
                    } label: {
                        image
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                    }
                }
                .padding(.trailing)
                .frame(height:40)
            }
            ImagePopUpView(showing: $showingImagePopUp)
        }
        .navigationTitle("작물 목록")
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
