//
//  Data.swift
//  RevivingCultureHeritage
//
//  Created by 김동현 on 2023/04/15.
//

import Foundation
import SwiftUI

let detailViewBackgroundScreen: [String] = ["DetailViewBack_BlueW", "DetailViewBack_GreenW", "DetailViewBack_OrangeW", "DetailViewBack_RedW", "DetailViewBack_WhiteB"]


struct Heritage: Identifiable {
    var id: Int
    var title: String
    let author: String
    let image: String // Image 변경 필요
    let backgroundSound: String
    let effectSound: String
    let fragment: String // Image 변경 필요
    let color: Color
}

class Store: ObservableObject {
    @Published var items: [Heritage]
    
    // data
    init() {
        items = [
            Heritage(id: 0, title: "Ssileum", author: "HongdoKim", image: "Ssileum", backgroundSound: "SsileumBGM", effectSound: "SsileumSFX", fragment: "SsileumFrag", color: Color.white),
            Heritage(id: 1, title: "Yuchnoli", author: "HongdoKim", image: "2", backgroundSound: "YuchnoliBGM", effectSound: "YuchnoliSFX", fragment: "YuchnoliFrag", color: Color.white),
            Heritage(id: 2, title: "Jegichagi", author: "JunkeunKim", image: "3", backgroundSound: "JegichagiBGM", effectSound: "JegichagiSFX", fragment: "JegichagiFrag", color: Color.white),
            Heritage(id: 3, title: "Sulyeobdo", author: "unknown", image: "4", backgroundSound: "SulyeobdoBGM", effectSound: "SulyeobdoSFX", fragment: "SulyeobdodoFrag", color: Color.white),
            Heritage(id: 4, title: "Dano", author: "YoonbokSin", image: "5", backgroundSound: "DanoBGM", effectSound: "DanoSFX", fragment: "DanoFrag", color: Color.white),
            Heritage(id: 5, title: "Tuho", author: "YoonbokSin", image: "6", backgroundSound: "TuhoBGM", effectSound: "TuhoSFX", fragment: "TuhoFrag", color: Color.white),
            Heritage(id: 6, title: "Baenoli", author: "YoonbokSin", image: "7", backgroundSound: "BaenoliBGM", effectSound: "BaenoliSFX", fragment: "BaenoliFrag", color: Color.white)
        ]
    }
}
