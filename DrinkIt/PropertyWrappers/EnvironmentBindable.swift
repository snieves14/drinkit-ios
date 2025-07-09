//
//  EnvironmentBindable.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

@propertyWrapper
struct EnvironmentBindable<T: Observable & AnyObject>: DynamicProperty {
    
    @Environment(T.self) private var object
    
    var wrappedValue: T {
        _object.wrappedValue
    }
    
    var projectedValue: Bindable<T> {
        @Bindable var wrappedValue = wrappedValue
        return $wrappedValue
    }
    
}
