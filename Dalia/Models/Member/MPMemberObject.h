//
//  MPMemberObject.h
//  Misepuri
//
//  Created by AMA on 2016/09/04.
//

#import <Foundation/Foundation.h>

@interface MPMemberObject : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *app_id;
@property (nonatomic, strong) NSString *member_no;
@property (nonatomic, strong) NSString *device_id;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic) long gender;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *child1_name;
@property (nonatomic, strong) NSString *child1_birthday;
@property (nonatomic, strong) NSString *child2_name;
@property (nonatomic, strong) NSString *child2_birthday;

@end
