//
//  Big.swift
//  
//
//  Created by Jan Nash on 28.11.20.
//

class Number {
    struct Digit: Hashable {
        struct Value: Equatable {
            private(set) var representation: String
            private(set) var offset: UInt
        }
        
        class ValueSet {
            enum InitError: Error {
                case duplicateRepresentation(String)
                case offsetOverflow
            }
            
            init(_ representations: [String]) throws {
                var offset: UInt = 0
                values = try representations.reduce(into: (values: [], dupeControlCache: [String: Any]()), {
                    guard $0.dupeControlCache[$1] == nil else { throw InitError.duplicateRepresentation($1) }
                    $0.dupeControlCache[$1] = true
                    $0.values.append(Value(representation: $1, offset: offset))
                    let (newOffset, overflow) = offset.addingReportingOverflow(1)
                    guard !overflow else { throw InitError.offsetOverflow }
                    offset = newOffset
                }).values
            }
            
            let values: [Value]
        }
    }
}
