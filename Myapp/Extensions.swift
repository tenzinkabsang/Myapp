//
//  Extensions.swift
//  Myapp
//
//  Created by Tenzin Kabsang on 1/27/22.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
    func weakAssign<T: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<T, Output>,
        on object: T
    ) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
