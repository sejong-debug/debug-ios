//
//  ProjectListView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct ProjectListView: View {
    @State var showingConfirmation = false
    @State var logoutPossibility = false
    @State var goToStatics = false
    @ObservedObject var projectListVM = ProjectListViewModel()
    @State var page = 0 //서버에 요청 페이지
    let spaceName = "scroll"

    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    @State var projectID: Int = 0
    
    let image = Image(systemName: "plus.circle")
    
    var dateformat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }
    
    var body: some View {
        ZStack {
            NavigationLink(isActive: $logoutPossibility) {
                LoginView()
            } label: { }
            NavigationLink(isActive: $goToStatics) {
                StatisticsView()
            } label: { }

            VStack {
                HStack {
                    Image(systemName: "list.bullet")
                        .opacity(0)
                    Spacer()
                    Text("프로젝트 목록")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
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
                .padding(.horizontal)

                if !projectListVM.projectListData.isEmpty {
                    ChildSizeReader(size: $wholeSize) {
                        ScrollView {
                            ChildSizeReader(size: $scrollViewSize) {
                                VStack {
//                                    HStack {
//                                        Text("total disease:")
//                                            .font(.system(size: 14, weight: .medium))
//                                            .foregroundColor(.black)
//                                        Text("\(projectListVM.diseaseCount ?? 0)")
//                                            .font(.system(size: 14, weight: .medium))
//                                            .foregroundColor(.red)
//                                        Spacer()
//                                    }
//                                    .padding([.leading, .trailing, .top])
                                    ForEach(projectListVM.projectListData.flatMap{ $0 }, id: \.self) { project in
                                        NavigationLink(destination: {
                                            let projectID = project.projectID
                                            BoardListView(projectID: projectID)
                                        }, label: {
                                            HStack {
                                                VStack (alignment: .leading) {
                                                    HStack {
                                                        Text(project.name)
                                                            .font(.system(size: 16, weight: .bold))
                                                            .foregroundColor(project.completed == false ? .green : .gray)
                                                        Text("작물: \(project.cropType)")
                                                            .font(.system(size: 12, weight: .semibold))
                                                            .foregroundColor(project.completed == false ? .black : .gray)
                                                        Spacer()
                                                        Text(project.completed == true ? "프로젝트 완료" : "프로젝트 진행중")
                                                            .foregroundColor(project.completed == false ? .black : .gray)
                                                    }
                                                    HStack {
                                                        if project.startDate == nil {
                                                            Text("날짜를 선택안한상태입니다.")
                                                                .foregroundColor(project.completed == false ? .black : .gray)
                                                        } else {
                                                            Text("\(project.startDate ?? "" ) ~ \(project.endDate ?? "" )")
                                                                .foregroundColor(project.completed == false ? .black : .gray)
                                                        }
                                                        Spacer()
                                                        Text("프로젝트로 이동하기>")
                                                            .font(.system(size:15, weight: .semibold))
                                                            .foregroundColor(project.completed == false ? .black : .gray)
                                                    }
                                                    Divider()
                                                }
                                                .foregroundColor(.black)
                                                .font(.system(size: 15))
                                                Spacer()
                                            }
                                            .padding([.horizontal, .top])
                                        })
                                    }
                                }//VStack
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
                                            page += 1
                                            projectListVM.loadProjectList(page: page)
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
                } else {
                    Spacer()
                    Text("프로젝트가 존재하지 않습니다.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("오른쪽 아래 \(image) 버튼을 통해 생성해주세요.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    NavigationLink {
                        ProjectCreateView()
                    } label: {
                        image
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                    }
                }
                .padding(.trailing)
                .frame(height:40)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            if page == 0 {
                projectListVM.loadProjectList(page: page)
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
  typealias Value = CGFloat
  static var defaultValue = CGFloat.zero
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value += nextValue()
  }
}

struct ChildSizeReader<Content: View>: View {
  @Binding var size: CGSize

  let content: () -> Content
  var body: some View {
    ZStack {
      content().background(
        GeometryReader { proxy in
          Color.clear.preference(
            key: SizePreferenceKey.self,
            value: proxy.size
          )
        }
      )
    }
    .onPreferenceChange(SizePreferenceKey.self) { preferences in
      self.size = preferences
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero

  static func reduce(value _: inout Value, nextValue: () -> Value) {
    _ = nextValue()
  }
}

struct TextCompose: View {
    var body: some View {
        HStack {
            Text("나의")
            Spacer()
        }
        HStack {
            Text("프로젝트")
            Spacer()
        }
        HStack {
            Text("목록")
            Spacer()
        }
        .padding(.bottom, 70.0)
    }
}



struct ProjectListView_Previews: PreviewProvider {
    
    static var previews: some View {
        let projectListVM = ProjectListViewModel()
        projectListVM.projectListData.append([ProjectListResponse.Content(
                                                                        projectID: 1,
                                                                        name: "projectName1",
                                                                        cropType: "팥",
                                                                        startDate: "2021-01-01",
                                                                        endDate: "2021-01-15",
                                                                        completed:false),
                                              ProjectListResponse.Content(
                                                                        projectID: 2,
                                                                        name: "projectName2",
                                                                        cropType: "콩",
                                                                        startDate: "2022-03-05",
                                                                        endDate: "2022-03-05",
                                                                        completed: true)])
        return ProjectListView(projectListVM: projectListVM)
    }
}
