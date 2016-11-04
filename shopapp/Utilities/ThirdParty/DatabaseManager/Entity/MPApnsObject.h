//
//  MPApnsObject.h
//  Misepuri
//
//  Created by TUYENBQ on 12/20/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "BaseEntity.h"

@interface MPApnsObject : BaseEntity
@property (nonatomic, strong) NSString *apns_id;
@property (nonatomic, strong) NSString *apns_badge;
@property (nonatomic, strong) NSString *apns_cp;
@property (nonatomic, strong) NSString *apns_type;
@end
