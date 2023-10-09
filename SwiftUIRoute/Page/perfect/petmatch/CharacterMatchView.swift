//
//  CharacterMatchView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI

struct CharacterMatchView: View {
    var body: some View {
        NDScaffold(
            topBar: {
                NDNavBar {
                    Text("性格匹配")
                        .ndfont(.title2, textColor: .f1)
                        .fontWeight(.bold)
                }
            }
        ) {
            VStack {
                Text("123")
                    .ndfont(.body1, textColor: .f1)
            }
        }
    }
}

extension CharacterMatchView : Routable {
    var page: Route.Page { .charachterMatch }
}

struct CharacterMatchView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterMatchView()
    }
}
