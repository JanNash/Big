//
//  Big.swift
//  
//
//  Created by Jan Nash on 28.11.20.
//

class Number {
    struct Digit: Hashable {
        class ValueSet {
            typealias Offset = UInt16
            
            enum InitError: Error {
                case duplicateRepresentation(String)
                case offsetOverflow
            }
            
            init(_ representations: [String]) throws {
                var offset: Offset = 0
                var dupeControlCache = [String: Any]()
                (self.representations, self.offsetForRepresentation) = try representations.reduce(into: (representations: [String](), offsetForRepresentation: [String: Offset]()), {
                    guard dupeControlCache[$1] == nil else { throw InitError.duplicateRepresentation($1) }
                    dupeControlCache[$1] = true
                    
                    let (newOffset, overflow) = offset.addingReportingOverflow(1)
                    guard !overflow else { throw InitError.offsetOverflow }
                    
                    $0.representations.append($1)
                    $0.offsetForRepresentation[$1] = offset
                    offset = newOffset
                })
            }
            
            let representations: [String]
            let offsetForRepresentation: [String: Offset]
        }
    }
}
