//
//  AddView-ViewModel.swift
//  Bucketlist
//
//  Created by Juan Ramón del Caño Vega on 3/3/24.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }

        var name: String
        var description: String
        var loadingState = LoadingState.loading
        var pages: [Page]
        
        init(name: String, description: String) {
            self.name = name
            self.description = description
            self.pages = [Page]()
            self.loadingState = .loading
        }
    }
}
