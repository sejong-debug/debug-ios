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
    @State var total: CGFloat = 0
    @ObservedObject var statisticsVM = StatisticsViewModel()
    
    @State private var cropTypes: [String] = ["가지", "감자", "고추", "단호박", "들깨",
                                              "딸기", "무", "배", "배추", "벼",
                                              "사과", "상추", "수박", "애호박", "양배추",
                                              "오이", "옥수수", "쥬키니호박", "참외", "콩",
                                              "토마토", "파", "포도", "호박", "참깨", "팥"]
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }
    
    var body: some View {
        GeometryReader { geometry in
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
                    if statisticsVM.data == nil {
//                        ProgressView()
//                        let value1: CGFloat = 55
//                        let value2: CGFloat = 24
//                        let sum = value1+value2
//                        let max = value1
//                        VStack(alignment: .leading) {
//                            HStack(spacing: 80) {
//                                Text("Hello")
//                                    .frame(width: 40)
//                                Rectangle()
//                                    .foregroundColor(.green)
//                                    .frame(width: value1*280/sum)
//                            }
//                            HStack(spacing: 80) {
//                                Text("Hi")
//                                    .frame(width: 40)
//                                Rectangle()
//                                    .frame(width: value2*280/sum)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
                    } else {
                        let dict = statisticsVM.data!.diseases.sorted(by: {$0.1 > $1.1 })

//                        let maxValue = CGFloat(statisticsVM.data!.diseases.values.max()!)
                        VStack(alignment: .leading) {
                            ForEach(0 ..< dict.count) { index in
                                HStack(spacing: 60) {
                                    Text(dict[index].key)
                                        .font(.system(size: 14, weight: .semibold))
                                        .frame(width: 100)
                                    HStack {
                                        Text("\(dict[index].value)")
                                        .font(.system(size: 14, weight: .semibold))
                                        .frame(width: 30)
                                        if total != 0 {
                                            Rectangle()
                                                .foregroundColor(.green)
                                                .frame(width: CGFloat((CGFloat(dict[index].value)/total*100)),
                                                       height: 14)//50이 아니라 계산한 값
                                        }
                                    }
                                    .onAppear {
                                        print(CGFloat((CGFloat(dict[index].value)/total*100)))
                                    }
                                }
                                .onAppear {
                                    total += CGFloat(dict[index].value)
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: selectedCropType) { _ in
                //fetch desease list
                total = 0
                if selectCheckBox == true {
                    statisticsVM.getStatistics(cropType: cropTypes[selectedCropType], startDate: "", endDate: "")
                } else {
                    let start = dateFormatter.string(from: startDate)
                    let end = dateFormatter.string(from: endDate)
                    statisticsVM.getStatistics(cropType: cropTypes[selectedCropType], startDate: start, endDate: end)
                }
            }
            .onChange(of: endDate) { _ in
                //fetch desease list
                total = 0
                if selectCheckBox == true {
                    statisticsVM.getStatistics(cropType: cropTypes[selectedCropType], startDate: "", endDate: "")
                } else {
                    let start = dateFormatter.string(from: startDate)
                    let end = dateFormatter.string(from: endDate)
                    statisticsVM.getStatistics(cropType: cropTypes[selectedCropType], startDate: start, endDate: end)
                }
            }
            .onChange(of: startDate) { _ in
                //fetch desease list
                total = 0
                if selectCheckBox == true {
                    statisticsVM.getStatistics(cropType: cropTypes[selectedCropType], startDate: "", endDate: "")
                } else {
                    let start = dateFormatter.string(from: startDate)
                    let end = dateFormatter.string(from: endDate)
                    statisticsVM.getStatistics(cropType: cropTypes[selectedCropType], startDate: start, endDate: end)
                }
            }
            .padding([.leading, .trailing, .bottom])
            .navigationBarHidden(true)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}

