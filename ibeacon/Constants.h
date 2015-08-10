//
//  Constants.h
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#ifndef ibeacon_Constants_h
#define ibeacon_Constants_h

#define alertManager [TAlertManager sharedTAlertManager]

enum actionsType{
    HI = 0,
    GOOD_BYE,
    MARKET_OUTSIDE,
    CHECK_OUT_PRODUCT
} _actionsType;

#define ALERT_NOTIFICATION  @"portrait_mall_start.png"

#define NOTIF_KEY           @"notifType"
#define UUID                @"19D5F76A-FD04-5AA3-B16E-E93277163AF6"
#define BEACON_ID           @"GemTot USB"
#define BEACON_MINOR        0
#define BEACON_MAJOR        0
#define STORED_ITEMS_KEY    @"storedItems"

#endif
