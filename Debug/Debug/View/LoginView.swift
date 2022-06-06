//
//  ContentView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct LoginView: View {

    @State var mainScreenOn = false
    @State var cnt = 0
    
    @State var showingSignUpView = false
    @State var loginPossibility = false
    
    @State var username = ""
    @State var password = ""
    
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        ZStack {
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
                                    .autocapitalization(.none)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.default)
                                    .padding(.vertical)
                                    .disableAutocorrection(true)

                                
                                SecureField("비밀번호", text: $password)
                                    .keyboardType(.default)
                                    .textFieldStyle(.roundedBorder)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
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
                                    print("로그인 시도")
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
            .onChange(of: loginVM.loginResult) { _ in
                if loginVM.loginResult == true {
                    withAnimation {
                        loginPossibility = true
                    }
                }
            }
            
            if !mainScreenOn {
                StartView()
            }
        }
        .onAppear {
            if cnt == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        mainScreenOn.toggle()
                    }
                }
                cnt += 1//이렇게 안하면 첫화면일때 계속 로티이미지 떠버려서 막음
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
