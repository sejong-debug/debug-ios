//
//  CropListView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/13.
//

import SwiftUI

struct BoardListView: View {
    @Environment(\.dismiss) var dismiss
    @State var showingConfirmation = false
    @State var showingImagePopUp = false
    
    let image = Image(systemName: "plus.circle")
    
    @State var createBoardIsActive = false
    @State var goToDetectView = false
    
    @State var isActive = false
    
    @State var page = 0
    @State var logoutPossibility = false
    @State var goToStatics = false
    let spaceName = "scroll"

    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    @State var projectID: Int = 0
    @State var completed: Bool = false
    //완료 여부 받기
    @ObservedObject var boardListVM = BoardListViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                
                NavigationLink(isActive: $logoutPossibility) {
                    LoginView()
                } label: { }
                NavigationLink(isActive: $goToStatics) {
                    StatisticsView()
                } label: { }
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text("게시글 목록")
                            .fontWeight(.bold)
                        Spacer()

                        Image(systemName: "list.bullet")
                            .onTapGesture {
                                showingConfirmation = true
                            }
                            .confirmationDialog("원하는 기능을 선택하세요.", isPresented: $showingConfirmation) {
                                
                                Button("로그아웃") {
                                    var transaction = Transaction(animation: .linear)
                                    transaction.disablesAnimations = true

                                    withTransaction(transaction) {
                                        logoutPossibility = true
                                    }
                                }
                                Button("통계확인하기") {
                                    goToStatics = true
                                }
                            }
                        
                    }
                    .padding([.leading,.trailing,.bottom])
                    if !boardListVM.boardListData.isEmpty {
                        ChildSizeReader(size: $wholeSize) {
                            ScrollView {
                                ChildSizeReader(size: $scrollViewSize) {
                                    VStack(spacing: 20) {
                                        HStack {
                                            Text("total disease:")
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(.black)
                                            Text("\(boardListVM.diseaseCount ?? 0)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.red)
                                            Spacer()
                                            Button {
                                                //완료 action
                                                boardListVM.modifyCompleted(completed: completed)
                                                completed.toggle()
                                            } label: {
                                                Text("프로젝트 완료")
                                                Image(systemName: completed == false ? "rectangle" : "checkmark.rectangle")
                                            }
                                            .foregroundColor(completed == false ? .black : .gray )
                                        }
                                        ForEach(boardListVM.boardListData.flatMap{ $0 }, id: \.self) { board in
                                            NavigationLink(destination: {
                                                DetectView(projectID: projectID, boardID: board.boardID)
                                            }, label: {
                                                HStack {
                                                    AsyncImage(url: URL(string: board.boardImageURI)) { image in
                                                        image
                                                            .resizable()
                                                            .frame(width: 80, height: 80)
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                    Spacer()
                                                    VStack {
                                                        Spacer()
                                                        HStack {
                                                            Spacer()
                                                            Text("자세히 보기>")
                                                                .font(.system(size: 15))
                                                                .foregroundColor(.black)
                                                        }
                                                        Divider()
                                                    }
                                                }
                                                .frame(height:90)
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
            boardListVM.boardListData = []
            for i in 0 ... page {
                boardListVM.loadBoardList(projectID: projectID, page: i)
            }
            boardListVM.loadDeseaseCount(projectID: projectID)
        }
    }
}

struct CropListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let boardListVM = BoardListViewModel()
        boardListVM.boardListData.append([BoardListResponse.Content(boardID: 3, memo: "게시글 또 작성", boardImageID: 3, boardImageURI: "https://picsum.photos/200/300/?blur=2"),BoardListResponse.Content(boardID: 3, memo: "게시글 작성", boardImageID: 3, boardImageURI: "https://picsum.photos/200/300?grayscale")])
        return BoardListView(boardListVM: boardListVM)
    }
}
