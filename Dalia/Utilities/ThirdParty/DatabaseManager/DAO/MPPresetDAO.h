//
//  MPPresetDAO.h
//  Misepuri
//
//  Created by TUYENBQ on 12/11/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "BaseDAO.h"
#import "MPPresetObject.h"
@interface MPPresetDAO : BaseDAO
+ (MPPresetDAO*) sharedInstance;
- (BOOL) updatePreset: (NSString*) preset_id withName: (NSString*) preset_name;
@end
