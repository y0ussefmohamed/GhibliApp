//
//  downloadingState.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation

enum LoadingState<T: Equatable> {
    case idle
    case loading
    case success(T)
    case failure(Error)
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var data: T? {
        if case .success(let value) = self { return value }
        return nil
    }
    
    var error: String? {
        if case .failure(let message) = self { return message.localizedDescription }
        return nil
    }
}
