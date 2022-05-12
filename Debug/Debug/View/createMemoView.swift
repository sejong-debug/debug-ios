//
//  IssueView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/31.
//

import SwiftUI

struct createMemoView: View {
    @State var image: Image?
    @State var text: String = "메모를 작성해주세요"
    @State var tapOn: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var goToDetectView: Bool = false
    @State var checkDetect = 0
    var body: some View {
        VStack {
            NavigationLink(isActive: $goToDetectView, destination: {
                DetectView()
            }, label: {})
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.vertical)
            TextEditor(text: $text)
                .foregroundColor(tapOn ? .black : .gray)
                .background(
                    Rectangle().stroke(lineWidth: 3)
                        .foregroundColor(tapOn ? .black : .gray)
                        .shadow(color: .black, radius: 5, x: 3, y: 3)
                )
                .onTapGesture {
                    if !tapOn {
                        text = ""
                    }
                    tapOn = true
                }
            
            Spacer()
            HStack {
                Text("촬영 된\n이미지")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                image?
                    .resizable()
                    .frame(width: 140, height: 140)
            }
            .padding(.horizontal, 40)
            .padding(.vertical)
            Button {
                //이미지, 메모 서버에 전송을 하고 질병조회로 넘어가기
                goToDetectView = true
                checkDetect += 1
            } label: {
                HStack {
                    Text("이미지, 메모 저장하기")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundColor(.green)
                )
            }
        }
        .onAppear {
            if checkDetect != 0 {
                dismiss()
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        createMemoView()
    }
}
