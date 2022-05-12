//
//  ContentView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct LoginView: View {

    @State var showingSignUpView = false
    @State var loginPossibility = false
    
    @State var username = ""
    @State var password = ""
    
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        NavigationView {
                if loginPossibility == false {
                    ZStack {
                        VStack {
                            VStack() {
                                HStack {
                                    Text("나만의")
                                    Spacer()
                                }
                                HStack {
                                    Text("농작물")
                                    Spacer()
                                }
                                HStack {
                                    Text("관리")
                                    Spacer()
                                }
                            }
                            .padding(.leading, 20)
                            .foregroundColor(.green)
                            .font(.system(size: 50))
                            TextField("아이디", text: $username)
                                .textFieldStyle(.roundedBorder)
                                .padding(.vertical)
                            TextField("비밀번호", text: $password)
                                .textFieldStyle(.roundedBorder)
                            
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation {
                                        showingSignUpView = true
                                    }
                                } label: {
                                    Text("회원가입")
                                        .foregroundColor(.gray)
                                }
                                .sheet(isPresented: $showingSignUpView) {
                                    SignupView()
                                }
                            }
                            
                            Button {
                                loginVM.login(username: username, password: password)
                                //로그인 action
//                                loginVM.login()
//                                Task {
//                                    withAnimation {
//                                        loginPossibility = loginVM.isLogin
//                                    }
//                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.green)
                                    Text("로그인")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                            }
                            .frame( height: 45)
                            Spacer()
                        }
                        .padding()
                    }
                } else {
                    withAnimation {
                        ProjectListView()
                    }
                }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation {
                loginPossibility = false
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
