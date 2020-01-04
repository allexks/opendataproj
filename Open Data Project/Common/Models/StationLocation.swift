//
//  StationLocation.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation
import CoreLocation

enum StationLocation: String, CaseIterable {
    case yanaStation = "Гара Яна"
    case sofiaDruzhba = "София - Дружба"
    case sofiaPavlovo = "София - ИАОС/Павлово"
    case sofiaMladost = "София - Младост"
    case sofiaNadezhda = "София - Надежда"
    case sofiaHipodruma = "София - Хиподрума"
    case sofiaKopitoto = "София Област - Копитото"
    case dolniVoden = "Долни Воден"
    case plovdivKamenitsa = "Пловдив - Каменица"
    case plovdivTrakia = "Пловдив - ж.к. Тракия"
    case varnaAngelKanchev = "Варна - СОУ Ангел Кънчев"
    case devnyaIzvorite = "Девня - Изворите"
    case staroOryahovo = "Старо Оряхово - ЕС3"
    case vTarnovo = "В.Търново"
    case vidin = "Видин"
    case vratsaNaGarata = "Враца - ЖП Гара"
    case gOrhyahovitsa = "Г.Оряховица"
    case baftaCity = "Добрич - ОУ Хан Аспарух"
    case lovech = "Ловеч"
    case montana = "Монтана - РИОСВ"
    case nikopol = "Никопол ДОАС - PM10"
    case pleven = "Плевен"
    case ruse = "Русе - Възраждане"
    case svishtov = "Свищов ДОАС - PM10"
    case silistra = "Силистра ДОАС S1 - PM10"
    case shumen = "Шумен"
    case blagoevgrad = "Благоевград"
    case kardzhali = "Кърджали - Студен Кладенец"
    case pernikCenter = "Перник - Център"
    case pernikCrkva = "Перник - Църква"
    case pirdop = "Пирдоп"
    case rozhen = "Рожен - КФ"
    case smolyan = "Смолян - Библиотеката"
    case burgasDolnoEzerovo = "Бургас - кв. Долно Езерово"
    case burgasMedenRudnik = "Бургас - кв. Меден Рудник"
    case razhena = "ДОАС - Ръжена"
    case nessebar = "Несебър"
    case sliven = "Сливен"
    case staraZagoraZelenKlin = "Стара Загора - Зелен Клин"
    case haskovo = "Хасково - РИОСВ"
    case yundola = "Юндола - ЕС2"
    case burgasHeavyMetal = "пункт Бургас - тежки метали"
    case galabovo = "пункт Гълъбово"
    case vitinya = "Витиня ЕС1"
    case varnaYanPallah = "Варна - Ян Палах"
    case staraZagora = "Стара Загора - РИОСВ"
    case varnaChaika = "пунтк Чайка"
    
    init(_ string: String) {
        let result = StationLocation.init(rawValue: string)
        if let result = result {
            self = result
            return
        } else {
            let stringLowercased = string.lowercased()
            for station in StationLocation.allCases {
                let rawValue = station.rawValue
                let rawValueLowercased = rawValue.lowercased()
                if stringLowercased == rawValueLowercased {
                    self = station
                    return
                }
            }
            // Second chance
            for station in StationLocation.allCases {
                let rawValue = station.rawValue
                let rawValueLowercased = rawValue.lowercased()
                if !stringLowercased.matches(rawValueLowercased).isEmpty {
                    self = station
                    return
                }
                if !rawValueLowercased.matches(stringLowercased).isEmpty {
                    self = station
                    return
                }
                for substring in stringLowercased.split(separator: " ") {
                    if !rawValueLowercased.matches(String(substring)).isEmpty {
                        self = station
                        return
                    }
                }
                for substring in stringLowercased.split(separator: "-") {
                    if !rawValueLowercased.matches(String(substring)).isEmpty {
                        self = station
                        return
                    }
                }
                for substring in stringLowercased.split(separator: "/") {
                    if !rawValueLowercased.matches(String(substring)).isEmpty {
                        self = station
                        return
                    }
                }
            }
        }
        fatalError("ne stava s \(string)")
    }

