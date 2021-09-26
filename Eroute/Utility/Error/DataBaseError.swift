//
//  DataBaseError.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation


enum DataBaseError: Error {
    case badExcess
    case noDataFound(String)
}
