//
//  CropListView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/13.
//

import SwiftUI

struct BoardListView: View {
    @Environment(\.dismiss) var dismiss
    @State var showingImagePopUp = false
    
    let image = Image(systemName: "plus.circle")
//    let project: ProjectListResponse
    let testArray: [String] = ["test1","test2","test3"]
    
    @State var createBoardIsActive = false
    @State var goToDetectView = false
    
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.black)
                        }

                        Spacer()
//                        Text("작물 목록")
//                            .font(.system(size: 24, weight: .bold))
//                        Spacer()
//                        Image(systemName: "arrow.backward")
//                            .foregroundColor(.black)
//                            .opacity(0)
                    }
                    .padding([.leading,.trailing,.bottom])
                    if !testArray.isEmpty {
                        List {
                            ForEach(testArray, id: \.self) { test in
                                
                                NavigationLink(destination: {
                                    DetectView()
                                }, label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                        Text(test)
                                            .padding(.horizontal)
                                    }
                                })
//                                NavigationLink(destination: DetectView(rootIsActive: $isActive), isActive: $isActive, label: {
//                                        HStack {
//                                            Image(systemName: "circle.fill")
//                                                .resizable()
//                                                .frame(width: 70, height: 70)
//                                            Text(test)
//                                                .padding(.horizontal)
//                                        }
//                                })
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
            }//작물목록 title 다시 만들기
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct CropListView_Previews: PreviewProvider {
    
    static var previews: some View {
//        let project = ProjectListResponse(name: "testname", startDate: "2020.01.01", endDate: "2020.01.02", cropType: "팥", error: nil)
        BoardListView()
    }
}
