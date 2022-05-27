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
    
    @State var createBoardIsActive = false
    @State var goToDetectView = false
    
    @State var isActive = false
    
    @State var page = 0
    
    let spaceName = "scroll"

    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    @State var projectID: Int = 0
    @ObservedObject var boardListVM = BoardListViewModel()
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
                        Text("작물조회")
                        Spacer()
                        
                    }
                    .padding([.leading,.trailing,.bottom])
                    if !boardListVM.boardListData.isEmpty {
                        ChildSizeReader(size: $wholeSize) {
                            ScrollView {
                                ChildSizeReader(size: $scrollViewSize) {
                                    VStack(spacing: 20) {
                                        ForEach(boardListVM.boardListData.flatMap{ $0 }, id: \.self) { board in
                                            NavigationLink(destination: {
                                                DetectView(projectID: projectID, boardID: board.boardID)
                                            }, label: {
                                                HStack {
                                                    AsyncImage(url: URL(string: board.boardImageURI)) { image in
                                                        image
                                                            .resizable()
                                                            .scaledToFit()
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                    .frame(width: 70, height: 70) //이미지 처리 부분
                                                    Spacer()
                                                    Text(board.memo)
                                                        .padding(.horizontal)
                                                }
                                                .background(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(lineWidth: 2)
                                                        .foregroundColor(.green)
                                                )
                                            })
                                        }
                                    }
                                    .listStyle(PlainListStyle())
                                    .background(
                                        GeometryReader { proxy in
                                            Color.clear.preference(
                                                key: ViewOffsetKey.self,
                                                value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                                            )
                                        }
                                    )
                                    .onPreferenceChange(
                                        ViewOffsetKey.self,
                                        perform: { value in
                                            print("offset: \(value)") // offset: 1270.3333333333333 when User has reached the bottom
                                            print("height: \(scrollViewSize.height)") // height: 2033.3333333333333

                                            if value >= scrollViewSize.height - wholeSize.height {
                                                if boardListVM.boardListData.flatMap({ $0 }).count == (page+1)*10 {
                                                    boardListVM.loadBoardList(projectID: projectID, page: page)
                                                    page += 1
                                                }
                                                print("User has reached the bottom of the ScrollView.")
                                                print(page)
                                            } else {
                                                print("not reached.")
                                            }
                                        }
                                    )
                                }
                            }
                            .coordinateSpace(name: spaceName)
                        }
                        .onChange(
                            of: scrollViewSize,
                            perform: { value in
                                print(value)
                            }
                        )
                        .padding(.horizontal)
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
                ImagePopUpView(showing: $showingImagePopUp, projectID: projectID)
            }//작물목록 title 다시 만들기
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .onAppear {
            if page == 0 {
                boardListVM.loadBoardList(projectID: projectID, page: page)
            }
        }
    }
}

struct CropListView_Previews: PreviewProvider {
    
    static var previews: some View {
//        let project = ProjectListResponse(name: "testname", startDate: "2020.01.01", endDate: "2020.01.02", cropType: "팥", error: nil)
        BoardListView()
    }
}
