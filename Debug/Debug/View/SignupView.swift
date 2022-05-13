//
//  SignUpView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var signUpVM = SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("이름 설정")
                Spacer()
            }
            TextField("이름", text: $name)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
                
            HStack {
                Text("아이디 설정")
                Spacer()
            }
            TextField("아이디", text: $username)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
                
            HStack {
                Text("비밀번호 설정")
                Spacer()
            }
            TextField("비밀번호", text: $password)
                .keyboardType(.default)
                .textFieldStyle(.roundedBorder)
            Button {
                signUpVM.signUp(username: username, password: password, name: name)
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(name.count==0 || username.count == 0 || password.count == 0
                                         ? .gray : .green)
                    Text("회원가입 완료")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .disabled(name.count==0 || username.count == 0 || password.count == 0)
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
