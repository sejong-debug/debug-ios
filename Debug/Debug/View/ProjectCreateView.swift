//
//  ProjectCreateView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/13.
//

import SwiftUI

struct ProjectCreateView: View {
    @Environment(\.dismiss) var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var cropTypes: [String] = ["참깨", "콩", "팥"]
    @State private var selectedCropType = 0
    @State private var projectName = ""
    
    @State var opacityRatio: Double = 0
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("프로젝트 생성")
                    .font(.system(size: 30, weight: .bold))
                Spacer()
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        dismiss()
                    }
            }
            
            Divider()
                .padding(.horizontal, -15)
            VStack(spacing: 25) {
                Text("프로젝트 기간을 선택하세요.")
                    .font(.system(size: 25, weight: .bold))
                DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                   Text("프로젝트 시작 날짜를 선택하세요")
                }
                DatePicker(selection: $endDate, in: Date()... , displayedComponents: .date) {
                    Text("프로젝트 종료 날짜를 선택하세요")
                }
            }
            .padding(.top, 25)
            
            VStack(spacing: 25) {
                Text("작물을 선택하세요.")
                    .font(.system(size: 25, weight: .bold))

                Picker("tip Perentage", selection: $selectedCropType) {
                    ForEach(0 ..< cropTypes.count) { index in
                        Text("\(cropTypes[index])")
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding(.top, 25)
            
            VStack(spacing: 25) {
                Text("프로젝트 이름을 작성하세요.")
                    .font(.system(size: 25, weight: .bold))

                TextField("프로젝트 이름", text: $projectName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.top, 25)
            Spacer()
            
            VStack {
                HStack {
                    Text("프로젝트 이름을 작성해주세요.")
                        .foregroundColor(.red)
                        .opacity(opacityRatio)
                    Spacer()
                }
                Button {
                    //프로젝트 생성 완료 action 추가해야함 서버로 프로젝트 생성 인코딩 부분임
                    print("\(startDate)")
                    print("\(endDate)")
                    print("\(cropTypes[selectedCropType])")
                    print(projectName) // test code
                    
                    if !projectName.isEmpty {
                        dismiss()
                    } else {
                        opacityRatio = 1
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10).foregroundColor(.green)
                        Text("프로젝트 생성 완료")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .frame(height:50)
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct ProjectCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCreateView()
    }
}
