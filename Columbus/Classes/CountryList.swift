//
//  CountryList.swift
//  Columbus
//
//  Created by Stefan Herold on 22.06.18.
//  Copyright © 2018 CodingCobra. All rights reserved.
//

import UIKit

public struct CountryList {

    public typealias ArrayType = [Country]

    /// List of countries
    private let values: ArrayType

    init(values: ArrayType = []) {
        self.values = values
    }
}

extension CountryList: Collection {

    public typealias Index = ArrayType.Index
    public typealias Element = ArrayType.Element

    // The upper and lower bounds of the collection, used in iterations
    public var startIndex: Index { return values.startIndex }
    public var endIndex: Index { return values.endIndex }

    // Required subscript, based on a dictionary index
    public subscript(index: Index) -> Element {
        get { return values[index] }
    }

    // Method that returns the next index when iterating
    public func index(after i: Index) -> Index {
        return values.index(after: i)
    }
}

extension CountryList: Decodable {

    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var countries: [Country] = []

        while !container.isAtEnd {
            do {
                let country = try container.decode(Country.self)
                countries.append(country)
            } catch {
                print(error)
            }
        }
        self.values = countries
            .filter { $0.flagIcon.size != .zero }
            .sorted { $1.name > $0.name }
    }
}

