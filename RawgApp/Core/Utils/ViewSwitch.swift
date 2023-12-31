//
//  ViewSwitch.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

enum WindowRoot {
    case Tabbed
    case WithoutTabbed
}

class ViewSwitch: ObservableObject {
    public init() {}

    @Published public var showRoot: WindowRoot = .Tabbed
    public func changeRootView(to root: WindowRoot) {
        showRoot = root
    }
}
