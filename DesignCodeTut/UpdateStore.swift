//
//  UpdateStore.swift
//  DesignCodeTut
//
//  Created by Hem Poudyal on 5/6/20.
//  Copyright © 2020 Hem Poudyal. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}

