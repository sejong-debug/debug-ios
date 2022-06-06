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
    @State private var cropTypes: [String] = ["가지", "감자", "고추", "단호박", "들깨",
                                              "딸기", "무", "배", "배추", "벼",
                                              "사과", "상추", "수박", "애호박", "양배추",
                                              "오이", "옥수수", "쥬키니호박", "참외", "콩",
                                              "토마토", "파", "포도", "호박", "참깨", "팥"]
    @State private var selectedCropType = 0
    @State private var projectName = ""
    
    @State var opacityRatio: Double = 0
    
    @State var selectCheckBox = false
    
    @ObservedObject var projectCreateVM = ProjectCreateViewModel()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            VStack(spacing: 25) {
                
                Text("프로젝트 기간을 선택하세요.")
                    .font(.system(size: 25, weight: .bold))
                
                HStack {
                    Text("기간을 선택하지 않겠습니다.")
                    Image(systemName: selectCheckBox ? "checkmark.square"  : "square")
                        .onTapGesture {
                            selectCheckBox.toggle()
                        }
                }
                
                VStack {
                    DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                       Text("프로젝트 시작 날짜를 선택하세요")
                    }
                    DatePicker(selection: $endDate, in: startDate... , displayedComponents: .date) {
                        Text("프로젝트 종료 날짜를 선택하세요")
                    }
                }
                .foregroundColor(selectCheckBox ? .gray : .black)
                .disabled(selectCheckBox)
            }
//            .padding(.top, 25)
            //이 부분
            VStack(spacing: 25) {
                Text("등록할 작물을 선택하세요.")
                    .font(.system(size: 25, weight: .bold))
                
                HStack {
                    Text("선택 작물: ")
                    Picker("tip Perentage", selection: $selectedCropType) {
                        ForEach(0 ..< cropTypes.count ) { index in
                            Text("\(cropTypes[index])")
                        }
                    }
                }
            }
            .pickerStyle(MenuPickerStyle())
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
                        
                        if selectCheckBox == true {
                            let requestBody = ProjectCreateRequestBody(name: projectName,
                                                                       cropType: cropTypes[selectedCropType],
                                                                       startDate: "",
                                                                       endDate: "")
                            
                            projectCreateVM.createProject(projectCreateRequestBody: requestBody)
                            
                        } else {
                            let start = dateFormatter.string(from: startDate)
                            let end = dateFormatter.string(from: endDate)
                            
                            let requestBody = ProjectCreateRequestBody(name: projectName,
                                                                       cropType: cropTypes[selectedCropType],
                                                                       startDate: start,
                                                                       endDate: end)
                            
                            projectCreateVM.createProject(projectCreateRequestBody: requestBody)
                        }
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
        .padding([.leading, .trailing, .bottom])
        .navigationBarHidden(true)
    }
}

struct ProjectCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectCreateView()
    }
}
