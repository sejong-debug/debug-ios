//
//  ProjectListView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct ProjectListView: View {
    @State private var showingLogoutAlert = false
    @State private var showingIssueAlert = false
    @State var logoutPossibility = false
    @State var issuePossibility = false
    @State var projectList: [String] = []
    //실제로 ProjectListView 등장할때 onappear를 통해 projectList를 서버에서 받아와야함
    @ObservedObject var projectListVM = ProjectListViewModel()
    @State var page = 1 //서버에 요청 페이지
    let spaceName = "scroll"

    @State var wholeSize: CGSize = .zero
    @State var scrollViewSize: CGSize = .zero
    
    let sesame = Image("참깨 이모지")
    let adzukiBeans = Image("팥 이모지")
    let bean = Image("콩 이모지")
    
    let image = Image(systemName: "plus.circle")
    
    var dateformat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd"
        return formatter
    }
    
    func selectCropType(_ cropType: String) -> some View {
        
        if cropType == "팥" {
            return   adzukiBeans
                .resizable()
                .frame(width: 60, height: 60)
        } else if cropType == "콩" {
            return   bean
                    .resizable()
                    .frame(width: 60, height: 60)
        } else {
            return   sesame
                    .resizable()
                    .frame(width: 60, height: 60)
        }
    }
    
    var body: some View {
        ZStack {
            NavigationLink(isActive: $logoutPossibility) {
                LoginView()
            } label: { }
//            NavigationLink(isActive: $issuePossibility) {
//                createMemoView()
//            } label: { }
            Circle()
                .frame(width: 310, height: 310)
                .foregroundColor(.green)
                .position(x: 60, y: 60)
            VStack {
                HStack {
//                    Image(systemName: "text.justify")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .onTapGesture {
//                            showingIssueAlert = true
//                        }
                    Spacer()
//                    Image(systemName: "multiply")
//                        .resizable()
//                        .frame(width: 20, height: 20)
//                        .padding(.trailing)
//                        .onTapGesture {
//                            showingLogoutAlert = true
//                        }
                }
                TextCompose()
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                if !projectListVM.projectListData.isEmpty {//사실 true 가 아니고 projectList가 비어있지 않은 상태를 나타내야함
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(Color(hue: 0.054, saturation: 0.0, brightness: 0.724))
                    ChildSizeReader(size: $wholeSize) {
                        ScrollView {
                            ChildSizeReader(size: $scrollViewSize) {
                                VStack(spacing: 20) {
                                    ForEach(projectListVM.projectListData.flatMap{ $0 }, id: \.self) { project in
                                        NavigationLink(destination: {
                                            //BoardListView로 이동해야함
                                        }, label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .foregroundColor(Color(red: 0.969, green: 0.969, blue: 0.969))
                                                    .frame(height: 80)
                                                    .shadow(color: .gray, radius: 1, x: 0, y: 5)
                                                RoundedRectangle(cornerRadius: 15)
                                                    .stroke(lineWidth: 1)
                                                    .foregroundColor(.gray)
                                                    .frame(height: 80)

                                                HStack {
                                                    VStack (alignment: .leading) {
                                                        Text("no title")
                                                        Text("작물: \(project.cropType)")
                                                        Text("\(project.startDate ) ~ \(project.endDate)")
                                                    }
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 15))
                                                    Spacer()
                                                    if let cropType = project.cropType {
                                                        selectCropType(cropType)
                                                    }
                                                }
                                                .padding()
                                                }//ZStack
                                            })
                                    }
                                }
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
                                            projectListVM.loadProjectList(page: page)
                                            page += 1
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
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(Color(hue: 0.054, saturation: 0.0, brightness: 0.724))
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
        .alert("로그아웃 하시겠습니까?", isPresented: $showingLogoutAlert) {
            Button("아니오", role: .cancel) {}
            Button("네", role: .destructive) { logoutPossibility = true }
        }
        .alert("등록된 작물의 질병을 조회하시겠습니까?", isPresented: $showingIssueAlert) {
            Button("아니오", role: .cancel) {}
            Button("네", role: .destructive) { issuePossibility = true }
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
        ProjectListView()
    }
}
