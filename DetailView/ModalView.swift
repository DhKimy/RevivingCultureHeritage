//
//  File.swift
//  
//
//  Created by 김동현 on 2023/04/16.
//

import SwiftUI
import Foundation

struct ModalView: View {
    @Binding var isFirstTouch: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Text("Detail View")
                .padding()
            Button("Dismiss") {
                withAnimation {
                    isFirstTouch = false // isFirstTouch 변수를 false로 변경
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(width: 200, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .padding()
        .shadow(radius: 8)
        .opacity(0.6)
        .onDisappear {
            isFirstTouch = false
        }
    }
}
