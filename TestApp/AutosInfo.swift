//
//  AutosInfo.swift
//  TestApp
//
//  Created by Александр Шубский on 14.10.2019.
//  Copyright © 2019 Александр Шубский. All rights reserved.
//

import Foundation
class AutosInfo: NSObject {
    static var autoInfo: [String: [String: String]] = ["LADA Kalina": ["Manufacturer": "АвтоВаз",
                                                                       "Year": "2010",
                                                                       "Color": "Красный",
                                                                       "Body": "Седан"],
                                                       "BMW X6": ["Manufacturer": "BMW",
                                                                  "Year": "2014",
                                                                  "Color": "Белый",
                                                                  "Body": "Кроссовер"],
                                                       "Audi A8": ["Manufacturer": "Audi",
                                                                   "Year": "2019",
                                                                   "Color": "Серый",
                                                                   "Body": "Седан"]]
}
