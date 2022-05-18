//
//  StatisticsView.swift
//  Debug
//
//  Created by 이태현 on 2022/05/18.
//

import SwiftUI

struct StatisticsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var selectCheckBox = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var selectedCropType = 0
    @State private var cropTypes: [String] = ["가지", "감자", "고추", "단호박", "들깨",
                                              "딸기", "무", "배", "배추", "벼",
                                              "사과", "상추", "수박", "애호박", "양배추",
                                              "오이", "옥수수", "쥬키니호박", "참외", "콩",
                                              "토마토", "파", "포도", "호박", "참깨", "팥"]
    
    var body: some View {
//        GeometryReader { geometry in
            VStack {
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
                    
                    Text("통계 조회 기간을 선택하세요.")
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
                           Text("조회 시작 날짜를 선택하세요")
                        }
                        DatePicker(selection: $endDate, in: startDate... , displayedComponents: .date) {
                            Text("조회 종료 날짜를 선택하세요")
                        }
                    }
                    .foregroundColor(selectCheckBox ? .gray : .black)
                    .disabled(selectCheckBox)
                }
                .padding(.top, 25)
                Spacer()
                VStack(spacing: 25) {
                    Text("작물을 선택하세요.")
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
                .padding(.vertical)
                Spacer()
                ScrollView {
                    ForEach(cropTypes, id:\.self) { crop in
                        HStack {
                            Text(crop)
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                            HStack {
                                Text("100")
                                Rectangle()
                                    .foregroundColor(.green)
                                    .frame(width: 50)//50이 아니라 계산한 값
                            }
                            .offset(x: 50-230)//max를 230으로, 고정된 계산한값-230으로 시작점 고정
                        }
                    }
                }
            }
            .onChange(of: selectedCropType) { _ in
                //fetch desease list
            }
            .padding([.leading, .trailing, .bottom])
            .navigationBarHidden(true)
//        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}

