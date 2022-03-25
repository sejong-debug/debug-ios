//
//  SignUpView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var signupVM = SignupViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Text("아이디 설정")
                    .fontWeight(.medium)
                Spacer()
            }
            TextField("아이디", text: $signupVM.username)
                .textFieldStyle(.roundedBorder)
                
            HStack {
                Text("비밀번호 설정")
                    .fontWeight(.medium)
                Spacer()
            }
            TextField("비밀번호", text: $signupVM.password)
                .textFieldStyle(.roundedBorder)
            Button {
                signupVM.signup()
                Task {
                    if signupVM.isSignup == true {
                        dismiss()
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.green)
                    Text("회원가입 완료")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .frame( height: 45)
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
