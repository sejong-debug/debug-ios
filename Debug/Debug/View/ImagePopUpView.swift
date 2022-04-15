//
//  ImagePopUpView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/15.
//

import SwiftUI

struct ImagePopUpView: View {
    @Binding var showing: Bool
    
    var body: some View {
        ZStack {
            if showing {
                Color.black.opacity(showing ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                ZStack {
                    Color.white
                    VStack {
                        HStack {
                            Spacer()
                            Text("취소")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    showing = false
                                }
                        }
                        .padding(.trailing)
                        .padding(.top, 8)
                        Spacer()
                        Text("어떤 이미지를")
                            .font(.system(size: 17, weight: .bold))
                        Text("사용하시겠습니까?")
                            .font(.system(size: 17, weight: .bold))
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.purple)
                                Text("사진 불러오기") //사진 불러오기 action 해야함
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                            }
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.blue)
                                Text("사진 촬영하기") //사진 촬영하기 action 해야함
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                            }
                        }
                        .frame(height: 40)
                        .padding()
                    }
                }
                .frame(width: 300, height: 150)
            }
        }
    }
}

struct ImagePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePopUpView(showing: .constant(true))
    }
}
