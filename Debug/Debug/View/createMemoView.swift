//
//  IssueView.swift
//  Debug
//
//  Created by 이태현 on 2022/03/31.
//

import SwiftUI

struct createMemoView: View {
    @State var image: Image?
    
    var body: some View {
        VStack {
            image?.resizable().scaledToFit()
            Text("전달받은 사진")
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        createMemoView()
    }
}
