//
//  MPMemberObject.h
//  Misepuri
//
//  Created by AMA on 2016/09/04.
//

#import <Foundation/Foundation.h>

@interface MPMemberObject : NSObject

@property (nonatomic, strong) NSString *fld_nick_name;
@property (nonatomic, strong) NSString *fld_gender;
@property (nonatomic, strong) NSString *fld_mail;
@property (nonatomic, strong) NSString *fld_job;
@property (nonatomic, strong) NSString *fld_zipcode;
@property (nonatomic, strong) NSString *fld_address;
@property (nonatomic, strong) NSString *fld_name1;
@property (nonatomic, strong) NSString *fld_name2;
@property (nonatomic, strong) NSString *fld_furigana1;
@property (nonatomic, strong) NSString *fld_furigana2;
@property (nonatomic, strong) NSString *fld_tel;
@property (nonatomic, strong) NSString *fld_generation;
@property (nonatomic, strong) NSString *fld_shop;
@property (nonatomic, strong) NSString *fld_birthday;

@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic) long gender;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *zipcode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name1;
@property (nonatomic, strong) NSString *name2;
@property (nonatomic, strong) NSString *furigana1;
@property (nonatomic, strong) NSString *furigana2;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *generation;
@property (nonatomic, strong) NSString *shop;
@property (nonatomic, strong) NSString *birthday;

@property (nonatomic, strong) NSString *details;

@property (nonatomic) long sortno_nick_name;
@property (nonatomic) long sortno_gender;
@property (nonatomic) long sortno_mail;
@property (nonatomic) long sortno_job;
@property (nonatomic) long sortno_zipcode;
@property (nonatomic) long sortno_address;
@property (nonatomic) long sortno_name;
@property (nonatomic) long sortno_furigana;
@property (nonatomic) long sortno_tel;
@property (nonatomic) long sortno_generation;
@property (nonatomic) long sortno_shop;
@property (nonatomic) long sortno_birthday;

@end
