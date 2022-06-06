//
//  DetectView.swift
//  Debug
//
//  Created by 이태현 on 2022/05/06.
//

import SwiftUI

struct DetectView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var projectID: Int?
    @State var boardID: Int?
    
    @State var check = false
    
    @ObservedObject var boardVM = BoardViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("게시글 조회")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "arrow.backward")
                    .opacity(0)
            }
            if boardVM.boardData == nil {
                Spacer()
                ProgressView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            check = true
                         }
                    }
                Spacer()
            } else {
                AsyncImage(url: URL(string: boardVM.boardData!.boardImageURI)) { image in
                    image
                        .resizable()
                        .frame(width: 390, height: 390)
                } placeholder: {
                    ProgressView()
                }//이부분 처리해줘야함
                HStack {
                    Text(boardVM.boardData!.memo)
                        .font(.system(size: 21, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        if boardVM.boardData!.issues.count == 0 {
                            Text("질병이 존재하지 않아요")
                                .font(.system(size: 21, weight: .medium))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        } else {
                            ForEach(boardVM.boardData!.issues, id: \.self) { issue in
                                Text(issue)
                                    .font(.system(size: 21, weight: .medium))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                }
                Spacer()
            }
        }
        .padding([.leading,.trailing,.bottom])
        .navigationBarHidden(true)
        .onAppear {
            boardVM.boardLoad(projectID: projectID!, boardID: boardID!)
        }
        .onChange(of: check) { _ in
            boardVM.boardLoad(projectID: projectID!, boardID: boardID!)
        }
    }
}

struct DetectView_Previews: PreviewProvider {
    static var previews: some View {
        let boardVM = BoardViewModel()
        boardVM.boardData = BoardResponse.DataClass(boardID: 1, memo: "기록", boardImageID: 1, boardImageURI: "https://picsum.photos/seed/picsum/200/300", issues: ["질병1","질병2"])
        return DetectView(boardVM: boardVM)
    }
}
