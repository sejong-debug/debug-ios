//
//  IssueView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/31.
//

import SwiftUI

struct createBoardView: View {
    @State var image: Image?
    @State var text: String = "메모를 작성해주세요."
    @State var tapOn: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var goToDetectView: Bool = false
    @State var checkDetect = 0
    
    @ObservedObject var boardCreateVM = boardCreateViewModel()
    
    @State var projectID: Int = 0
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $goToDetectView, destination: {
                DetectView(projectID: projectID, boardID: boardCreateVM.boardID)
            }, label: {})
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.black)
                        .font(.system(size: 22, weight: .semibold))
                }
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
                let UIImage = image!.asUIImage()
                let data = UIImage.jpegData(compressionQuality: 1)
//                let data = UIImage.pngData()
//                let data = UIImage.jpegData(compressionQuality: 1)
                let createBoardRequest = createBoardRequest(memo: text, image: data!)

                boardCreateVM.uploadBoard(createBoard: createBoardRequest, projectID: projectID)

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
        .onChange(of: boardCreateVM.boardID) { _ in
            goToDetectView = true
            checkDetect += 1
        }
        .padding()
        .navigationBarHidden(true)
    }
}
extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)

        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
//        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)//ios 15에서 못씀
        window!.rootViewController?.view.addSubview(controller.view)//그래서 바꿔줌
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()

// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        createBoardView()
    }
}
