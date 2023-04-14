//
//  SsileumView.swift
//  RevivingCultureHeritage
//
//  Created by 김동현 on 2023/04/13.
//

import SwiftUI
import Foundation

struct DetailView: View {
    var body: some View {
        ZStack {
            Image("Ssileum")
                .resizable()
                .overlay {
                    Button("dsfsdfs", action: {
                        
                    })
                }
//            Text(item.title)
//                .fontWeight(.bold)
//                .font(.system(size: 72, weight: .heavy, design: .serif))
//                .padding()
//                .foregroundColor(item.color)
        }
        .frame(width: UIScreen.main.bounds.size.width / 1.25, height: UIScreen.main.bounds.size.height / 1.25)
        .background(
            Image("DetailViewBack")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.9)
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
