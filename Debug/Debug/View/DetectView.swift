//
//  DetectView.swift
//  Debug
//
//  Created by 이태현 on 2022/05/06.
//

import SwiftUI

struct DetectView: View {
    @Environment(\.dismiss) var dismiss
    @State var image: Image?
    @State var text: String?
    @State var deseaseType: String?
    
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
            }
            .padding(.vertical)
            image?
                .resizable()
                .scaledToFit()
            
            HStack {
                Text(text ?? "메모가 존재하지 않음")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundColor(.gray)
                Spacer()
            }
            HStack {
                Text(deseaseType ?? "질병이 존재하지 않아요")
                    .font(.system(size: 21, weight: .medium))
                    .foregroundColor(.gray)
                Spacer()
            }
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

struct DetectView_Previews: PreviewProvider {
    static var previews: some View {
        DetectView()
    }
}
