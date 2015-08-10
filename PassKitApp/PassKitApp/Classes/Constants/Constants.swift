//
//  Constants.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import Foundation


let PARSE_APP_KEY                               = "GqSYgMf0zJlSda3JPNImqdm97MwTYs7IArN2rfJq"
let PARSE_CLIENT_KEY                            = "DmQrGKzCOIZDBvT2liOc7h6oiIksC3NuOJB7NFtW"


enum RequestType: Int {
    case VERSION = 0
    case CATEGORY // 1
    case MALL // 2
    case BANNER
    case MALL_BANNER
    case STORE
}

enum ActionType: Int {
    case NO_ACTION = 0
    case VERSION // 1
    case CATEGORY // 2
    case MALL
    case BANNER
    case MALL_BANNER
    case STORE
    case SYNC_COMPLETE
}


let BUTTON_TEXT_OK                              = "Ok"
let NOTIFICATION_SYNC_COMPLETE                  = "NotificationIdentifierSyncComplete"

let BACK_BUTTON_IMAGE                           = "share_photo-left_button"