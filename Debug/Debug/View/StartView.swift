//
//  StartView.swift
//  Debug
//
//  Created by 이태현 on 2022/06/03.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("Debug")
                .multilineTextAlignment(.center)
                .font(.system(size: 50, weight: .heavy))
                .foregroundColor(.white)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
