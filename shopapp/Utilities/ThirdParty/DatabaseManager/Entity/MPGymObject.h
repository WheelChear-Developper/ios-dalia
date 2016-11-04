//
//  MPGymObject.h
//  Misepuri
//
//  Created by TUYENBQ on 12/12/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "BaseEntity.h"

@interface MPGymObject : BaseEntity
@property (nonatomic, strong) NSString *gym_id;
@property (nonatomic, strong) NSString *gym_date;
@property (nonatomic, strong) NSString *gym_image;
@property (nonatomic, strong) NSString *gym_weight;
@property (nonatomic, strong) NSString *gym_check1;
@property (nonatomic, strong) NSString *gym_check2;
@property (nonatomic, strong) NSString *gym_check3;
@end
