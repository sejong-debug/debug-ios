//
//  ImagePopUpView.swift
//  Debug
//
//  Created by 이태현 on 2022/04/15.
//

import SwiftUI

struct ImagePopUpView: View {
    
    @Binding var showing: Bool
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showCaptureImageView = false
    @State private var createBoardIsActive = false
    
    var body: some View {
        ZStack {
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
                .ignoresSafeArea()
            }
            NavigationLink(isActive: $createBoardIsActive, destination: {
                createMemoView(image: image)//여기 isActive설정하자
            }, label: {
                
            })
            if showing {
                Color.black.opacity(showing ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                ZStack {
                    Color.white
                    VStack {
                        HStack {
//                            image?
//                                .resizable()
//                                .scaledToFit()
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
                            Button {
                                //사진 불러오기 action
                                showingImagePicker = true
                            } label: {
                                ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(.purple)
                                Text("사진 불러오기") //사진 불러오기 action 해야함
                                    .foregroundColor(.white)
                                    .fontWeight(.medium)
                                }
                            }
                            Spacer()
                            Button {
                                self.showCaptureImageView.toggle()
                                showing = false
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(.blue)
                                    Text("사진 촬영하기") //사진 촬영하기 action 해야함
                                        .foregroundColor(.white)
                                        .fontWeight(.medium)
                                }
                            }

                        }
                        .frame(height: 40)
                        .padding()
                    }
                }
                .frame(width: 300, height: 150)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in
            loadImage()
            showing = false
        }//이미지 load하기보다는   NavigationLink를 위한 매개변수 설정하기
        .onChange(of: image) { _ in
            createBoardIsActive = true
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePopUpView(showing: .constant(true))
    }
}
