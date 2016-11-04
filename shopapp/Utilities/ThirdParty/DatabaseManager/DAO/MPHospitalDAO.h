//
//  MPHospitalDAO.h
//  Misepuri
//
//  Created by TUYENBQ on 12/12/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "BaseDAO.h"
#import "MPHospitalObject.h"
@interface MPHospitalDAO : BaseDAO
+ (MPHospitalDAO*) sharedInstance;
- (NSArray*) listHospitalHistory25DaysAgo: (NSString*) datePast current: (NSString*) currentDate;
- (NSArray*) listHospitalOrderBy;
- (NSArray*) getNumber;
@end
