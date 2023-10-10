//
//  CharacterMatchView.swift
//  SwiftUIRoute
//
//  Created by 梁泽 on 2023/10/9.
//

import SwiftUI
import TagCloud

struct CharacterMatchView: View {
    @StateObject var vm = CharacterMatchViewModel()
    
    var body: some View {
        NDScaffold(
            isShowLoading: vm.isLoading,
            topBar: {
                NDNavBar {
                    Text("性格匹配")
                        .ndfont(.title2, textColor: .f1)
                        .fontWeight(.bold)
                }
            }
        ) {
            VStack {
                TagCloudView(data: vm.characters,verticalSpacing: NDPadding.mid, horizontalSpacing: NDPadding.mid) { tag in
                    let isSelected = vm.selectedCharacters.contains(tag)
                    let contentColor: Color = isSelected ? .acc1 : .f2
                    Button {
                        vm.clickTag(tag)
                    } label: {
                        Text(tag)
                            .ndfont(.body1, textColor: contentColor)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(contentColor.opacity(0.08))
                            .cornerRadius(6)
                    }
                }
                Spacer()
                Button {
                    vm.submit()
                } label: {
                    Text("确定").ndlarge()
                }
                .ndbuttonstyle()
                
            }
            .padding(.all, NDPadding.content)
            
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


class CharacterMatchViewModel: BaseViewModel {
    @Published var characters = [String]()
    @Published var selectedCharacters = [String]()
    
    override init() {
        super.init()
        requestData()
    }
    
    func requestData() {
        requestState = .loading
        Task {
            let result = await GlobalDataStore.shared.fetchCharactersIfNeed()
            DispatchQueue.main.sync {
                requestState = .ok
                characters = result
            }
        }
    }
    
    func clickTag(_ tag: String)  {
        let isCurrentSelected = selectedCharacters.contains(tag)
        if isCurrentSelected {
            selectedCharacters.removeAll(tag)
        } else {
            selectedCharacters.append(tag)
        }
    }
    
    func submit() {
        requestState = .loading
        let target = PetApi.characterMatch(.init(characters: selectedCharacters))
        Networking.requestObject(target, modeType: PetModel.self, atKeyPath: "data.pet", completion: { [weak self] _, pet in
            guard let self = self else { return }
            self.requestState = .ok
            guard let pet = pet else {
                NDToast.show(text: "性格匹配失败~")
                return
            }
            RouteStore.shared.push(PetRecommendView(pet: pet))
        })
    }
}
