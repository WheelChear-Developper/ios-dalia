//
//  MPMemberCardObject.h
//  Misepuri
//
//  Created by AMA on 2016/09/04.
//

#import <Foundation/Foundation.h>

@interface MPMemberCardObject : NSObject

@property (nonatomic, strong) NSString* qrcode;
@property (nonatomic, strong) NSString* member_name;
@property (nonatomic) long name_disp;
@property (nonatomic, strong) NSString* rank_name;
@property (nonatomic, strong) NSString* rank_color;
// INSERTED BY M.FUJII 2016.12.06 START
@property (nonatomic) long rank_id;
// INSERTED BY M.FUJII 2016.12.06 END

@end
