//
//  ProjectListView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/25.
//

import SwiftUI

struct ProjectListView: View {
    @Binding var possibility: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                possibility = false
            }
    }
}

//struct ProjectListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectListView()
//    }
//}
