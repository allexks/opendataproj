//
//  StationLocation.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation
import CoreLocation

enum StationLocation: String {
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
    case staraZagora = "Стара Загора - Зелен Клин"
    case haskovo = "Хасково - РИОСВ"
    case yundola = "Юндола - ЕС2"
    case burgasHeavyMetal = "пункт Бургас - тежки метали"
    case galabovo = "пункт Гълъбово"

    var location: CLLocation {
        switch self {
        case .yanaStation:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sofiaDruzhba:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sofiaPavlovo:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sofiaMladost:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sofiaNadezhda:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sofiaHipodruma:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sofiaKopitoto:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .dolniVoden:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .plovdivKamenitsa:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .plovdivTrakia:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .varnaAngelKanchev:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .devnyaIzvorite:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .staroOryahovo:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .vTarnovo:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .vidin:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .vratsaNaGarata:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .gOrhyahovitsa:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .baftaCity:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .lovech:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .montana:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .nikopol:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .pleven:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .ruse:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .svishtov:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .silistra:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .shumen:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .blagoevgrad:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .kardzhali:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .pernikCenter:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .pernikCrkva:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .pirdop:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .rozhen:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .smolyan:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .burgasDolnoEzerovo:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .burgasMedenRudnik:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .razhena:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .nessebar:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .sliven:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .staraZagora:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .haskovo:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .yundola:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .burgasHeavyMetal:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        case .galabovo:
            return CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
        }
    }
}