    var location: CLLocation {
        switch self {
        case .yanaStation:
            return CLLocation(latitude: 42.7297574, longitude: 23.5383588)
        case .sofiaDruzhba:
            return CLLocation(latitude: 42.6645099, longitude: 23.3963718)
        case .sofiaPavlovo:
            return CLLocation(latitude: 42.6628825, longitude: 23.2587467)
        case .sofiaMladost:
            return CLLocation(latitude: 42.6356187, longitude: 23.3496192)
        case .sofiaNadezhda:
            return CLLocation(latitude: 42.7325149, longitude: 23.2898562)
        case .sofiaHipodruma:
            return CLLocation(latitude: 42.6823683, longitude: 23.2892546)
        case .sofiaKopitoto:
            return CLLocation(latitude: 42.636741, longitude: 23.241663)
        case .dolniVoden:
            return CLLocation(latitude: 42.0248379, longitude: 24.8319173)
        case .plovdivKamenitsa:
            return CLLocation(latitude: 42.1414932, longitude: 24.7485253)
        case .plovdivTrakia:
            return CLLocation(latitude: 42.1363316, longitude: 24.7660863)
        case .varnaAngelKanchev:
            return CLLocation(latitude: 43.2246045, longitude: 27.9124399)
        case .devnyaIzvorite:
            return CLLocation(latitude: 43.2225133, longitude: 27.5942462)
        case .staroOryahovo:
            return CLLocation(latitude: 42.9908785, longitude: 27.785065)
        case .vTarnovo:
            return CLLocation(latitude: 43.0841301, longitude: 25.5981029)
        case .vidin:
            return CLLocation(latitude: 43.643743, longitude: 22.7473085)
        case .vratsaNaGarata:
            return CLLocation(latitude: 43.2086784, longitude: 23.5554695)
        case .gOrhyahovitsa:
            return CLLocation(latitude: 43.1397479, longitude: 25.6797589)
        case .baftaCity:
            return CLLocation(latitude: 43.5538635, longitude: 27.8316914)
        case .lovech:
            return CLLocation(latitude: 43.1445314, longitude: 24.6760251)
        case .montana:
            return CLLocation(latitude: 43.4142593, longitude: 23.1923832)
        case .nikopol:
            return CLLocation(latitude: 43.7016536, longitude: 24.8848242)
        case .pleven:
            return CLLocation(latitude: 43.4212345, longitude: 24.5795137)
        case .ruse:
            return CLLocation(latitude: 43.8596971, longitude: 25.969283)
        case .svishtov:
            return CLLocation(latitude: 43.6174114, longitude: 25.3041937)
        case .silistra:
            return CLLocation(latitude: 44.1112411, longitude: 27.2372469)
        case .shumen:
            return CLLocation(latitude: 43.2698552, longitude: 26.9038907)
        case .blagoevgrad:
            return CLLocation(latitude: 42.0138137, longitude: 23.077232)
        case .kardzhali:
            return CLLocation(latitude: 41.6058465, longitude: 25.637809)
        case .pernikCenter:
            return CLLocation(latitude: 42.6087974, longitude: 23.027424)
        case .pernikCrkva:
            return CLLocation(latitude: 42.5868447, longitude: 23.0954308)
        case .pirdop:
            return CLLocation(latitude: 42.7084421, longitude: 24.1568495)
        case .rozhen:
            return CLLocation(latitude: 41.6688495, longitude: 24.729649)
        case .smolyan:
            return CLLocation(latitude: 41.5768238, longitude: 24.7125472)
        case .burgasDolnoEzerovo:
            return CLLocation(latitude: 42.5194332, longitude: 27.3622905)
        case .burgasMedenRudnik:
            return CLLocation(latitude: 42.4541117, longitude: 27.4138082)
        case .razhena:
            return CLLocation(latitude: 42.5350664, longitude: 25.4875029)
        case .nessebar:
            return CLLocation(latitude: 42.6561185, longitude: 27.6945337)
        case .sliven:
            return CLLocation(latitude: 42.6654852, longitude: 26.2550227)
        case .staraZagoraZelenKlin:
            return CLLocation(latitude: 42.4315112, longitude: 25.6341975)
        case .haskovo:
            return CLLocation(latitude: 41.9328353, longitude: 25.5136389)
        case .yundola:
            return CLLocation(latitude: 42.0634575, longitude: 23.8440855)
        case .burgasHeavyMetal:
            return CLLocation(latitude: 42.4738377, longitude: 27.442166)
        case .galabovo:
            return CLLocation(latitude: 42.1437254, longitude: 25.8536469)
        case .vitinya:
            return CLLocation(latitude: 42.7814039, longitude: 23.7906892)
        case .varnaYanPallah:
            return CLLocation(latitude: 43.2186682, longitude: 27.905359)
        case .staraZagora:
            return CLLocation(latitude: 42.4193132, longitude: 25.5898422)
        case .varnaChaika:
            return CLLocation(latitude: 43.2534807, longitude: 28.0176229)
        }
    }
}
