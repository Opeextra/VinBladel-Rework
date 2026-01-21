//
//  InProgress.swift
//  VinBladel-Rework
//
//  Created by Aadi Shah on 12/15/25.
//

import SwiftUI

struct InProgress: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("Test", destination: PartsandServices())
            }
        }
    }
}

#Preview {
    InProgress()
}
