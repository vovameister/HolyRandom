//
//  SubscriptionView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 23.9.24..
//

import SwiftUI
import StoreKit

struct SubscriptionView: View {
    var body: some View {
        ZStack {
            
        }
        if #available(iOS 17.0, *) {
            SubscriptionStoreView(groupID: "593735C0")
        }
    }
}
#Preview {
    SubscriptionView()
}
