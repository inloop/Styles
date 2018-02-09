//  Copyright © 2018 Inloop, s.r.o. All rights reserved.

import Foundation

struct WritableKeyPathApplicator<Type> {
    private let applicator: (Type, Any) -> Type
    init<ValueType>(_ keyPath: WritableKeyPath<Type, ValueType>) {
        applicator = { type, value in
            var instance = type
            if let value = value as? ValueType {
                instance[keyPath: keyPath] = value
            }
            return instance
        }
    }

    @discardableResult
    func apply(value: Any, to: Type) -> Type {
        return applicator(to, value)
    }
}
