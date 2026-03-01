//
//  downloadingState.swift
//  GhibliApp
//
//  Created by Youssef Mohamed on 01/03/2026.
//

import Foundation

enum LoadingState<T: Equatable>: Equatable {
    static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let lhsValue), .success(let rhsValue)):
            return lhsValue == rhsValue
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
    
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
