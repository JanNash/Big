//
//  Big.swift
//  
//
//  Created by Jan Nash on 28.11.20.
//

class Number {
    struct Digit: Hashable {
        struct Value {
            private(set) var representation: String
            private(set) var offset: UInt
        }
        
        class ValueSet {
            init(_ representations: [String]) {
                var offset: UInt = 0
                values = representations.reduce(into: (values: [], dupeControlCache: [String: Any]()), {
                    guard $0.dupeControlCache[$1] == nil else { fatalError() }
                    $0.dupeControlCache[$1] = true
                    $0.values.append(Value(representation: $1, offset: offset))
                    let (newOffset, overflow) = offset.addingReportingOverflow(1)
                    guard !overflow else { fatalError() }
                    offset = newOffset
                }).values
            }
            
            let values: [Value]
        }
    }
}
